//
//  FunctionalViewController.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "FunctionalViewController.h"
#import "Calculation.h"
@interface FunctionalViewController ()

@end

@implementation FunctionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Calculation *cal = [[Calculation alloc] init];
    [[cal add:5]() sub:6]();
//    NSLog(@"%ld",addFive(6));
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
