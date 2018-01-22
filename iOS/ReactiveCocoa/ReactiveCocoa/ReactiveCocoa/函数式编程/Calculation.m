//
//  Calculation.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "Calculation.h"

@interface Calculation()
@property (nonatomic, assign) NSInteger result;
@end

@implementation Calculation

- (Result)add:(NSInteger)originalValue {
    return ^ Calculation* () {
        self.result += originalValue;
        return self;
    };
}

- (Result)sub:(NSInteger)value {
    return ^ Calculation*() {
        self.result -= value;
        return self;
    };
}

@end
