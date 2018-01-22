//
//  NSObject+KVO.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/11/2.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/message.h>
#import <objc/runtime.h>
NSString *const kKVOClassPrefix = @"KVOClassPrefix_";
NSString *const kKVOAssociatedObservers = @"KVOAssociatedObservers";

@interface _ObserverInfo: NSObject
@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) ObservingBlock block;
@end

@implementation _ObserverInfo
- (instancetype)initWithObserver:(NSObject *)observer Key:(NSString *)key block:(ObservingBlock)block {
    if (self = [super init]) {
        _observer = observer;
        _key = key;
        _block = block;
    }
    return self;
}
@end

@implementation NSObject (KVO)

static Class kvo_class(id self, SEL _cmd) {
    return class_getSuperclass(object_getClass(self));
}

static void kvo_setter(id self, SEL _cmd, id newValue) {
    // 重写 setter 方法时传递进来的_cmd 就是 setter 方法
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = getterNameForSetter(setterName);
    if (!getterName) {
        return ;
    }
    // 通过 KVC 获取旧值
    id oldValue = [self valueForKey:getterName];
    // 到这一步类之间的关系是 self.isa => KVO中间类.superClass => 原类
    // 所以我们想要调用原来类的 setter 方法，只能通过 super 调用
    struct objc_super superStruct = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    // 调用原来类的 setter 方法
    objc_msgSendSuper(&superStruct, _cmd, newValue);
    
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge void*)kKVOAssociatedObservers);
    for (_ObserverInfo *observer in observers) {
        if ([observer.key isEqualToString:getterName]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                observer.block(self, getterName, oldValue, newValue);
            });
        }
    }
}

/**
 获取某个属性的 setter 方法名称字符串

 @param key 属性
 @return 属性 setter 方法字符串
 */
static NSString *setterMethodForKey(NSString *key) {
    if (key.length <= 0) {
        return nil;
    }
    
    NSString *firstLetter = [[key substringToIndex:1] uppercaseString];         // 将第一个字符大写
    NSString *remainingLetter = [key substringFromIndex:1];                     // 获取后面的字符
    NSString *setterMethod = [NSString stringWithFormat:@"set%@%@", firstLetter, remainingLetter];
    return setterMethod;
}


/**
 通过 setter 方法获得 getter 方法名

 @param setter setter 方法名
 @return getter 方法名
 */
static NSString *getterNameForSetter(NSString *setter) {
    // setter: setName:
    // 如果传递进来的 setter 方法不满足约定的 setter 规范，则返回 nil
    if (setter.length <=0 || ![setter hasPrefix:@"set"] || ![setter hasSuffix:@":"]) {
        return nil;
    }
    //
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *key = [setter substringWithRange:range];
    // 经过上两步之后 setName: => Name
    
    
    NSString *firstLetter = [[key substringToIndex:1] lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                       withString:firstLetter];
    // 经过上两步 Name => name
    return key;
}


/**
 得到一个KVO class

 @param originalClassName 原始类
 @return 生成的 KVO 中间类
 */
- (Class)makeKVOClassWithOriginalClassName: (NSString *)originalClassName {
    NSString *kvoClassName = [originalClassName stringByAppendingString:originalClassName];
    Class kvoClass = NSClassFromString(kvoClassName);
    // 如果 KVO 的类已经存在直接返回
    if (kvoClass) {
        return kvoClass;
    }
    // 没有，动态创建 KVO 类
    Class originalClass = object_getClass(self);
    // 通过 objc_allocateClassPair 方法，创建一个名为 kvoClassName 的类，其父类为 originalClass
    Class createdKVOClass = objc_allocateClassPair(originalClass, kvoClassName.UTF8String, 0);
    // 为 createKVOClass 类的 添加class 方法，使其调用 self.class 时返回的仍然是原本的类
    Method classMethod = class_getInstanceMethod(originalClass, @selector(class));
    const char *types = method_getTypeEncoding(classMethod);
    class_addMethod(createdKVOClass, @selector(class), (IMP)kvo_class, types);
    // 注册通过 allocateClassPair 方法创建的 Class
    objc_registerClassPair(createdKVOClass);
    return createdKVOClass;
}

- (void)addObserver:(NSObject *)observer forKey:(NSString *)observerKey withBlock:(ObservingBlock)block {
    // 原类：self 所的类
    // 类之间的关系 self.isa => 原类
    SEL setterSEL = NSSelectorFromString(setterMethodForKey(observerKey));
    Method setterMethod = class_getInstanceMethod(self.class, setterSEL);
    if (!setterMethod) {
        // 属性没有对应的 setter 方法
        return;
    }
    // 获取 self isa 指针指向的父类
    Class class = object_getClass(self);
    NSString *className = NSStringFromClass(class);
    // 判断其是否已经有 KVO 父类
    if (![className hasPrefix:kKVOClassPrefix]) {
        class = [self makeKVOClassWithOriginalClassName:className];
        // 将 self 对象的 isa 指针设置为创建的 KVO 中间类
        object_setClass(self, class);
    }
    // 到这一步类之间的关系是 self.isa => KVO中间类.superClass => 原类
    // 重写 KVO 中间类的 setter 方法
    // 首先需要检查这个 KVO 中间类是否重写过 setter，此时使用 object_getClass(self) 获取的 class 为 KVO 中间类
    if (![self hasOverrideSetter:setterSEL]) {
        const char *typeEncoding = method_getTypeEncoding(setterMethod);
        class_addMethod(class, setterSEL, (IMP)kvo_setter, typeEncoding);
    }
    
    // _ObserverInfo是一个监听数据信息对象，其中包含监听者，监听的 Key，回调函数
    _ObserverInfo *info = [[_ObserverInfo alloc] initWithObserver:observer Key:observerKey block:block];
    // 创建一个信息对象并将其存入到一个数组中
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge void *)kKVOAssociatedObservers);
    if (!observers) {
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge void*) kKVOAssociatedObservers, observerKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [observers addObject:info];
}

- (void)removeObserver:(NSObject *)observer forKey:(NSString *)key {
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge void *)kKVOAssociatedObservers);
    _ObserverInfo *info = nil;
    // 从 Observer 数组中找出需要移除的Oberver
    for (_ObserverInfo *observer in observers) {
        if ([observer.key isEqualToString:key] && [observer.observer isEqual:observer]) {
            info = observer;
            break;
        }
    }
    // 移除
    [observers removeObject:info];
}

- (BOOL)hasOverrideSetter: (SEL) setter {
    Class class = object_getClass(self);
    unsigned int methodCount;
    Method *methodList = class_copyMethodList(class, &methodCount);
    for (NSInteger index = 0; index < methodCount; index++) {
        SEL selector = method_getName(methodList[index]);
        if (selector == setter) {
            return true;
        }
    }
    return false;
}

@end
