//
//  Algorithm.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/11/2.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "Algorithm.h"

@implementation Algorithm

// 把 " www.zhidao.baidu.com " 这样的字符串改成 "com/baidu/zhidao/www"
- (NSString *)optionString: (NSString *)str {
    // 1. 将 Str 按 . 分割
    NSArray *subStrs = [str componentsSeparatedByString:@"."];
    // 2. 翻转数组
    NSArray *reverseStubStrs = [[subStrs reverseObjectEnumerator] allObjects];
    // 3. 使用 / 拼接字符串数组
    NSString *result = [reverseStubStrs componentsJoinedByString:@"/"];
    return result;
}

@end
