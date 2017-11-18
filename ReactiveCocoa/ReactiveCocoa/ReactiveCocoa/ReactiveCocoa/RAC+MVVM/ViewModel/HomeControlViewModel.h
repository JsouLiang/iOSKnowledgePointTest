//
//  HomeControlViewModel.h
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACCommand;
@interface HomeControlViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *loadHomeDataCommand;
@property (nonatomic, strong) NSArray *recommands;

- (void)bindViewModel: (UIView *)bindedView;

@end
