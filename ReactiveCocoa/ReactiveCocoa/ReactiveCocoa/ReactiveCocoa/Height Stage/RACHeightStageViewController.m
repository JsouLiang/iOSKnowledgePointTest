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
    [self flattenMap];
}
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

@end
