//
//  Class1.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/10/30.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "Class1.h"

@implementation Class1

- (void)method1:(NSString *)param1 {
    
}

- (int)method2:(int)param1 with:(int)param2 {
    NSLog(@"%s",__FUNCTION__);
    return param1 + param2;
}

- (id)method3 {
    return self;
}

- (int)a:(int)a {
    return a;
}

@end
