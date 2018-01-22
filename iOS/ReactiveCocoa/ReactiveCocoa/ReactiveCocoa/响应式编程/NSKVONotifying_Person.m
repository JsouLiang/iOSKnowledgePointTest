//
//  NSKVONotifying_Person.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/17.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "NSKVONotifying_Person.h"
#import <objc/message.h>
@implementation NSKVONotifying_Person

+ (void)load {
    
}

- (void)setAge:(NSInteger)age {
    // super 是一个标识，标识去父类执行父类的方法
    [super setAge:age];
    // 调用观察者的 observeValueForKeyPath....方法
    id observer = objc_getAssociatedObject(self, "Observer");
    [observer observeValueForKeyPath:@"age" ofObject:self change:nil context:nil];
}
@end
