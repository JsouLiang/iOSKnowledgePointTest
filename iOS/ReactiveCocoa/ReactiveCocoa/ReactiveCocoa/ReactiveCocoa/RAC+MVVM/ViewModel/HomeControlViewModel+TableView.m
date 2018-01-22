//
//  HomeControlViewModel+TableView.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "HomeControlViewModel+TableView.h"
#import "HomeRecommandTableViewCell.h"
#import "HomeCellViewModel.h"
#import <objc/runtime.h>
@implementation HomeControlViewModel (TableView)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeCellModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeRecommandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeRecommandTableViewCell" forIndexPath:indexPath];
//    cell.item = self.recommands[indexPath.row];
    HomeCellViewModel *viewModel = self.homeCellModels[indexPath.row];
    [viewModel bindViewModelForView:cell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
@end
