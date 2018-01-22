//
//  AppDelegate.h
//  知识点验证合集
//
//  Created by X-Liang on 2017/10/29.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunloopSource.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (void)registerSource: (RunloopContext *)sourceInfo;
- (void)removeSource: (RunloopContext *)sourceInfo;
@end

