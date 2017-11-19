//
//  RACHeightStageViewController.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/19.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "RACHeightStageViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/RACReturnSignal.h>
/**
 RAC 高阶用法
 */
@interface RACHeightStageViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation RACHeightStageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self racHook];
//    [self flattenMap];
//    [self then];
//    [self merge];
    [self zip];
}
#pragma mark - Hook
/**
 RAC Hook 思想
 */
- (void)racHook {
    // 需求：每次在文本框输入后添加-
    [[self.textField.rac_textSignal bind:^RACSignalBindBlock _Nonnull{
        NSLog(@"bind block");
        return ^RACSignal *(id value, BOOL *stop) {
            // 信号一改变，就会执行该 block，并且把值传递过来
//            NSLog(@"Signal Bind block %@", value);
            NSString *machinedValue = [NSString stringWithFormat:@"%@-",value];
            return [RACReturnSignal return: machinedValue];
        };
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

#pragma mark - flattenMap Map
/**
 flatMap，Map
 都可以用于将源信号中的内容映射成新的内容
 区别：
 Map 值-> 值
 flatMap 信号 -> 信号
 */
- (void)map {
    // map 返回的是值
    [[self.textField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return [NSString stringWithFormat:@"%@(^_^)",value];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];;
   
}

- (void)flattenMap {
    RACSubject *signalOfSignale = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    
    //   直接再次订阅信号中的信号
//    [signalOfSignale subscribeNext:^(id  _Nullable x) {
//        // x 为信号
//        [x subscribeNext:^(id  _Nullable x) {
//            // x 为值
//            NSLog(@"%@",x);     // 1
//        }];
//    }];

    //   使用 flattenMap 对信号中的信号进行修改
    [[signalOfSignale flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        // 对信号中的值进行修改
        return [value map:^id _Nullable(id  _Nullable value) {
            return [NSString stringWithFormat:@"%@-",value];
        }];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x); // 1
    }] ;
    [signal subscribeNext:^(id  _Nullable x) {
        // x 为值
    }];
    
    [signalOfSignale sendNext:signal];
    [signal sendNext:@"1"];

    // flattenMap 返回的是信号，用于信号中的信号
//    [[self.textField.rac_textSignal flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {
//        NSString *result = [NSString stringWithFormat:@"%@(^_^)",value];
//        return [RACReturnSignal return:result];
//    }] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
}

#pragma mark - concat
/**
 RAC concat: 按一定顺序拼接信号，当多个信号发出的时候，有序的接受信号
 信号拼接
 */
- (void)concat {
    // 需求：需要把 signalA 和 signalB 两次请求中的数据有顺序地（先添加A，再添加 B）添加到数组中
    NSMutableArray *array = [NSMutableArray array];
    RACSubject *signalA = [RACSubject subject];
    // B 在 A 后面，可能在发送信息的时候，还没有订阅，所以这里使用 RACReplaySubject，先发送后订阅
    RACReplaySubject *signalB = [RACReplaySubject subject];
    // 分别订阅 A，B
//    [signalA subscribeNext:^(id  _Nullable x) {[array addObject:x];}];
//    [signalB subscribeNext:^(id  _Nullable x) {[array addObject:x];}];
//    // 发送信号, 先发送 A，后发送 B，没问题
//    // 但是请求中，由于网络数据的原因，A，B 谁先发送信号并不确定，所以可能出现先发送 B 后发送 A，这样就会出现问题
//    [signalA sendNext:@"A"];
//    [signalB sendNext:@"B"];
    
    // 使用 concat 解决，concat 按顺序拼接，必须要第一个信号发送完成，第二个信号才能获取值
    [[signalA concat:signalB] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    // concat 可能会订阅两次，导致出现副作用
    // 可以尽量不要订阅多次
    //    [[signalA concat:signalB] subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"%@",x);
    //    }];
    //
    //    [[signalA concat:signalB] subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"%@",x);
    //    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [signalA sendNext:@"A"];
        [signalA sendCompleted];    // 只有 A 发送完成是，concat 才能继续下一个信号
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [signalB sendNext:@"B"];
        [signalB sendCompleted];
    });
    
}
#pragma mark - Then
/**
 RAC then: 用于连接两个信号，当地一个信号完成，才会连接 then 返回的信号，拿不到上一个信号的值，只能获取当前一个信号的值
 then拼接，忽略上一个信号的值
 */
- (void)then {
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"执行信号 A");
        [subscriber sendNext:@"A"];
        [subscriber sendCompleted];
        return nil;
    }];

//    [[signalA then:^RACSignal * _Nonnull{
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            NSLog(@"执行信号 B");
//            [subscriber sendNext:@"B"];
//            return nil;
//        }];
//    }] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }] ;
    
    // then 可以解决 blok 的嵌套问题
    // 请求界面数据，第二个请求基于第一个请求结束
    [self loadDataWithRACThen];
}
// 最基本的请求block嵌套
- (void)generalLoadData {
    // 1. 先请求分类
    [self loadCategory:^(id data) {
        // 2. 请求分类中每项详情
        [self loadDetail:^(id data) {
            
        }];
    }];
}
#pragma mark - RAC Then 请求
- (void)loadDataWithRACThen {
    [[[self loadCategory] then:^RACSignal * _Nonnull{
        return [self loadDetailData];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }] ;
}

// 请求分类数据
- (RACSignal *)loadCategory {
    // 为了防止可能出现发送时还没有订阅的时候，使用RACReplaySubject
    RACReplaySubject *subject = [RACReplaySubject subject];
    // 发送请求
    [self loadCategory:^(id data) {
        [subject sendNext:data];
        [subject sendCompleted];
    }];
    return subject;
}

- (RACSignal *)loadDetailData {
    RACReplaySubject *subject = [RACReplaySubject subject];
    // 发送请求
    [self loadDetail:^(id data) {
        [subject sendNext:data];
        [subject sendCompleted];
    }];
    return subject;
}

- (void)loadCategory: (void (^)(id data))success {
    success(@"loadCategory");
}
- (void)loadDetail: (void (^)(id data))success {
    success(@"loadDetail");
}

#pragma mark - merge
/*
 concat, then 必须要前一个 signal 发送 complete，下个信号才能接受订阅
 merge：只要任何一个数据发送数据，就能接收到订阅，无关于顺序，谁先发送，谁先接收信号
 */
- (void)merge {
    RACSubject *subjectA = [RACSubject subject];
    RACSubject *subjectB = [RACSubject subject];
    [[subjectA merge:subjectB] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [subjectA sendNext:@"A"];
    [subjectB sendNext:@"B"];
}

#pragma mark - zipWith
// ZipWith 把信号压缩
// zip 要同时发送多个信号。比如下面的 A，B，zip 将 AB 信号的内容压缩为一个 Tuple
- (void)zip {
    RACSubject *subjectA = [RACSubject subject];
    RACSubject *subjectB = [RACSubject subject];
    [[subjectA zipWith:subjectB] subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString *a, NSString *b) = x;
        NSLog(@"%@-%@",a, b);
    }];
    [subjectA sendNext:@"A"];
    [subjectB sendNext:@"B"];
}
@end
