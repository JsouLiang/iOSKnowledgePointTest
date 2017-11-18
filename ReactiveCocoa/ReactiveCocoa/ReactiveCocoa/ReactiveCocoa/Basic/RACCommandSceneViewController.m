//
//  RACCommandSceneViewController.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "RACCommandSceneViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
// RACCommand 使用场景
@interface RACCommandSceneViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation RACCommandSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RACSubject *subject = [RACSubject subject];

    self.button.rac_command = [[RACCommand alloc] initWithEnabled:subject
                                                      signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        // 只监听按钮点击，不涉及网络请求方面的信息，在 commandBlock 中即可完成操作
        NSLog(@"按钮点击");
        //        return [RACSignal empty];
        // 如果需要点击按钮是传递数据，则需要 signal block
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:input];
            // 模拟延时，延时结束后按钮可以点击
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];
    
    [[self.button.rac_command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        BOOL isExcuting = [x boolValue];
        // 通过 subject 可以控制按钮是否可以点击
        if (isExcuting) {
            [subject sendNext:@NO];
        } else {
            [subject sendNext:@YES];
        }
    }];
}

- (void)buttonClick {
    self.button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        // 只监听按钮点击，不涉及网络请求方面的信息，在 commandBlock 中即可完成操作
        NSLog(@"按钮点击");
        //        return [RACSignal empty];
        // 如果需要点击按钮是传递数据，则需要 signal block
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:input];
            return nil;
        }];
    }];
    
    // 监听
    [self.button.rac_command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

@end
