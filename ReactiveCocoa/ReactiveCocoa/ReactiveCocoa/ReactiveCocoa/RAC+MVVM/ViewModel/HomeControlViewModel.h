//
//  HomeControlViewModel.h
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bindable.h"
@class RACCommand, HomeCellViewModel;
@interface HomeControlViewModel : NSObject<Bindable>

@property (nonatomic, strong, readonly) RACCommand *loadHomeDataCommand;
//@property (nonatomic, strong) NSArray *recommands;
@property (nonatomic, strong) NSArray *homeCellModels;

@end
