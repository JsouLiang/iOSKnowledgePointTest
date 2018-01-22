//
//  DrawnableTableViewCell.m
//  CustomerDrawTableView
//
//  Created by X-Liang on 2017/11/16.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "DrawnableTableViewCell.h"

@interface DrawView: UIView
@end

@implementation DrawView
- (void)drawRect:(CGRect)rect {
    [(DrawnableTableViewCell *)[self superview] drawContentInReact:rect];
}
@end

@implementation DrawnableTableViewCell {
    DrawView *contentView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        contentView = [[DrawView alloc] init];
        contentView.opaque = YES;     // 不透明的 View 设置 opaqua = yes 后提高性能
        self.contentView.opaque = YES;
        [self addSubview:contentView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    CGRect bounds = self.bounds;
    bounds.size.height -= 1;
    contentView.frame = bounds;
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
    [contentView setNeedsLayout];   // contentView 需要重新布局
}

- (void)drawContentInReact:(CGRect)rect {}

@end
