//
//  GCDTest.m
//  知识点验证合集Tests
//
//  Created by X-Liang on 2017/10/30.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LRUCacheStrategy.h"
@interface GCDTest : XCTestCase
@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation GCDTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

//- (void)testQueueCancel {
//    self.queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
//    for (NSInteger index = 0; index < 100000; index++) {
//        dispatch_async(self.queue, ^{
//            NSLog(@"%ld", (long)index);
//        });
//    }
//    // 通过 suspend 挂起队列，达到 暂停 的效果
////    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        NSLog(@"-----------------cancel queue---------------");
////        dispatch_suspend(self.queue);
////    });
//}

- (void)testGCDBarrier {
    dispatch_queue_t queue = dispatch_queue_create("testQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"concurrent 1");
    });
    dispatch_async(queue, ^{
        NSLog(@"concurrent 2");
    });
    dispatch_barrier_sync(queue, ^{
        for (NSInteger index = 0; index < 5000; index++) {
            if (index == 100) {
                NSLog(@"barrier 100");
            } else if (index == 200) {
                NSLog(@"barrier 200");
            }
        }
    });
    NSLog(@"out thread a");
    dispatch_async(queue, ^{
        NSLog(@"concurrent 4");
    });
    NSLog(@"out thread b");
    dispatch_async(queue, ^{
        NSLog(@"concurrent 5");
    });
}

- (void)testCache {
    LRUCacheStrategy *cache = [[LRUCacheStrategy alloc] initWithCount:5];
    for (NSInteger index = 0; index < 10; index++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [cache setValue:@(index) forKey:@(index)];
        });
    }
    
}

/**
 判断代码是否运行在主队列
 @description: iOS 中如果我们要判断代码是否允许在主线程，可以使用NSThread.isMainThread;
 但是如果我们要判断是否运行在主队列(main queue)呢？？ 每个应用都只有一个主线程，但主线程中可能有多个队列，
 则不仅仅只有主队列，所以NSThread.isMainThread()方法并没有办法判断是否是在主队列运行。
 通过dispatch_queue_set_specific方法给主队列(main queue)关联了一个key-value对
 再通过dispatch_get_specific从当前队列中取出mainQueueKey对应的value。如果是主队列，取出来的值就是写入的值，如果是其它主队列，取出的值就是另一个值或者是NULL
 */
- (BOOL)testIsMainQueue {
    static void *mainQueueKey = &mainQueueKey;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_queue_set_specific(dispatch_get_main_queue(), mainQueueKey, mainQueueKey, NULL);
    });
    return dispatch_get_specific(mainQueueKey) == mainQueueKey;
}

@end
