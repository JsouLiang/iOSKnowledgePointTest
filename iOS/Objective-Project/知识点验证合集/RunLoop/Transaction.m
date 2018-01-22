//
//  Transaction.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/11/14.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "Transaction.h"

@interface Transaction()
@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL selector;
@end

@implementation Transaction
NSMutableSet *transactionSet = nil;

static void TransactionCallBack() {
    if (transactionSet.count == 0) {
        return ;
    }
    // 在这次 callBack的回调时，执行 set 中的 target selection，同时将 set 重置
    NSSet *currentLoopSet = transactionSet;
    transactionSet = [NSMutableSet set];
    [currentLoopSet enumerateObjectsUsingBlock:^(Transaction *transaction, BOOL * _Nonnull stop) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [transaction.target performSelector:transaction.selector];
#pragma clang diagnostic pop
    }];
}

static void TransactionSetUP() {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        transactionSet = [[NSMutableSet alloc] init];
        // 获取主线程 Runloop
        CFRunLoopRef mainRunloop = CFRunLoopGetMain();
        // 为主线程 RunLoop 添加 Observer
        CFRunLoopObserverRef observer;
        observer = CFRunLoopObserverCreate(CFAllocatorGetDefault(),
                                           kCFRunLoopBeforeWaiting | kCFRunLoopExit,
                                           true,
                                           0,
                                           TransactionCallBack, NULL);
        CFRunLoopAddObserver(mainRunloop, observer, kCFRunLoopCommonModes);
        CFRelease(observer);
    });
}

+ (instancetype)transcationWithTarget:(id)target selector:(SEL)selector {
    if (!target || !selector) {
        return nil;
    }
    Transaction *transation = [[Transaction alloc] init];
    transation.target = target;
    transation.selector = selector;
    return transation;
}

- (void)commit {
    if (!_target || !_selector) {
        return;
    }
    TransactionSetUP();
    [transactionSet addObject:self];
}

- (NSUInteger)hash {
    long v1 = (long)((void *)_selector);
    long v2 = (long)_target;
    return v1 ^ v2;
}

- (BOOL)isEqual:(id)object {
    if (self == object) return YES;
    if (![object isMemberOfClass:self.class]) return NO;
    Transaction *other = object;
    return other.selector == _selector && other.target == _target;
}


@end
