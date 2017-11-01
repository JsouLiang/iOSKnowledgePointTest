//
//  Class2.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/10/30.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "Class2.h"
#import "Class1.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation Class2

typedef int (*Function)(id self, SEL _cmd, int parm1, int parm2);

- (void)method4:(NSString *)param1 {
    
}
// 不借助 super
/*
- (int)method2:(int)param1 with:(int)param2 {
    NSLog(@"%s",__FUNCTION__);
    unsigned int count;
    
    Method *methodList = class_copyMethodList([Class1 class], &count);
    for (NSInteger index = 0; index < count; index++) {
        IMP imp = method_getImplementation(methodList[index]);
        SEL sel = method_getName(methodList[index]);
        if (strcmp(sel_getName(sel), "method2:with:") == 0) {
            Function func = (Function)imp;
            return func(self, sel, param1, param2);
        }
    }
    return -1;
}*/

// 借助 super
- (int)method2:(int)param1 with:(int)param2 {
    
    // 创建 super struct
    struct objc_super super_struct = {
        .receiver = self,
// 通过运行时获取 superclass 是有问题的, 在运行时 superclass 并不一定是你想要的父类，有可能是你自己
// 假设 D 类实例 d 调用 testMethod 方法，D 类没有实现 testMethod 方法，而 D 继承于 C 类，C 类实现 testMethod 方法，在 C 的 testMethod 实现中有 self.class.superClass 这样端代码，这种情况下会有问题。因为此时 self 为 d 对象，self.class 为 D，D 的 superClass 为 C，这样在 C 的实现中获取的 superclass 就是 C 自己，出现错误；因为 self 的层级确定，所以 super 的确定无法在运行是确定
//        .super_class = class_getSuperclass(object_getClass(self))
        .super_class = [Class1 class]
    };
//    typedef int *MyOBJC_msgSendSuper(struct objc_super *, SEL, int, int);
//    MyOBJC_msgSendSuper *func = &objc_msgSendSuper;
//    return func(&super_struct, @selector(method2:with:), param1, param2);
    return (int)objc_msgSendSuper(&super_struct, @selector(method2:with:), param1, param2);
}
- (id)method6 {
    return self;
}

- (void)setName:(NSString *)name {
    [super setName:name];
    NSLog(@"subName");
}

 

@end
