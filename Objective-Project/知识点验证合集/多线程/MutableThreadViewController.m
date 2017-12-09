//
//  MutableThreadViewController.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/12/9.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "MutableThreadViewController.h"

@interface MutableThreadViewController ()

@end

@implementation MutableThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 使用 NSThread
    [NSThread detachNewThreadSelector:@selector(option) toTarget:self withObject:nil];  // 新线程将会立即执行，并创建，它使用默认配置
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(option) object:nil];
//    thread.stackSize =    设置线程栈空间大小
//    thread.threadDictionary 
    [thread start]; // 此时才是真正的创建线程
}

- (void)option {
    NSLog(@"%@",[NSThread currentThread]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
