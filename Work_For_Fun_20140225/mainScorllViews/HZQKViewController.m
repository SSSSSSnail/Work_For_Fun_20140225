//
//  HZQKViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 14/3/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "HZQKViewController.h"

@interface HZQKViewController ()<UITableViewDataSource>

- (IBAction)confirmClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UITableView *bshgTable;

@end

@implementation HZQKViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UILabel *lcjcHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
    lcjcHeaderLabel.textAlignment = NSTextAlignmentCenter;
    lcjcHeaderLabel.text = @"病史回顾";
    lcjcHeaderLabel.font = [UIFont miscrosoftYaHeiFontWithSize:22.0f];
    lcjcHeaderLabel.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    _bshgTable.tableHeaderView = lcjcHeaderLabel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
}

#pragma mark - Reload Data
- (void)reloadViewDataForR2
{
    _bgImageView.hidden = YES;
    _bshgTable.hidden = NO;

}

- (IBAction)confirmClick:(UIButton *)sender {
    if ([_scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
        [_scrollViewDelegate didClickConfirmButton:sender];
    }
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
    cell.textLabel.font = [UIFont miscrosoftYaHeiFontWithSize:14.0f];
    cell.textLabel.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    cell.textLabel.text = @"测试";

    return cell;
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

@end
