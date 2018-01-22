//
//  CaculationMachine.h
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/16.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculationMachine : NSObject
@property (nonatomic, assign) NSInteger result;
- (CalculationMachine *)add: (NSInteger)value;

- (CalculationMachine *(^)(NSInteger value))addNum;

@end
