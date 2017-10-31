//
//  KVOTest.m
//  知识点验证合集Tests
//
//  Created by X-Liang on 2017/10/29.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "Person.h"

@interface KVOTest : XCTestCase

@end

@implementation KVOTest


- (void)testClass {
    Person *person = [Person new];
    [person addObserver:self
             forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    person.name = @"123";
    NSLog(@"self.class: %@ --- objc_getClass: %@", person.class, object_getClass(person));
    // self.class: Person --- objc_getClass: NSKVONotifying_Person
}

- (void)testChangePersonClass {
    Person *person = [Person new];
    Class subClass = [self createSubClass:person];
    object_setClass(person, subClass);      // object_setClass 会改变 isa 指针
    NSLog(@"self.class: %@ --- objc_getClass: %@", person.class, object_getClass(person));
    // self.class: Person --- objc_getClass: NSKVONotifying_Person
}

- (Class)createSubClass:(id)obj {
    Class basedClass = object_getClass(obj);
    Class subClass = objc_allocateClassPair(basedClass, [NSString stringWithFormat:@"%s-MiddleClass", object_getClassName(obj)].UTF8String, 0);
    
    return subClass;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
}

@end
