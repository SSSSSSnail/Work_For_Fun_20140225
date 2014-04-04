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

@property (strong, nonatomic) NSArray *checkingStringArray;

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

    self.lcjcTableViewLabelTextArray = @[@"血常规", @"尿常规", @"血生化", @"凝血筛查",
                                         @"直肠指诊", @"心电图", @"超声心动", @"胸片",
                                         @"B超", @"前列腺特异抗原PSA", @"睾酮", @"放射性核素骨扫描",
                                         @"盆腔核磁共振MR", @"ECOG评分", @"穿刺活检", @"CT检查"];
    self.lcjcTableToImageNameArray = @[@"xuechanggui", @"niaochanggui", @"xueshenghua", @"ningxueshaicha",
                                       @"zhichangzhizhen", @"xindiantu", @"chaoshengxindong", @"xiongpian",
                                       @"BChao", @"qianliexianteyikangyuan", @"gaotong", @"gusaomiao",
                                       @"penqianghecigongzhen", @"ECOGpingfen", @"chuancihuojian", @"CTjiancha"];

    UILabel *lcjcHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
    lcjcHeaderLabel.textAlignment = NSTextAlignmentCenter;
    lcjcHeaderLabel.text = @"选择相关检查项目";
    lcjcHeaderLabel.font = [UIFont miscrosoftYaHeiFontWithSize:22.0f];
    lcjcHeaderLabel.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    _tableviewLCJC.tableHeaderView = lcjcHeaderLabel;

    _isLocked = NO;
    self.checkingStringArray = @[@"xcg", @"ncg", @"xsh", @"nxcc", @"zczz", @"xdt", @"csxd", @"xp",
                             @"bc", @"psa", @"gt", @"gsm", @"mr", @"ecog", @"cchj", @"ct"];
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
    NSString *selectedString;
    if (GInstance().globalData.isFSSetp2) {
        selectedString = GInstance().globalData.lcjcSelectedArrayStringR2;
    } else {
        selectedString = GInstance().globalData.lcjcSelectedArrayString;
    }
    
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
    if (GInstance().globalData.isFSSetp2) {
        [self tableView:tableView didSelectRowForR2AtIndexPath:indexPath];
    } else {
        [self tableView:tableView didSelectRowForR1AtIndexPath:indexPath];
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
        if (GInstance().globalData.isFSSetp2) {
            if (GInstance().globalData.lcjcSelectedArrayStringR2.length == 0) {
                [GInstance() showInfoMessage:@"请完成检查步骤！"];
                return;
            }
        } else {
            if (GInstance().globalData.lcjcSelectedArrayString.length == 0) {
                [GInstance() showInfoMessage:@"请完成检查步骤！"];
                return;
            }
        }
        if ([_scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
            [_scrollViewDelegate didClickConfirmButton:sender];
        }
    }
}

#pragma mark - Reload Data
- (void)reloadViewDataForR2
{
    _dateTimeLabel.text = GInstance().globalData.dateTimeOneMonth;
}

#pragma mark - Private Method

- (NSString *)r2TyeString:(NSInteger)row
{
    if (GInstance().globalData.r2Type > 0) {
        return [NSString stringWithFormat:@"%@M%ld", _lcjcTableToImageNameArray[row],GInstance().globalData.r2Type - 20];
    } else {
        return [NSString stringWithFormat:@"%@", _lcjcTableToImageNameArray[row]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowForR2AtIndexPath:(NSIndexPath *)indexPath
{
    LLGlobalData *globalData = GInstance().globalData;
    if (globalData.lcjcSelectedArrayStringR2.length == 0) {
        globalData.lcjcSelectedArrayStringR2 = [NSString string];
    }

    NSArray *selectedArray = [GInstance().globalData.lcjcSelectedArrayStringR2 componentsSeparatedByString:@","];
    if (_isLocked) {
        if ([selectedArray containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
            if ([selectedArray containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
                _lcjcResultImageView.image = [UIImage imageNamed: [self r2TyeString:indexPath.row]];
                _isLcjcDeatilView = YES;
                [UIView transitionFromView:_tableviewLCJC
                                    toView:_lcjcResultImageView
                                  duration:1.0
                                   options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionShowHideTransitionViews
                                completion:^(BOOL finished) {
                                    [_lcjcOkButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
                                }];
            }
        }
    } else {
        if (![selectedArray containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
#ifndef SKIPREQUEST
            NSMutableDictionary *parametersDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"step": @"7",
                                                                                                        @"action": @"check",
                                                                                                        @"subject_id": globalData.subjectId,
                                                                                                        @"group_id": globalData.groupNumber,
                                                                                                        @"item": _checkingStringArray[indexPath.row]}];
            [GInstance() httprequestWithHUD:self.view
                             withRequestURL:STEPURL
                             withParameters:parametersDictionary
                                 completion:^(NSDictionary *jsonDic) {
                                     NSLog(@"responseJson: %@", jsonDic);
                                     if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                         UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                                         UIImageView *rightImageView = (UIImageView *)[cell viewWithTag:1];
                                         rightImageView.image = [UIImage imageNamed:@"lcjcCellRightButtonSelected.png"];

                                         _lcjcResultImageView.image = [UIImage imageNamed: [self r2TyeString:indexPath.row]];
                                         _isLcjcDeatilView = YES;
                                         globalData.lcjcSelectedArrayStringR2 = [globalData.lcjcSelectedArrayStringR2 stringByAppendingFormat:@"%ld,", (long)indexPath.row];
                                         [GInstance() savaData];

                                         [UIView transitionFromView:_tableviewLCJC
                                                             toView:_lcjcResultImageView
                                                           duration:1.0
                                                            options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionShowHideTransitionViews
                                                         completion:^(BOOL finished) {
                                                             [_lcjcOkButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
                                                         }];
                                     } else {
                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
                                         }
                                     }
                                 }];
#endif
#ifdef SKIPREQUEST
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            UIImageView *rightImageView = (UIImageView *)[cell viewWithTag:1];
            rightImageView.image = [UIImage imageNamed:@"lcjcCellRightButtonSelected.png"];

            _lcjcResultImageView.image = [UIImage imageNamed: [self r2TyeString:indexPath.row]];
            _isLcjcDeatilView = YES;
            globalData.lcjcSelectedArrayStringR2 = [globalData.lcjcSelectedArrayStringR2 stringByAppendingFormat:@"%ld,", (long)indexPath.row];
            [GInstance() savaData];

            [UIView transitionFromView:_tableviewLCJC
                                toView:_lcjcResultImageView
                              duration:1.0
                               options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionShowHideTransitionViews
                            completion:^(BOOL finished) {
                                [_lcjcOkButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
                            }];
#endif
        } else {
            _lcjcResultImageView.image = [UIImage imageNamed: [self r2TyeString:indexPath.row]];
            _isLcjcDeatilView = YES;
            [UIView transitionFromView:_tableviewLCJC
                                toView:_lcjcResultImageView
                              duration:1.0
                               options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionShowHideTransitionViews
                            completion:^(BOOL finished) {
                                [_lcjcOkButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
                            }];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowForR1AtIndexPath:(NSIndexPath *)indexPath
{

    LLGlobalData *globalData = GInstance().globalData;
    if (globalData.lcjcSelectedArrayString.length == 0) {
        globalData.lcjcSelectedArrayString = [NSString string];
    }

    NSMutableDictionary *parametersDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"step": @"2",
                                                                                                @"action": @"check",
                                                                                                @"subject_id": globalData.subjectId,
                                                                                                @"group_id": globalData.groupNumber,
                                                                                                @"item": _checkingStringArray[indexPath.row]}];
    dispatch_semaphore_t t = dispatch_semaphore_create(0);
    if (indexPath.row == 12 && globalData.lcjcChuanCiBA.length == 0 && !_isLocked) {
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"您在临床检查中核磁检查的时机选择？"
                           cancelButtonItem:[RIButtonItem itemWithLabel:@"穿刺活检前" action:^{
            globalData.lcjcChuanCiBA = @"b";
            [parametersDictionary setObject:globalData.lcjcChuanCiBA forKey:@"mrpos"];
            dispatch_semaphore_signal(t);
        }]
                           otherButtonItems:[RIButtonItem itemWithLabel:@"穿刺活检后" action:^{
            globalData.lcjcChuanCiBA = @"a";
            [parametersDictionary setObject:globalData.lcjcChuanCiBA forKey:@"mrpos"];
            dispatch_semaphore_signal(t);
        }], nil] show];
        [parametersDictionary setObject:@"checkMR" forKey:@"action"];
    } else {
        dispatch_semaphore_signal(t);
        [parametersDictionary setObject:@"check" forKey:@"action"];
    }

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(t, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *selectedArray = [GInstance().globalData.lcjcSelectedArrayString componentsSeparatedByString:@","];
            if (_isLocked) {
                if ([selectedArray containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
                    if ([selectedArray containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
                        _lcjcResultImageView.image = [UIImage imageNamed: [self r2TyeString:indexPath.row]];
                        _isLcjcDeatilView = YES;
                        [UIView transitionFromView:_tableviewLCJC
                                            toView:_lcjcResultImageView
                                          duration:1.0
                                           options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionShowHideTransitionViews
                                        completion:^(BOOL finished) {
                                            [_lcjcOkButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
                                        }];
                    }
                }
            } else {
                if (![selectedArray containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
#ifndef SKIPREQUEST
                    [GInstance() httprequestWithHUD:self.view
                                     withRequestURL:STEPURL
                                     withParameters:parametersDictionary
                                         completion:^(NSDictionary *jsonDic) {
                                             NSLog(@"responseJson: %@", jsonDic);
                                             if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                                 UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                                                 UIImageView *rightImageView = (UIImageView *)[cell viewWithTag:1];
                                                 rightImageView.image = [UIImage imageNamed:@"lcjcCellRightButtonSelected.png"];

                                                 _lcjcResultImageView.image = [UIImage imageNamed: [self r2TyeString:indexPath.row]];
                                                 _isLcjcDeatilView = YES;
                                                 globalData.lcjcSelectedArrayString = [globalData.lcjcSelectedArrayString stringByAppendingFormat:@"%ld,", (long)indexPath.row];
                                                 [GInstance() savaData];

                                                 [UIView transitionFromView:_tableviewLCJC
                                                                     toView:_lcjcResultImageView
                                                                   duration:1.0
                                                                    options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionShowHideTransitionViews
                                                                 completion:^(BOOL finished) {
                                                                     [_lcjcOkButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
                                                                 }];
                                             } else {
                                                 if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                                     [GInstance() showErrorMessage:@"服务器结果异常!"];
                                                 }
                                             }
                                         }];
#endif
#ifdef SKIPREQUEST
                    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    UIImageView *rightImageView = (UIImageView *)[cell viewWithTag:1];
                    rightImageView.image = [UIImage imageNamed:@"lcjcCellRightButtonSelected.png"];

                    _lcjcResultImageView.image = [UIImage imageNamed: [self r2TyeString:indexPath.row]];
                    _isLcjcDeatilView = YES;
                    globalData.lcjcSelectedArrayString = [globalData.lcjcSelectedArrayString stringByAppendingFormat:@"%ld,", (long)indexPath.row];
                    [GInstance() savaData];

                    [UIView transitionFromView:_tableviewLCJC
                                        toView:_lcjcResultImageView
                                      duration:1.0
                                       options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionShowHideTransitionViews
                                    completion:^(BOOL finished) {
                                        [_lcjcOkButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
                                    }];
#endif
                } else {
                    _lcjcResultImageView.image = [UIImage imageNamed: [self r2TyeString:indexPath.row]];
                    _isLcjcDeatilView = YES;
                    [UIView transitionFromView:_tableviewLCJC
                                        toView:_lcjcResultImageView
                                      duration:1.0
                                       options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionShowHideTransitionViews
                                    completion:^(BOOL finished) {
                                        [_lcjcOkButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
                                    }];
                }
            }

        });
    });
}

@end
