//
//  SubClass.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/11/29.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "SubClass.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation SubClass

- (void)eat {
    NSLog(@"new Subclass eat");

    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    void (*objc_msgSendSuperCasted)(void *, SEL) = (void *)objc_msgSendSuper;
    objc_msgSendSuperCasted(&superClass, _cmd);
}

@end
