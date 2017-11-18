//
//  CustomView.h
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

//@class CustomView;
//@protocol CustomViewDelegate<NSObject>
//@optional
//- (void)touchView: (CustomView *)view;
//@end

@interface CustomView : UIView
//@property (nonatomic, weak) id<CustomViewDelegate> delegate;

@property (nonatomic, strong) RACSubject *subject;

@end
