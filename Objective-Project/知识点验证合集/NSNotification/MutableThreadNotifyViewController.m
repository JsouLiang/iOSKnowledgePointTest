//
//  MutableThreadNotifyViewController.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/12/4.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

/**
 Notification 有个特性，在哪个线程 post notify，相应的只有在对应的线程内才能接收到通知
*/
#import "MutableThreadNotifyViewController.h"
static NSString *TEST_NOTIFICATION = @"TEST_NOTIFICATION";

@interface MutableThreadNotifyViewController ()

@end

@implementation MutableThreadNotifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", [NSThread currentThread]);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:TEST_NOTIFICATION
                                               object:nil];
}

- (void)handleNotification: (NSNotification *)notify {
    NSLog(@"current thread = %@", [NSThread currentThread]);
    NSLog(@"test notification");
}

@end
