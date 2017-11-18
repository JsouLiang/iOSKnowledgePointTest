//
//  RACUsingViewController.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "RACUsingViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "CustomView.h"
/*
 RAC 项目中的使用：
 1. 监听某个方法有没有调用(rac_signalForSelector)
 2. 代替 KVO
 3. 监听事件
 4. 代替通知
 5. 监听文本框文字的改变
 6. 处理一个界面，多个请求时的问题
 */
@interface RACUsingViewController ()

@end

@implementation RACUsingViewController
// 创建对象，分配内存是就会调用这个方法
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    RACUsingViewController *vc =  [super allocWithZone:zone];
    [[vc rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(RACTuple * _Nullable x) {
          NSLog(@"viewDidLoad 调用：%@", x);
    }];
    [[vc rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"viewWillAppear 调用：%@", x);
    }];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)signalForSelector {
    CustomView *view = [[CustomView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    // rac_signalForSelector: 判断对象是否执行指定的方法
    // subscribeNext 中的参数为调用方法是传递的参数
    [[view rac_signalForSelector:@selector(touchesBegan:withEvent:)] subscribeNext:^(id _Nullable x) {
        NSLog(@"%@",x);
    }];
}

@end
