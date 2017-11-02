//
//  NSObject+KVO.h
//  知识点验证合集
//
//  Created by X-Liang on 2017/11/2.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ObservingBlock)(id observedObject, NSString *observerKey, id oldValue, id newValue);

@interface NSObject (KVO)

- (void)addObserver: (NSObject *)observer forKey: (NSString *)observerKey withBlock: (ObservingBlock)block;

- (void)removeObserver:(NSObject *)observer forKey:(NSString *)key;

@end
