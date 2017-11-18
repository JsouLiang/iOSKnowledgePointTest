//
//  HomeRecommandTableViewCell.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "HomeRecommandTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation HomeRecommandTableViewCell

- (void)setItem:(HomeRecommendItem *)item {
    _item = item;
    [self.iconView sd_setImageWithURL:item.courseImage];
    [self.nameView setText:item.courseName];
    [self.numView setTitle:item.studentNum forState:UIControlStateNormal];
}

@end
