//
//  Person.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/17.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "Person.h"

@implementation Person
- (void)test {
    NSLog(@"Person: \n self class: %@;\n self superclass: %@;\n super class:%@;\n super superclass:%@\n", [self class], \
          [self superclass], [super class], [super superclass]);
}
@end
