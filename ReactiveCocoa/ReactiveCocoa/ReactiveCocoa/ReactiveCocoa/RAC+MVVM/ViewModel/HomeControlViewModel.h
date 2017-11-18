//
//  HomeControlViewModel.h
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RACCommand;
@interface HomeControlViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *loadHomeDataCommand;


@end
