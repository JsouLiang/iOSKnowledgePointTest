//
//  Bindable.h
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/19.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Bindable <NSObject>
- (void)bindViewModelForView: (UIView *)view;
@end
