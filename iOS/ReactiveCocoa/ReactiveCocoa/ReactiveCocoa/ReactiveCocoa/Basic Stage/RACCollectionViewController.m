//
//  RACCollectionViewController.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "RACCollectionViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "FlagItem.h"
// RAC 集合
// RAC 集合是在异步线程中进行遍历
// 数据优化，开启一个异步线程去处理数据
@interface RACCollectionViewController ()

@end

@implementation RACCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dict = @{
                           @"name": @"Jsoulan",
                           @"money": @100000
                           };
    // key-value
    [dict.rac_sequence.signal subscribeNext:^(RACTuple * _Nullable x) {
        // 解包
        RACTupleUnpack(NSString *key, id value) = x;
        // 打包
        RACTuplePack(@1,@2,@3);
        
        NSLog(@"%@-%@",key, value);
    } completed:^{}];
    // key
    [dict.rac_keySequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    } completed:^{}];
    // value
    [dict.rac_valueSequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    } completed:^{}];
}

- (void)racArray {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
    NSArray *datas = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *array = [NSMutableArray array];
    // 将数组装换为 RAC 集合
    [datas.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        FlagItem *item = [FlagItem itemWithDic:x];
        [array addObject:item];
    } completed:^{
        for (FlagItem *item in array) {
            NSLog(@"-----%@",item.name);
        }
    }];
    
    // 字典转模型
    array = [datas.rac_sequence map:^id _Nullable(id  _Nullable value) {
        return [FlagItem itemWithDic:value];
    }];
    for (FlagItem *item in array) {
        NSLog(@"%@",item.name);
    }
}

@end
