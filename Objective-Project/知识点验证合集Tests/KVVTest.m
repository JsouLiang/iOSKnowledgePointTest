//
//  KVVTest.m
//  知识点验证合集Tests
//
//  Created by X-Liang on 2017/10/29.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Person.h"

@interface KVVTest : XCTestCase

@end

@implementation KVVTest

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

- (void)testValidateValue {
    Person *person = [Person new];
    NSString *nameKey = @"name";
    NSString *nameValue = @"name";
    NSString *loveKey = @"love";
    NSString *loveValue = @"love";
    [person validateValue:&nameValue forKey:nameKey error:nil];
    [person validateValue:&loveValue forKey:loveKey error:nil];
}

@end
