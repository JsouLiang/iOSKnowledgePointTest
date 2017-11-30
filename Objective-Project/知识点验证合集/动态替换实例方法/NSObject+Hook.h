//
//  NSObject+Hook.h
//  知识点验证合集
//
//  Created by X-Liang on 2017/11/29.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Hook)

+ (void)hookWithInstance:(id) instance method:(SEL)selector;

@end
