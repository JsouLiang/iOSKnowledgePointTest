//
//  NSObject+KVO.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/17.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/runtime.h>
#import "NSKVONotifying_Person.h"
@implementation NSObject (KVO)
- (void)_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    /*
     KVO 工作流程
     1. runtime动态生成 Person 的子类 KVO_Person
     2. KVO_Person 重写监听属性的 set 方法
     3. 修改对象的 isa 指针指向 KVO_Person，当修改完 isa 指针后，调用方法就会从 isa 执行的对象中寻找方法
     4. 在重写的 set 方法中监听属性有没有发生改变
     */
    object_setClass(self, NSClassFromString(@"NSKVONotifying_Person"));       // 修改 self 的 isa 指针
    // 保存观察者对象
    // 动态保存观察对象
    objc_setAssociatedObject(self, "Observer", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
