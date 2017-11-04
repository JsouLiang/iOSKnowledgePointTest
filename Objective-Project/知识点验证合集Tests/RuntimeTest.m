//
//  RuntimeTest.m
//  知识点验证合集Tests
//
//  Created by X-Liang on 2017/10/30.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>

@interface RuntimeTest : XCTestCase

@end

@implementation RuntimeTest

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

- (void)testGetPrivateIvar {
    NSObject *object = [NSObject new];
    // 需求：使用运行时获取我们设置的 _privateIvar2 和_privateIvar3 的值
    unsigned int ivarCount = 0;
    // 使用 runtime 获取所有的 ivar 定义列表
    Ivar *ivars = class_copyIvarList(object.class, &ivarCount);
    NSMutableDictionary *testIvar = [@{@"f": @NO, @"struct": @NO, @"id": @"NO"} mutableCopy];
    for(int i = 0; i < ivarCount; ++i) {
        Ivar ivar = ivars[i];
        const char *type = ivar_getTypeEncoding(ivar);    // 得到 ivar 的 encoding 编码
        NSString *typeString = [NSString stringWithUTF8String:type];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF like $TYPE"];
        // float 类型的成员变量
        if ([predicate evaluateWithObject:typeString substitutionVariables:@{@"TYPE": @"f"}]) {
            float f = 0.0;
            // 获取成员变量在对象的内存布局的偏移量
            ptrdiff_t offset = ivar_getOffset(ivar);
            
            // 获取值
            f =  *(float *)((__bridge void *)object + offset);
            NSAssert(f == 1.5, @"f 值应该为1.5");
            testIvar[@"f"] = @YES;
        }
        // CGRect
        // 模式匹配所有 CGRect 开头的
        if ([predicate evaluateWithObject:typeString substitutionVariables:@{@"TYPE": @"{CGRect*}"}]) {
            CGRect rect = CGRectZero;
            // 获取成员变量在对象的内存布局的偏移量
            ptrdiff_t offset = ivar_getOffset(ivar);
            // 获取值
            rect =  *(CGRect *)((__bridge void *)object + offset);
            NSAssert(CGRectEqualToRect(rect, CGRectMake(15, 15, 15, 15)), @"");
            testIvar[@"struct"] = @YES;
        }
        // id 类型定义为 NSDictionary
        if ([predicate evaluateWithObject:typeString substitutionVariables:@{@"TYPE": @"@\"NSDictionary\""}]) {
            // 获取存储的值
            NSString *str = object_getIvar(object, ivar);
            NSAssert([str isEqualToString:@"@{@\"key\": @\"value\"}"], @"f 值应该为1.5");
            testIvar[@"id"] = @YES;
        }
    }
    free(ivars);
}


- (void)testPrivateMethodList {
    NSObject *obj = [NSObject new];
    // 利用方法 API
    unsigned int methodCount;
    Method *methodList = class_copyMethodList(obj.class, &methodCount);
    for (NSInteger index = 0; index < methodCount; index++) {
        SEL cmd = method_getName(methodList[index]);
        // invocation 执行方法
        NSMethodSignature *signature = [obj methodSignatureForSelector:cmd];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:obj];
        [invocation setSelector:cmd];
        [invocation invoke];
    }
}

- (void)testPrivateProperty {
    NSObject *obj = [NSObject new];

    unsigned int propertyCount;
    objc_property_t *propertyList = class_copyPropertyList(obj.class, &propertyCount);
    for (NSInteger index = 0; index < propertyCount; index++) {
        objc_property_t property = propertyList[index];
        // 获取属性名
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        // 利用 KVC 获取成员变量
        id ivar = [obj valueForKey:propertyName];
    }
}

@end
