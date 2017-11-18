//
//  LinkProgram.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/16.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "LinkProgram.h"

@implementation LinkProgram

- (instancetype)init {
    if (self = [super init]) {
        // 返回对象本身
        self.test.test.test.test;
        // 通过括号调用
        self.inputValue(10);
        // 通过括号调用后能够继续调用
        self.inputValueDo(10).test;
    }
    return self;
}

- (void (^)(NSInteger))inputValue {
    return ^(NSInteger value) {
        
    };
}

- (LinkProgram *(^)(NSInteger))inputValueDo {
    return ^  LinkProgram* (NSInteger value) {
        return self;
    };
}

- (LinkProgram *)test {
    return self;
}

@end
