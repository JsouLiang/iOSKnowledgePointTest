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
