//
//  ViewController.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/16.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "ViewController.h"
#import "CalculationMachine.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testCalculationMachine];
}

- (void)testCalculationMachine {
    CalculationMachine *machine = [[CalculationMachine alloc] init];
//    [[[machine add:10] add:10] add:10];
    machine.addNum(10).addNum(10).addNum(10);
    NSLog(@"%ld", (long)machine.result);
}

@end
