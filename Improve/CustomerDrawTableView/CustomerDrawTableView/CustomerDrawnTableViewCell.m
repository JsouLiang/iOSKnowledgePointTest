//
//  CustomerDrawnTableViewCell.m
//  CustomerDrawTableView
//
//  Created by X-Liang on 2017/11/16.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "CustomerDrawnTableViewCell.h"

@interface CustomerDrawnTableViewCell()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *timeTile;
@property (nonatomic, strong) UIImage *thumbnail;
@end

@implementation CustomerDrawnTableViewCell
static UIFont *titleFont;
static UIFont *subTitleFont;
static UIFont *timeTitleFont;

+ (void)initialize {
    titleFont = [UIFont systemFontOfSize:17];
    subTitleFont = [UIFont systemFontOfSize:13];
    timeTitleFont = [UIFont systemFontOfSize:10];
}

- (void)setTitle:(NSString *)title subTitle:(NSString *)subTitle time:(NSString *)time thumbnail:(UIImage *)aThumbnail {
    self.title = title;
    self.subTitle = subTitle; self.timeTile = time;
    self.thumbnail = aThumbnail;
    [self setNeedsLayout];
}

- (void)drawContentInReact:(CGRect)rect {
    static UIColor *titleColor;
    titleColor = [UIColor darkTextColor];
    static UIColor *subTitleColor;
    subTitleColor = [UIColor darkGrayColor];
    static UIColor *timeTitleColor;
    timeTitleColor = [UIColor colorWithRed:0 green:0 blue:255 alpha:0.7];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.highlighted || self.selected) {
        CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextFillRect(context, rect);
//        CGContextSetFillColorWithColor(context, titleColor.CGColor);
    } else {
        CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextFillRect(context, rect);
//        CGContextSetFillColorWithColor(context, titleColor.CGColor);
    }
    [titleColor set];
    
    [_thumbnail drawInRect:CGRectMake(12, 4, 35, 35)];
    [_title drawAtPoint:CGPointMake(54, 3)
               forWidth:200
               withFont:titleFont
               fontSize:17
          lineBreakMode:UILineBreakModeTailTruncation
     baselineAdjustment:UIBaselineAdjustmentAlignCenters];
    
    [subTitleColor set];
    [_subTitle drawAtPoint:CGPointMake(54, 23)
                  forWidth:200
                  withFont:subTitleFont
                  fontSize:13
             lineBreakMode:UILineBreakModeTailTruncation
        baselineAdjustment:UIBaselineAdjustmentAlignCenters];
    
    [timeTitleColor set];
    [_timeTile drawAtPoint:CGPointMake(262, 3)
                   forWidth:62
                   withFont:timeTitleFont
                   fontSize:10
              lineBreakMode:UILineBreakModeTailTruncation
         baselineAdjustment:UIBaselineAdjustmentAlignCenters];

}

//- (void)fillRect: (CGRect)rect ofContext: (CGContextRef)context {
//    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
//    CGContextFillRect(context, rect);
//    CGContextSetFillColorWithColor(context, titleColor.CGColor);
//}

@end
