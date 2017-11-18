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
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, assign) int age;
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
//    [self replaceKVO];
//    [self listenAction];
//    [self listenNotify];
//    [self listenTextField];
    [self loadData];
}
 #pragma mark - 监听某个方法有没有调用
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

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"age"];
}
#pragma mark - KVO
- (void)replaceKVO {
    // keypath 用来获取某个对象的属性并转换为字符串
    // keypath(self, age) 相当于 path
    [[self rac_valuesAndChangesForKeyPath:@keypath(self,age)
                                  options:NSKeyValueObservingOptionNew
                                 observer:self] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        NSLog(@"%@",x);
    }] ;
    
    // 通过宏来实现 KVO
    [RACObserve(self, age) subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.age++;
    [self postNotify];
}
#pragma mark - 监听事件
- (void)listenAction {
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击了按钮%@",x);
    }];
}
#pragma mark - 通知
- (void)listenNotify {
    // 监听通知
    // object 表示谁发出的通知
    //rac 通知中不需要管理通知观察者
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"Notify" object:self] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"监听到通知%@",x);
    }];
}

- (void)postNotify {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Notify" object:self];
}

#pragma mark - 绑定信号
- (void)listenTextField {
//    [[self.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"%@",x);
//        self.label.text = x;
//    }];
    
    // 给 label 的 text 属性进行绑定
    // 将属性的值与信号进行保定
    RAC(self.label, text) = [self.textField rac_textSignal];
}

#pragma mark - 处理一个界面，多个请求时的问题
- (void)loadData {
    // 当数组中所有信号都发送一次next 时候，才会执行 lift selector
    // 右边 array 中有几个信号，指定的 selector 必须有几个参数
    [self rac_liftSelector:@selector(updateUIHotData:newData:)   withSignalsFromArray:@[[self loadHotData], [self loadNewData]]];
}

// 请求最热板块数据
- (RACSignal *)loadHotData {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@[@{@"1":@"one", @"2":@"two" }]];
        });
        return nil;
    }];
    
}
// 请求上新板块数据
- (RACSignal *)loadNewData {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"最新板块数据"];
        });
        return nil;
    }];
}

- (void)updateUIHotData: (NSArray *)hot newData: (NSString *)new {
    NSLog(@"update ui hot: %@ new:%@", hot, new);
}

@end
