//
//  CaculationMachine.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/16.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "CalculationMachine.h"

@implementation CalculationMachine

- (CalculationMachine *(^)(NSInteger))addNum {
    return ^ CalculationMachine* (NSInteger value) {
        self.result += value;
        return self;
    };
}

@end
