//
//  DynamicChangeMethodViewController.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/11/29.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "DynamicChangeMethodViewController.h"
#import "NSObject+Hook.h"
@interface DynamicChangeMethodViewController ()

@end

@implementation DynamicChangeMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    DynamicChangeMethodViewController *dynamicVC = [[DynamicChangeMethodViewController alloc] init];
    [dynamicVC eat];
    
    DynamicChangeMethodViewController *hookDynamicVC = [[DynamicChangeMethodViewController alloc] init];
    [DynamicChangeMethodViewController hookWithInstance:hookDynamicVC method:@selector(eat)];
    [hookDynamicVC eat];
}

- (void)eat {
    NSLog(@"original eat");
}

@end
