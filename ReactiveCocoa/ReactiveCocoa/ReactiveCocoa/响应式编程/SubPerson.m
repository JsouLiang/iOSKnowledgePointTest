//
//  SubPerson.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "SubPerson.h"

@implementation SubPerson
- (void)test {
    /**
     self -> SubPerson
     super 还是当前对象，super 是指让当前对象调用父类的方法
     */
    NSLog(@"\n self class: %@;\n self superclass: %@;\n super class:%@;\n super superclass:%@\n", [self class], \
          [self superclass], [super class], [super superclass]);
    [super test];
}
@end
