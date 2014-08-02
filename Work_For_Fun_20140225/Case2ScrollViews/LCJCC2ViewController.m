//
//  LCJCC2ViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 27/7/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "LCJCC2ViewController.h"

#define MINIMAGEFRAME CGRectMake(152.0f, 70.0f, 523.0f, 392.0f)
#define MAXIMAGEFRAME CGRectMake(-152.0f, 0, 1024.0f, 768.0f)

@interface LCJCC2ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableviewLCJC;
@property (weak, nonatomic) IBOutlet UIImageView *lcjcResultImageView;
@property (strong, nonatomic) UIImageView *lcjcResultImageViewFull;
@property (assign, nonatomic) BOOL isFullImage;

@property (weak, nonatomic) IBOutlet UIButton *lcjcOkButton;

@property (strong, nonatomic) NSArray *lcjcTableViewLabelTextArray;
@property (strong, nonatomic) NSArray *lcjcTableToImageNameArray;
@property (assign, nonatomic) BOOL isLcjcDeatilView;

@property (strong, nonatomic) NSArray *checkingStringArray;

- (IBAction)confirmClick:(UIButton *)sender;

@end

@implementation LCJCC2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.lcjcTableViewLabelTextArray = @[@"直肠指诊", @"血常规", @"尿常规", @"血生化",
                                         @"凝血筛查", @"心电图", @"超声心动", @"胸片",
                                         @"B超", @"前列腺特异抗原PSA", @"睾酮", @"放射性核素骨扫描",
                                         @"盆腔核磁共振MR", @"ECOG评分", @"CT检查", @"穿刺活检"];

    self.lcjcTableToImageNameArray = @[@"c2zhichangzhizhen", @"c2xuechanggui", @"c2niaochanggui", @"c2xueshenghua",
                                       @"c2ningxueshaicha", @"c2xindiantu", @"c2chaoshengxindong", @"c2xiongpian",
                                       @"c2BChao*", @"c2qianliexianteyikangyuan", @"c2gaotong", @"c2gusaomiao*",
                                       @"c2penqianghecigongzhen*", @"c2ECOGpingfen", @"c2CTjiancha*", @"c2chuancihuojian"];

    self.checkingStringArray = @[@"zczz", @"xcg", @"ncg", @"xsh", @"nxcc", @"xdt", @"csxd", @"xp",
                                 @"bc", @"psa", @"gt", @"gsm", @"mr", @"ecog", @"ct", @"cchj"];

    _isLocked = NO;
    [_tableviewLCJC setContentOffset:CGPointMake(0, 35)];

    self.lcjcResultImageViewFull = [[UIImageView alloc] initWithFrame:MINIMAGEFRAME];
    _lcjcResultImageViewFull.userInteractionEnabled = YES;
    _lcjcResultImageViewFull.contentMode = UIViewContentModeScaleAspectFit;
    _lcjcResultImageViewFull.clipsToBounds = YES;
    _lcjcResultImageViewFull.hidden = YES;
    [self.view addSubview:_lcjcResultImageViewFull];
    _isFullImage = NO;

    UIPinchGestureRecognizer *pinchGestureRecongnizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchResultImageView:)];
    [_lcjcResultImageViewFull addGestureRecognizer:pinchGestureRecongnizer];
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 16;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedString;
    if (GCase2().currentStep == Case2Step1) {
        selectedString = GCase2().lcjcSelectedArrayStringR1;
    } else if(GCase2().currentStep == Case2Step2){
        selectedString = GCase2().lcjcSelectedArrayStringR2;
    } else {
        selectedString = GCase2().lcjcSelectedArrayStringR3;
    }

    BOOL isSelected = [[selectedString componentsSeparatedByString:@","] containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lcjcTableviewCell"];
    cell.textLabel.font = [UIFont miscrosoftYaHeiFontWithSize:22.0f];
    cell.textLabel.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    cell.textLabel.text = _lcjcTableViewLabelTextArray[indexPath.row];

    UILabel *rightLabel = (UILabel *)[cell viewWithTag:1];
    rightLabel.text = @"查看结果";
    rightLabel.font = [UIFont miscrosoftYaHeiFontWithSize:22.0f];

    UIColor *cellBackgroundColor = isSelected?[UIColor colorWithRed:247.0f/255 green:176.0f/255 blue:92.0f/255 alpha:1]:[UIColor whiteColor];
    cell.backgroundColor = cellBackgroundColor;

    return cell;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (GCase2().currentStep == Case2Step1) {
        [self tableView:tableView didSelectRowForR1AtIndexPath:indexPath];
    } else if(GCase2().currentStep == Case2Step2){
        [self tableView:tableView didSelectRowForR2AtIndexPath:indexPath];
    } else {
        [self tableView:tableView didSelectRowForR3AtIndexPath:indexPath];
    }
}

- (IBAction)confirmClick:(UIButton *)sender {
    if (_isLcjcDeatilView) {
        _isLcjcDeatilView = NO;
        _lcjcResultImageViewFull.hidden = YES;
        [UIView transitionFromView:_lcjcResultImageView
                            toView:_tableviewLCJC
                          duration:1.0
                           options:UIViewAnimationOptionTransitionCurlDown | UIViewAnimationOptionShowHideTransitionViews
                        completion:^(BOOL finished) {
                            [_lcjcOkButton setImage:[UIImage imageNamed:@"okButton.png"] forState:UIControlStateNormal];
                        }];
    } else {
        if (GCase2().currentStep == Case2Step1) {
            if (GCase2().lcjcSelectedArrayStringR1.length == 0) {
                [GInstance() showInfoMessage:@"请完成检查步骤！"];
                return;
            }
        } else if(GCase2().currentStep == Case2Step2) {
            if (GCase2().lcjcSelectedArrayStringR2.length == 0) {
                [GInstance() showInfoMessage:@"请完成检查步骤！"];
                return;
            }
        } else {
            if (GCase2().lcjcSelectedArrayStringR3.length == 0) {
                [GInstance() showInfoMessage:@"请完成检查步骤！"];
                return;
            }
        }
        if ([self.scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
            [self.scrollViewDelegate didClickConfirmButton:sender];
        }
    }
}

#pragma mark - Private Method

- (BOOL)reloadResultImageView:(NSInteger)row
{
    BOOL hideFullImage = YES;
    NSString *imageNameString = [NSString stringWithFormat:@"%@", _lcjcTableToImageNameArray[row]];
    if ([imageNameString hasSuffix:@"*"]) {
        imageNameString = [imageNameString substringToIndex:imageNameString.length - 1];
        _lcjcResultImageViewFull.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_full", imageNameString]];
        hideFullImage = NO;
    }

    _lcjcResultImageView.image = [UIImage imageNamed:imageNameString];
    return hideFullImage;
}

- (void)tableView:(UITableView *)tableView didSelectRowForR1AtIndexPath:(NSIndexPath *)indexPath
{
    Case2Data *globalData = GCase2();
    if (globalData.lcjcSelectedArrayStringR1.length == 0) {
        globalData.lcjcSelectedArrayStringR1 = [NSString string];
    }

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:247.0f/255 green:176.0f/255 blue:92.0f/255 alpha:1];

    NSMutableDictionary *parametersDictionary = [@{@"step": @"2",
                                                   @"action": @"check",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber,
                                                   @"item": _checkingStringArray[indexPath.row]} mutableCopy];
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
            NSArray *selectedArray = [GCase2().lcjcSelectedArrayStringR1 componentsSeparatedByString:@","];
            BOOL hideFullImage = [self reloadResultImageView:indexPath.row];

            if (_isLocked) {
                if ([selectedArray containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
                    if ([selectedArray containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
                        _isLcjcDeatilView = YES;
                        [UIView transitionFromView:_tableviewLCJC
                                            toView:_lcjcResultImageView
                                          duration:1.0
                                           options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionShowHideTransitionViews
                                        completion:^(BOOL finished) {
                                            if (_isLcjcDeatilView) {
                                                _lcjcResultImageViewFull.hidden = hideFullImage;
                                            }
                                            [_lcjcOkButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
                                        }];
                    }
                }
            } else {
                if (![selectedArray containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
                    [GInstance() httprequestWithHUD:self.view
                                     withRequestURL:STEPURL
                                     withParameters:parametersDictionary
                                         completion:^(NSDictionary *jsonDic) {
                                             NSLog(@"responseJson: %@", jsonDic);
                                             if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                                 _isLcjcDeatilView = YES;
                                                 globalData.lcjcSelectedArrayStringR1 = [globalData.lcjcSelectedArrayStringR1 stringByAppendingFormat:@"%ld,", (long)indexPath.row];
                                                 [GInstance() savaData];

                                                 [UIView transitionFromView:_tableviewLCJC
                                                                     toView:_lcjcResultImageView
                                                                   duration:1.0
                                                                    options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionShowHideTransitionViews
                                                                 completion:^(BOOL finished) {
                                                                     if (_isLcjcDeatilView) {
                                                                         _lcjcResultImageViewFull.hidden = hideFullImage;
                                                                     }
                                                                     [_lcjcOkButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
                                                                 }];
                                             } else {
                                                 if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                                     [GInstance() showErrorMessage:@"服务器结果异常!"];
                                                 }
                                             }
                                         }];
                } else {
                    _isLcjcDeatilView = YES;
                    [UIView transitionFromView:_tableviewLCJC
                                        toView:_lcjcResultImageView
                                      duration:1.0
                                       options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionShowHideTransitionViews
                                    completion:^(BOOL finished) {
                                        if (_isLcjcDeatilView) {
                                            _lcjcResultImageViewFull.hidden = hideFullImage;
                                        }
                                        [_lcjcOkButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
                                    }];
                }
            }
            
        });
    });
}

- (void)tableView:(UITableView *)tableView didSelectRowForR2AtIndexPath:(NSIndexPath *)indexPath
{
    Case2Data *globalData = GCase2();
    if (globalData.lcjcSelectedArrayStringR2.length == 0) {
        globalData.lcjcSelectedArrayStringR2 = [NSString string];
    }

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:247.0f/255 green:176.0f/255 blue:92.0f/255 alpha:1];

    NSMutableDictionary *parametersDictionary = [@{@"step": @"7",
                                                   @"action": @"check",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber,
                                                   @"item": _checkingStringArray[indexPath.row]} mutableCopy];

    NSArray *selectedArray = [GCase2().lcjcSelectedArrayStringR2 componentsSeparatedByString:@","];
    BOOL hideFullImage = [self reloadResultImageView:indexPath.row];

    if (_isLocked) {
        if ([selectedArray containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
            if ([selectedArray containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
                _isLcjcDeatilView = YES;
                [UIView transitionFromView:_tableviewLCJC
                                    toView:_lcjcResultImageView
                                  duration:1.0
                                   options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionShowHideTransitionViews
                                completion:^(BOOL finished) {
                                    if (_isLcjcDeatilView) {
                                        _lcjcResultImageViewFull.hidden = hideFullImage;
                                    }
                                    [_lcjcOkButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
                                }];
            }
        }
    } else {
        if (![selectedArray containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
            [GInstance() httprequestWithHUD:self.view
                             withRequestURL:STEPURL
                             withParameters:parametersDictionary
                                 completion:^(NSDictionary *jsonDic) {
                                     NSLog(@"responseJson: %@", jsonDic);
                                     if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                         _isLcjcDeatilView = YES;
                                         globalData.lcjcSelectedArrayStringR2 = [globalData.lcjcSelectedArrayStringR2 stringByAppendingFormat:@"%ld,", (long)indexPath.row];
                                         [GInstance() savaData];

                                         [UIView transitionFromView:_tableviewLCJC
                                                             toView:_lcjcResultImageView
                                                           duration:1.0
                                                            options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionShowHideTransitionViews
                                                         completion:^(BOOL finished) {
                                                             if (_isLcjcDeatilView) {
                                                                 _lcjcResultImageViewFull.hidden = hideFullImage;
                                                             }
                                                             [_lcjcOkButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
                                                         }];
                                     } else {
                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
                                         }
                                     }
                                 }];
        } else {
            _isLcjcDeatilView = YES;
            [UIView transitionFromView:_tableviewLCJC
                                toView:_lcjcResultImageView
                              duration:1.0
                               options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionShowHideTransitionViews
                            completion:^(BOOL finished) {
                                if (_isLcjcDeatilView) {
                                    _lcjcResultImageViewFull.hidden = hideFullImage;
                                }
                                [_lcjcOkButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
                            }];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowForR3AtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)pinchResultImageView:(UIPinchGestureRecognizer *)sender
{
    if (sender.scale > 1.2f && !_isFullImage) {
        [UIView animateWithDuration:0.5 animations:^{
            _lcjcResultImageViewFull.frame = MAXIMAGEFRAME;
        } completion:^(BOOL finished) {
            _isFullImage = YES;
        }];
    }

    if (sender.scale < 0.8f && _isFullImage) {
        [UIView animateWithDuration:0.5 animations:^{
            _lcjcResultImageViewFull.frame = MINIMAGEFRAME;
        } completion:^(BOOL finished) {
            _isFullImage = NO;
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end