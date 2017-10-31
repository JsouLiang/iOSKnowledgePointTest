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
        .super_class = class_getSuperclass(object_getClass(self))
    };
//    typedef int *MyOBJC_msgSendSuper(struct objc_super *, SEL, int, int);
//    MyOBJC_msgSendSuper *func = &objc_msgSendSuper;
//    return func(&super_struct, @selector(method2:with:), param1, param2);
    return (int)objc_msgSendSuper(&super_struct, @selector(method2:with:), param1, param2);
}
- (id)method6 {
    return self;
}

@end
