//
//  Person.m
//  Test
//
//  Created by X-Liang on 2017/10/29.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "Person.h"

@implementation Person

- (BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKey:(NSString *)inKey error:(out NSError * _Nullable __autoreleasing *)outError {
    NSString *inputValue = *ioValue;
    NSLog(@"validateValue: %@", inputValue);
    return YES;
}

-(BOOL)validateName:(id *)value error:(out NSError * _Nullable __autoreleasing *)outError{  //在implementation里面加这个方法，它会验证是否设了非法的value
    NSString *inputValue = *value;
    NSLog(@"validateName: %@", inputValue);
    return YES;
}

-(BOOL)validateLove:(id *)value error:(out NSError * _Nullable __autoreleasing *)outError{  //在implementation里面加这个方法，它会验证是否设了非法的value
    NSString *inputValue = *value;
    NSLog(@"validateLove: %@", inputValue);
    return YES;
}

@end
