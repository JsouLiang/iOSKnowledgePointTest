//
//  MutableDelegate.h
//  知识点验证合集
//
//  Created by X-Liang on 2017/11/2.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MutableDelegate : NSObject
@property (nonatomic, strong) IBOutletCollection(id) NSArray* delegateTargets;
@end
