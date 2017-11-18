//
//  TestKVOViewController.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/17.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "TestKVOViewController.h"
#import "Person.h"
#import "NSObject+KVO.h"
#import "SubPerson.h"
@interface TestKVOViewController ()
@property (nonatomic, strong) Person *person;
@end

@implementation TestKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     KVO 工作流程
     1. runtime动态生成 Person 的子类 KVO_Person
     2. KVO_Person 重写监听属性的 set 方法
     3. 修改对象的 isa 指针指向 KVO_Person，当修改完 isa 指针后，调用方法就会从 isa 执行的对象中寻找方法
     4. 在重写的 set 方法中监听属性有没有发生改变
     */
    Person *p = [[Person alloc] init];
    self.person = p;
    [p _addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
    
    SubPerson *subPerson = [[SubPerson alloc] init];
    [subPerson test];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.person.age = 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%ld",(long)self.person.age);
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
