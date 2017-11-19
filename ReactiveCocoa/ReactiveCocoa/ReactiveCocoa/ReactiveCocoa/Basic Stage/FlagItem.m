//
//  FlagItem.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "FlagItem.h"

@implementation FlagItem
+ (instancetype)itemWithDic:(NSDictionary *)dic {
    FlagItem *item = [[FlagItem alloc] init];
    [item setValuesForKeysWithDictionary:dic];
    return item;
}
@end
