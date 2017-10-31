//
//  LRUCacheStrategy.h
//  知识点验证合集
//
//  Created by X-Liang on 2017/10/31.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRUCacheStrategy : NSObject

//@property (nonatomic, assign) NSUInteger totailCount;;
- (instancetype)initWithCount: (NSUInteger)totailCount;

- (void)setValue:(id)value forKey:(id)key;

- (id)valueForKey:(id)key;

//- (void)allCacheValues;
@end
