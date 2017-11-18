//
//  RACMVVMViewController.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "RACMVVMViewController.h"
#import "HomeControlViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "HomeRecommandTableViewCell.h"
@interface RACMVVMViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) HomeControlViewModel *homeControlViewModel;
@property (nonatomic, strong) NSArray *recommands;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation RACMVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 请求数据
    @weakify(self)
    [[self.homeControlViewModel.loadHomeDataCommand execute:nil] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSLog(@"%@",x);
        self.recommands = x;
        [self.tableView reloadData];
    } error:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeRecommandTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeRecommandTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recommands.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeRecommandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeRecommandTableViewCell" forIndexPath:indexPath];
    cell.item = self.recommands[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - lazy load
- (HomeControlViewModel *)homeControlViewModel {
    if (!_homeControlViewModel) {
        _homeControlViewModel = [[HomeControlViewModel alloc] init];
    }
    return _homeControlViewModel;
}
@end
