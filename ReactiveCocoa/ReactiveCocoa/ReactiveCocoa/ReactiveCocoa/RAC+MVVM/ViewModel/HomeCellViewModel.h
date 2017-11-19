//
//  HomeCellViewModel.h
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/19.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bindable.h"
@class HomeRecommendItem;
// 处理 Cell 的显示和业务逻辑
@interface HomeCellViewModel : NSObject<Bindable>
@property (nonatomic, strong) HomeRecommendItem *item;
@end
