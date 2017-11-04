//
//  ViewController.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/10/29.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@property (nonatomic, strong) dispatch_queue_t queue;
@end
typedef void(^TestBlock)(void);
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
//    for (NSInteger index = 0; index < 100000; index++) {
//        dispatch_async(self.queue, ^{
//            NSLog(@"%ld", (long)index);
//        });
//    }
    [self testSemaphort];
   
}

/*
 测试串行队列+同步执行：
 结论：任务顺序执行，不会开辟新的线程，在当前线程中执行任务
 */
- (void)testSyncConcurrentQueue{
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    for (NSInteger index = 01; index < 100; index++) {
        dispatch_sync(queue, ^{
            NSLog(@"currendTread:%@ - value:%ld", [NSThread currentThread],(long)index);
            sleep(2);
        });
    }
}

/*
 测试并行队列+异步任务
 结论：线程池中如果有线程，则使用，没有则创建新线程，任务并发执行
 */
- (void)testAsyncConcurrent {
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    for (NSInteger index = 01; index < 100; index++) {
        dispatch_async(queue, ^{
            NSLog(@"currendTread:%@ - value:%ld", [NSThread currentThread],(long)index);
            sleep(2);
        });
    }
}
/*
 结论：创建一条新线程，用于串行执行任务
 */
- (void)testAsyncSerialQueue {
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    for (NSInteger index = 01; index < 100; index++) {
        dispatch_async(queue, ^{
            NSLog(@"currendTread:%@ - value:%ld", [NSThread currentThread],(long)index);
            sleep(index * 0.1);
        });
    }
}

- (void)testSemaphort {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"请求1");
        sleep(10);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"请求2");
        sleep(5);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"请求3");
        sleep(1);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_notify(group, queue, ^{
        // 三个请求对应三次信号等待
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"请求1 完成");
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"请求2 完成");
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"请求3 完成");
    });
    
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);        // 初始信号量为0
    dispatch_group_async(group, queue, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_semaphore_signal(sem); 
            NSLog(@"请求一");
        });
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    });
    dispatch_group_async(group, queue, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_semaphore_signal(sem);
            NSLog(@"请求二");
        });
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"请求三");
        
    });
    //在分组的所有任务完成后触发
    dispatch_group_notify(group, queue, ^{
        
        NSLog(@"请求完成");
    });
}

- (IBAction)cancel:(id)sender {
    dispatch_suspend(self.queue);
    self.queue = nil;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)testBlock {
    NSString *test = @"test";
    TestBlock block = ^{
        dispatch_sync(dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL), ^{
            NSLog(@"%@",test); // test
        });
    };
    test = @"test1";
    block();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)validateKVV {
   
}


@end
