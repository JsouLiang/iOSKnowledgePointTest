//
//  RACViewController.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "RACSignalViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACSignalViewController ()

@end

@implementation RACSignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // RACSingal：信号 -> 订阅信号(响应式编程思想，只要信号一变化，马上得到通知), RAC 中最基本的类
    // RACDisposable: 处理数据，清空一些数据
    // RACSubscriber: 信号订阅者，使用订阅者发送信号的消息
    // 信号本身不具备发送消息的能力
    // 先订阅在发送消息
    // 订阅时就会执行 RAC signal 的 block
    // 创建信号
    // 参数为指定订阅消息时的回调 block
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 发送信号的变化
        // signal 通过订阅者发送消息时即 subScribeNext/error/complete，会走这个block，同时会把 signal 底层创建的订阅者传递进来，通过订阅者发送信息，调用 指定的 next、error、complete 消息的 block
        NSLog(@"RACSingal Block");
        [subscriber sendNext: @2];
        [subscriber sendCompleted]; // 发送完成，表示信号完成
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"RACDisposable Block");
            // 当订阅者被销毁时执行
            // 订阅发送完成或者error 时也会执行
            // 清空数据
        }];
    }];
    // 订阅信号
    // 订阅信号传递的值
    // 底层会创建订阅者
    // 只要一指定消息订阅，就会调用 signal 指定的订阅 block 
    [signal subscribeNext:^(id  _Nullable x) {
        
    } error:^(NSError * _Nullable error) {
        
    } completed:^{
        
    }];
    /*
     只要一指定消息订阅，就会调用 signal 指定的订阅 block,
     所以下面三段创建了三个不同的订阅者
     */
//    [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"next Block");
//        NSLog(@"next: %@",x);
//    }];
//    // 订阅信号的错误信息
//    [signal subscribeError:^(NSError * _Nullable error) {
//
//    }];
//    // 订阅信号的完成
//    [signal subscribeCompleted:^{
//        NSLog(@"complete Block");
//    }];
}

@end
