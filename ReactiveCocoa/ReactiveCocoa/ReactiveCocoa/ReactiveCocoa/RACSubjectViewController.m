//
//  RACSubjectViewController.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "RACSubjectViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "CustomView.h"
@interface RACSubjectViewController ()

@end

@implementation RACSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     RACSubject 有多个订阅者
     RACSubject 和 RACReplaySubject：
        RACSubject 既可以订阅，又可以发送消息
        都可以充当信号也可以充当订阅者
     */
    // RACReplaySubject 先发送后订阅
    // 1. 创建信息
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    // 2. 发送消息，先保存要发送的消息
    [replaySubject sendNext:@"12"];
    [replaySubject sendNext:@"321"];
    
    // 3. 订阅信号
    // 遍历值，让生成的一个订阅者去发送多个值
    // 只要订阅一次，之前所有发送的值都能获取到
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [self configure];
}
#pragma mark - RACSubject 实现代理功能
- (void)configure {
    CustomView *view = [[CustomView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor redColor];
//    view.delegate = self;
    // 创建 subject
    RACSubject *subject = [RACSubject subject];
    view.subject = subject;
    // 订阅
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [self.view addSubview:view];
}

//- (void)touchView: (CustomView *)view {
//    NSLog(@"delegate action");
//}

- (void)testSubject {
    // 创建信号
    RACSubject *subject = [RACSubject subject];
    // 创建订阅者，每执行一次 subscribeNext。。方法，就会创建一个 RACSubscriber 对象，并保存在RACSubject内部
    // RACSubscriber 内部会保存指定的 next block
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"first subscriber");
    }];
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"second subscriber");
    }];
    // 发送信号，会遍历所有的订阅者RACSubscriber，执行指定的 block，比如上面的 nextBlock
    [subject sendNext:@"1"];
}

@end
