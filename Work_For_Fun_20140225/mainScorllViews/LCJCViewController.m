//
//  LCJCViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 15/3/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "LCJCViewController.h"

@interface LCJCViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableviewLCJC;
@property (weak, nonatomic) IBOutlet UIImageView *lcjcResultImageView;
@property (weak, nonatomic) IBOutlet UIButton *lcjcOkButton;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;

@property (strong, nonatomic) NSArray *lcjcTableViewLabelTextArray;
@property (strong, nonatomic) NSArray *lcjcTableToImageNameArray;
@property (assign, nonatomic) BOOL isLcjcDeatilView;

- (IBAction)confirmClick:(UIButton *)sender;

@end

@implementation LCJCViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.lcjcTableViewLabelTextArray = @[@"血常规", @"尿常规", @"血生化", @"凝血筛查", @"直肠指诊", @"心电图", @"超声心动", @"胸片", @"B超",
                                         @"前列腺特异抗原PSA", @"睾酮", @"放射性核素骨扫描", @"盆腔核磁共振MR", @"ECOG评分", @"穿刺活检", @"CT检查"];
    self.lcjcTableToImageNameArray = @[@"xuechanggui.png", @"niaochanggui.png", @"xueshenghua.png", @"ningxueshaicha.png",
                                       @"zhichangzhizhen.png", @"xindiantu.png", @"chaoshengxindong.png", @"xiongpian.png",
                                       @"BChao.png", @"qianliexianteyikangyuan.png", @"gaotong.png", @"fangshexinghesugusaomiao.png",
                                       @"penqianghecigongzhen.png", @"ECOGpingfen.png", @"chuancihuojian.png", @"CTjiancha.png"];

    UILabel *lcjcHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
    lcjcHeaderLabel.textAlignment = NSTextAlignmentCenter;
    lcjcHeaderLabel.text = @"选择相关检查项目";
    lcjcHeaderLabel.font = [UIFont miscrosoftYaHeiFontWithSize:22.0f];
    lcjcHeaderLabel.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    _tableviewLCJC.tableHeaderView = lcjcHeaderLabel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 16;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedString = GInstance().globalData.lcjcSelectedArrayString;
    BOOL isSelected = [[selectedString componentsSeparatedByString:@","] containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    NSString *rightImageName = isSelected?@"lcjcCellRightButtonSelected.png":@"lcjcCellRightButtonUnselected.png";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lcjcTableviewCell"];
    cell.textLabel.font = [UIFont miscrosoftYaHeiFontWithSize:22.0f];
    cell.textLabel.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    UIImageView *rightImageView = (UIImageView *)[cell viewWithTag:1];
    rightImageView.image = [UIImage imageNamed:rightImageName];
	cell.textLabel.text = _lcjcTableViewLabelTextArray[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (GInstance().globalData.lcjcSelectedArrayString.length == 0) {
        GInstance().globalData.lcjcSelectedArrayString = [NSString string];
    }
    NSArray *selectedArray = [GInstance().globalData.lcjcSelectedArrayString componentsSeparatedByString:@","];

    if (![selectedArray containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]] && GInstance().globalData.maxIndex == 1) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIImageView *rightImageView = (UIImageView *)[cell viewWithTag:1];
        rightImageView.image = [UIImage imageNamed:@"lcjcCellRightButtonSelected.png"];
        GInstance().globalData.lcjcSelectedArrayString = [GInstance().globalData.lcjcSelectedArrayString stringByAppendingFormat:@"%ld,", (long)indexPath.row];
    }
    dispatch_semaphore_t t = dispatch_semaphore_create(0);
    if (indexPath.row == 12 && GInstance().globalData.lcjcChuanCiBA.length == 0 && GInstance().globalData.maxIndex == 1) {
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"您在临床检查中核磁检查的时机选择？"
                           cancelButtonItem:[RIButtonItem itemWithLabel:@"穿刺活检前" action:^{
            GInstance().globalData.lcjcChuanCiBA = @"B";
            dispatch_semaphore_signal(t);

        }]
                           otherButtonItems:[RIButtonItem itemWithLabel:@"穿刺活检后" action:^{
            GInstance().globalData.lcjcChuanCiBA = @"A";
            dispatch_semaphore_signal(t);
        }], nil] show];
    } else {
        dispatch_semaphore_signal(t);
    }

    if (GInstance().globalData.maxIndex == 1 || (GInstance().globalData.maxIndex > 1 && [selectedArray containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]])) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_semaphore_wait(t, DISPATCH_TIME_FOREVER);
            dispatch_async(dispatch_get_main_queue(), ^{
                _lcjcResultImageView.image = [UIImage imageNamed:_lcjcTableToImageNameArray[indexPath.row]];
                _isLcjcDeatilView = YES;
                [UIView transitionFromView:_tableviewLCJC
                                    toView:_lcjcResultImageView
                                  duration:1.0
                                   options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionShowHideTransitionViews
                                completion:^(BOOL finished) {
                                    [_lcjcOkButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
                                }];
            });
        });
    }
}

- (IBAction)confirmClick:(UIButton *)sender {
    if (_isLcjcDeatilView) {
        _isLcjcDeatilView = NO;
        [UIView transitionFromView:_lcjcResultImageView
                            toView:_tableviewLCJC
                          duration:1.0
                           options:UIViewAnimationOptionTransitionCurlDown | UIViewAnimationOptionShowHideTransitionViews
                        completion:^(BOOL finished) {
                            [_lcjcOkButton setImage:[UIImage imageNamed:@"okButton.png"] forState:UIControlStateNormal];
                        }];
    } else {
        if ([_scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
            [_scrollViewDelegate didClickConfirmButton:sender];
        }
    }
}

#pragma mark - Reload Data
- (void)reloadViewDataForR2
{

}

@end
