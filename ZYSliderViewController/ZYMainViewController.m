//
//  ZYMainViewController.m
//  ZYSliderViewController
//
//  Created by zY on 16/11/10.
//  Copyright © 2016年 zY. All rights reserved.
//

#import "ZYMainViewController.h"
#import "UIViewController+ZYSliderViewController.h"
#import "ZYSliderViewController.h"
#import <Masonry/Masonry.h>

@interface ZYMainViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZYMainViewController

#pragma mark - Initialization

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = @[@"line1",@"line2",@"line3"];
    [self configSubviews];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIEdgeInsets safeInset = self.view.safeAreaInsets;
        NSLog(@"ok");
    });
}

#pragma mark - Actions
- (void)showLeftAction
{
    [[self sliderViewController] showLeft];
}

- (void)showRightAction
{
    [[self sliderViewController] showRight];
}

#pragma mark - Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Private methods
- (void)configSubviews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.leading.trailing.equalTo(self.view);
            make.top.equalTo(self.mas_topLayoutGuide);
            make.bottom.equalTo(self.mas_bottomLayoutGuide);
        }
    }];
    [self configNavItem];
}
- (void)configNavItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showLeftAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(showRightAction)];
}
#pragma mark - Setter && Getter
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 44.f;
        tableView.tableFooterView = [UIView new];
        tableView.backgroundColor = [UIColor greenColor];
        _tableView = tableView;
    }
    return _tableView;
}

@end
