//
//  CustomView.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(touchView:)]) {
//        [self.delegate touchView:self];
//    }
    // subject 发送消息
    [self.subject sendNext: self];
}

@end
