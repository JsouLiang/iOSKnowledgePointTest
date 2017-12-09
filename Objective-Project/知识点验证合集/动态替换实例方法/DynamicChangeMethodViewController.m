//
//  DynamicChangeMethodViewController.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/11/29.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

/**
 在属性声明上，我们一般会用copy修饰一个Block属性。原因是什么？
 在MRR或MRC(两个词都是指同一个玩意)中，block默认是在栈上创建的。
 如果我们将它赋值给一个成员变量，如果成员变量没有被copy修饰或在赋值的时候没有进行copy，那么在使用这个block成员变量的时候就会崩溃。
 */
#import "DynamicChangeMethodViewController.h"
#import "NSObject+Hook.h"
@interface DynamicChangeMethodViewController ()

@end

@implementation DynamicChangeMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    void (^blockA)(void) = ^ {
        NSLog(@"just a blockA");
    };
    NSLog(@"%@", blockA);   // __NSGlobalBlock__
    // __NSGlobalBlock__类型是没有捕获局部变量的, 通过NSString literal创建的字符串是放在常量区的，也就是数据段上。
    // 全局的block里没有引用任何堆或栈上的数据。
    
    // const修饰下value里的值会存储在常量区即数据段上
    // 只要block 内部没有引用栈或堆上的数据，那么这个block会自动变为__NSGlobalBlock__类型
    const int constValue = 10;
    void (^blockBConst)(void) = ^{
        NSLog(@"just a blockBConst value = %d", constValue);
    };
    NSLog(@"%@", blockBConst);      // __NSGlobalBlock__
    
    static int staticValue = 10;
    void (^blockstatic)(void) = ^{
        NSLog(@"just a blockstatic value = %d", staticValue);
    };
    NSLog(@"%@", blockstatic);      // __NSGlobalBlock__
    
    int value = 10;
    void (^blockB)(void) = ^{
        NSLog(@"just a blockB value = %d", value);
    };
    NSLog(@"%@", blockB);           // __NSMallocBlock__
    
    // blockC则是强行用__weak声明让其分配在栈上
    void (^__weak blockC)(void) = ^{
        NSLog(@"just a blockC value = %d", value);
    };
    NSLog(@"%@", blockC);           // __NSStackBlock__
}

- (void)dynamicChangeMethod {
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
