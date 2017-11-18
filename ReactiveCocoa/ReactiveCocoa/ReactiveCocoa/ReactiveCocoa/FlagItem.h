//
//  FlagItem.h
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlagItem : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
+ (instancetype)itemWithDic: (NSDictionary *)dic;
@end
