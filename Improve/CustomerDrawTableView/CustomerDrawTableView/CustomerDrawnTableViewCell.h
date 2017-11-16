//
//  CustomerDrawnTableViewCell.h
//  CustomerDrawTableView
//
//  Created by X-Liang on 2017/11/16.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "DrawnableTableViewCell.h"

@interface CustomerDrawnTableViewCell :DrawnableTableViewCell
- (void)setTitle:(NSString*) title subTitle:(NSString*) subTitle time:(NSString*) time thumbnail:(UIImage *)aThumbnail;
@end
