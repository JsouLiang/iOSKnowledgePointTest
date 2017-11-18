//
//  NSObject+KVO.h
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/17.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVO)
- (void)_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
@end
