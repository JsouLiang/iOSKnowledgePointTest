//
//  NSObject+Hook.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/11/29.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "NSObject+Hook.h"
#import <objc/runtime.h>
#import "SubClass.h"
@implementation NSObject (Hook)

+ (void)hookWithInstance:(id)instance method:(SEL)selector {
    Method originalMethod = class_getInstanceMethod([instance class], selector);
    if (!originalMethod) {
        
    }
    
    Class newClass = [SubClass class];
    
    // 修改 isa 指针
    object_setClass(instance, newClass);
}

@end
