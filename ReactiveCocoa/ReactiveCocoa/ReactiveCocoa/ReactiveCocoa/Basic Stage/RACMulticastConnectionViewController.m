//
//  RACMulticastConnectionViewController.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "RACMulticastConnectionViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
// Multicase: 广播连接
// MulticaseConnection: 用于当一个信号被多次订阅时，为了保证创建信号时避免多次调用信号中的 block，造成副作用，可以使用这个类处理
// 解决 RACSignal 副作用
@interface RACMulticastConnectionViewController ()

@end

@implementation RACMulticastConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 网络请求
    @weakify(self)
    // 创建 dynamicSignal 并保存 didSubscribe
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self)
        // 发送网络请求
        //因为外界订阅一次就会执行该block，所以如果外界订阅多次，即执行多次subscribeNext、error、complete 方法，则会造成发送多次网络请求
        [self loadData:^(id objc) { 
            [subscriber sendNext:@2];
        }];
        return nil;
    }];
    // RACSignal -> RACMulticastConnection
    // publish 创建一个 subject 对象，
    // 并通过 dynamicSignal对象和 subject 对象，创建一个 multicastConnection对象
    // 创建的 multicastConnection 对象的 signal 是创建的 subject 对象
    // 所以 connection.signal 是 subject 对象
    RACMulticastConnection *connection = [signal publish];
    
    // 订阅信号
    // 订阅 RACSubject，subject 仅仅报订阅者保存起来，只有执行 sendNext 或 sendComplete 是才会执行下面的 next 和 completed 回调
    // 订阅 next，订阅 complete 订阅两次，通过 connection 解决回调两次的问题
    [connection.signal subscribeNext:^(id  _Nullable x) {}];
    [connection.signal subscribeCompleted:^{}];
    
    // 进行连接
    // connect 获得 connection 中保存的最初的 signal，然后进行 subscribe，即执行 signal 指定的 block
    // connect 内部操作是时 sourceSignal 订阅内部生产的 signal
    [connection connect];
}

// 使用 RACSignal 导致存在副作用的网络请求
- (void)signal {
    // 网络请求
    @weakify(self)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self)
        // 发送网络请求
        //因为外界订阅一次就会执行该block，所以如果外界订阅多次，即执行多次subscribeNext、error、complete 方法，则会造成发送多次网络请求
        [self loadData:^(id objc) {
            [subscriber sendNext:@2];
        }];
        return nil;
    }];
    
    // 订阅信号
    // 订阅 next，订阅 complete 订阅两次，所以会调用两次 signal 指定的回调
    [signal subscribeNext:^(id  _Nullable x) {
        
    }];
    [signal subscribeCompleted:^{
        
    }];
}

- (void)loadData: (void (^)(id))success {
    
}

@end
