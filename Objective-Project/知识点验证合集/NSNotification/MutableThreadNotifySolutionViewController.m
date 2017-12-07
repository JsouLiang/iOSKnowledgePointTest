//
//  MutableThreadNotifySolutionViewController.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/12/4.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

// 如果我想在子线程中 post 通知，那么主线程如何接受
#import "MutableThreadNotifySolutionViewController.h"
static NSString *TEST_NOTIFICATION = @"TEST_NOTIFICATION";

@interface MutableThreadNotifySolutionViewController ()<NSMachPortDelegate>
@property (nonatomic, strong) NSMutableArray *notifications;    // 通知队列
@property (nonatomic, strong) NSThread *notificationThread;     // 期望线程
@property (nonatomic, strong) NSLock *notificationLock;         // 用于对通知队列进行加锁的锁对象，防止线程冲突
@property (nonatomic, strong) NSMachPort *notificationPort;     // 向期望线程发送信号的通信端口
@end

@implementation MutableThreadNotifySolutionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self propertyInitial];
    
}


#pragma mark - Private method
- (void)propertyInitial {
    self.notifications = [NSMutableArray array];
    self.notificationLock = [[NSLock alloc] init];
    
    self.notificationThread = [NSThread currentThread];
    self.notificationPort = [[NSMachPort alloc] init];
    self.notificationPort.delegate = self;
    // 往当前线程的run loop添加端口源
    // 当Mach消息到达而接收线程的run loop没有运行时，则内核会保存这条消息，直到下一次进入run loop
    [[NSRunLoop currentRunLoop] addPort:self.notificationPort
                                forMode:(__bridge NSString *)kCFRunLoopCommonModes];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(processNotification:)
                                                 name:@"TestNotification"
                                               object:nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:TEST_NOTIFICATION
                                                            object:nil
                                                          userInfo:nil];
    });
}

- (void)handleMachMessage:(void *)msg {
    
}

@end
