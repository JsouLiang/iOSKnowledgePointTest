//
//  Transaction.h
//  知识点验证合集
//
//  Created by X-Liang on 2017/11/14.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject
+ (instancetype)transcationWithTarget: (id)target selector: (SEL)selector;
- (void)commit;
@end
