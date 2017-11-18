//
//  Calculation.h
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Calculation;
typedef Calculation *(^Result)();

@interface Calculation : NSObject

@property (nonatomic, assign, readonly) NSInteger result;

- (Result)add: (NSInteger) value;

- (Result)sub: (NSInteger) value;

@end
