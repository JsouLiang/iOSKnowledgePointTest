//
//  RACMVVMViewController.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "RACMVVMViewController.h"
#import "HomeControlViewModel.h"
#import "HomeControlViewModel+TableView.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface RACMVVMViewController ()
@property (nonatomic, strong) HomeControlViewModel *homeControlViewModel;
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
//        self.recommands = x;
        [self.tableView reloadData];
    } error:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
    // 绑定视图模型, 对控件的设置，都放到 bindViewModel 方法中
    [self.homeControlViewModel bindViewModelForView:self.tableView];
}

#pragma mark - lazy load
- (HomeControlViewModel *)homeControlViewModel {
    if (!_homeControlViewModel) {
        _homeControlViewModel = [[HomeControlViewModel alloc] init];
    }
    return _homeControlViewModel;
}
@end
