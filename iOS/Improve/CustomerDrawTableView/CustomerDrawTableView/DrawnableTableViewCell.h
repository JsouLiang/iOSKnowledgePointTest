//
//  DrawnableTableViewCell.h
//  CustomerDrawTableView
//
//  Created by X-Liang on 2017/11/16.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawnableTableViewCell : UITableViewCell
// 子类重写
- (void)drawContentInReact: (CGRect)rect;
@end
