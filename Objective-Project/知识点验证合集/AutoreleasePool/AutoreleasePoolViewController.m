//
//  AutoreleasePoolViewController.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/12/7.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "AutoreleasePoolViewController.h"
#define BigBumber 10000
@interface AutoreleasePoolViewController ()

@end

@implementation AutoreleasePoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 当创建了很多临时变量的循环时，使用 autoreleasePool 可以为每个循环迭代释放内存
    @autoreleasepool {
        NSUInteger count = BigBumber;
        for (NSInteger index = 0; index < count; index++) {
            @autoreleasepool {      // 确保在每次循环后清理内存
                // create object
                NSObject *obj = [NSObject new];
                
            }
        }
    }
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
