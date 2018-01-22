//
//  HomeCellViewModel.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/19.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "HomeCellViewModel.h"
#import "HomeRecommandTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation HomeCellViewModel

- (void)bindViewModelForView:(UIView *)view {
    HomeRecommandTableViewCell *cell = (HomeRecommandTableViewCell *)view;
    [cell.iconView sd_setImageWithURL: [NSURL URLWithString:self.item.courseImage]];
    [cell.nameView setText:self.item.courseName];
    [cell.numView setTitle:self.item.studentNum forState:UIControlStateNormal];
}

@end
