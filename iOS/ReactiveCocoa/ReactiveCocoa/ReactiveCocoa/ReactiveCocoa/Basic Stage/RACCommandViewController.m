//
//  RACCommandViewController.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "RACCommandViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

// RACCommand 用于处理时间的类
// 可以把事件如何处理，事件中的数据如何传递包装到这个类中，可以很方便的监控事件的执行过程
// 使用场景：监听按钮点击，网络请求
// 注意：
// 1. RACCommand 内部必须返回 signal
// 2. executingSignals信号中的信号，一开始获取不到内部信好
//    switchToLatest: 获取内部信号
//    execute: 返回内部信号，当执行 execute 是会执行 command 创建时执行的 block
// 3. executing: 用来判断是否正在执行
//    第一次不准确，需要使用 skip 跳过
//    一定要发送 sendCompleted，否则不会执行完成
@interface RACCommandViewController ()

@end

@implementation RACCommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"%@", input);
        RACSignal *emptySignal = [RACSignal empty]; // 空信号
        
        // 返回的 signal 不能为空
        // command 内部就会订阅指定的 signal，触发 signal block 的执行
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 为订阅者发送信息
            [subscriber sendNext:@"你好"];
            // 此时的订阅者为 RACReplaySubject 类型
            [subscriber sendCompleted]; // 发送完成信息，要不然监听 executing 时永远获得不到执行完成
            return nil;
        }];
    }];

    // 获得 command 的 signal，进行订阅
    // executionSignals: 信号中的信号
    // executionSignals发送的是一个信号
    [command.executionSignals subscribeNext:^(RACSignal *signal) {
        NSLog(@"next: %@", signal);
        [signal subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
        } completed:^{
            
        }];
    } completed:^{}];
    
    // 订阅 signal
    // switchToLatest 获取最近发送的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    } completed:^{}];
    
    // 监听命令的执行情况，有没有完成
    // 默认第一次是无效的，第一次执行就是执行完成
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        BOOL isexecuting = [x boolValue];
        if (isexecuting) {
            NSLog(@"正在执行");
        } else {
            NSLog(@"执行完成");
        }
    }];
    [command execute:@"inputValue"];
}

// command订阅方式一，直接通过 execute 进行订阅
- (void)commandSubscribe {
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"%@", input);
        RACSignal *emptySignal = [RACSignal empty]; // 空信号
        
        // 返回的 signal 不能为空
        // command 内部就会订阅指定的 signal，触发 signal block 的执行
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 为订阅者发送信息
            [subscriber sendNext:@"你好"];
            return nil;
        }];
    }];
    // 执行 command 创建时执行的 block，参数作为 block 的 input
    // execute 会返回 command 内部的 signal，所以下面 subscribe 进行订阅 command 内部的 signal
    RACReplaySubject *subject = [command execute:@"inputValue"];
    [subject  subscribeNext:^(id  _Nullable x) {
        NSLog(@"next: %@", x);
    } completed:^{}];
}



@end
