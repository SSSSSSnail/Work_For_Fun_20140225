//
//  LCJCC3ViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 27/7/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "LCJCC3ViewController.h"
#import "LLGlobalContant.h"

#define MINIMAGEFRAME CGRectMake(166.0f, 75.0f, 497.0f, 374.0f)
#define MAXIMAGEFRAME CGRectMake(-152.0f, 0, 1024.0f, 768.0f)

@interface LCJCC3ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *tableViewSuperView;
@property (weak, nonatomic) IBOutlet UITableView *tableviewLCJC;
@property (weak, nonatomic) IBOutlet UIImageView *lcjcResultImageView;
@property (strong, nonatomic) UIImageView *lcjcResultImageViewFull;
@property (assign, nonatomic) BOOL isFullImage;

@property (weak, nonatomic) IBOutlet UIButton *lcjcOkButton;

@property (strong, nonatomic) NSArray *lcjcTableViewLabelTextArray;
@property (strong, nonatomic) NSArray *lcjcTableToImageNameArray;
@property (assign, nonatomic) BOOL isLcjcDeatilView;

@property (strong, nonatomic) NSArray *checkingStringArray;

@property (strong, nonatomic) NSArray *imageMappingArray;

- (IBAction)confirmClick:(UIButton *)sender;

@end

@implementation LCJCC3ViewController

- (void)refresh
{
    if (GCase3().currentIndex != 1) {
        CGRect tableFrame = _tableviewLCJC.frame;
        tableFrame.size.height = 602.0f;
        _tableviewLCJC.frame = tableFrame;

    } else {
        CGRect tableFrame = _tableviewLCJC.frame;
        tableFrame.size.height = 642.0f;
        _tableviewLCJC.frame = tableFrame;
    }
    [_tableviewLCJC reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.lcjcTableViewLabelTextArray = @[@"直肠指诊", @"血常规", @"尿常规", @"血生化",
                                         @"凝血筛查", @"心电图", @"超声心动", @"胸片",
                                         @"B超", @"前列腺特异抗原PSA", @"睾酮", @"放射性核素骨扫描",
                                         @"盆腔核磁共振MR", @"ECOG评分", @"CT检查", @"穿刺活检"];

    self.lcjcTableToImageNameArray = @[@"c3zhichangzhizhen", @"c3xuechanggui", @"c3niaochanggui", @"c3xueshenghua",
                                       @"c3ningxueshaicha", @"c3xindiantu", @"c3chaoshengxindong", @"c3xiongpian",
                                       @"c3Bchao*", @"c3qianliexianteyikangyuan", @"c3gaotong", @"c3gusaomiao*",
                                       @"c3penqianghecigongzhen*", @"c3ECOGpingfen", @"c3CTjiancha*", @"c3chuancihuojian"];

    self.checkingStringArray = @[@"zczz", @"xcg", @"ncg", @"xsh", @"nxcc", @"xdt", @"csxd", @"xp",
                                 @"bc", @"psa", @"gt", @"gsm", @"mr", @"ecog", @"ct", @"cchj"];

    _isLocked = NO;

    self.lcjcResultImageViewFull = [[UIImageView alloc] initWithFrame:MINIMAGEFRAME];
    _lcjcResultImageViewFull.userInteractionEnabled = YES;
    _lcjcResultImageViewFull.contentMode = UIViewContentModeScaleAspectFit;
    _lcjcResultImageViewFull.clipsToBounds = YES;
    _lcjcResultImageViewFull.hidden = YES;
    [self.view addSubview:_lcjcResultImageViewFull];
    _isFullImage = NO;

    UIPinchGestureRecognizer *pinchGestureRecongnizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchResultImageView:)];
    [_lcjcResultImageViewFull addGestureRecognizer:pinchGestureRecongnizer];

    self.imageMappingArray = @[//直肠指诊
                               @[@"", @"M12", @"M12", @"M3", @"M456", @"M456", @"M456"],
                               //血常规
                               @[@"", @"",    @"",    @"",   @"",     @"",     @""],
                               //尿常规
                               @[@"", @"",    @"",    @"",   @"",     @"",     @""],
                               //血生化
                               @[@"", @"M13456", @"M2", @"M13456", @"M13456", @"M13456", @"M13456"],
                               //凝血筛查
                               @[@"", @"",    @"",    @"",   @"",     @"",     @""],
                               //心电图
                               @[@"", @"",    @"",    @"",   @"",     @"",     @""],
                               //超声心动
                               @[@"", @"",    @"",    @"",   @"",     @"",     @""],
                               //胸片
                               @[@"", @"",    @"",    @"",   @"",     @"",     @""],
                               //B超
                               @[@"", @"M123",  @"M123", @"M123", @"M456", @"M456", @"M456"],
                               //PSA
                               @[@"", @"M1",    @"M2",    @"M3",   @"M4", @"M5", @"M6"],
                               //睾酮
                               @[@"", @"M12345", @"M12345", @"M12345", @"M12345", @"M12345", @"M6"],
                               //骨扫描
                               @[@"", @"",    @"",    @"",   @"",     @"",     @""],
                               //MR
                               @[@"", @"M123", @"M123", @"M123", @"M456", @"M456", @"M456"],
                               //ECOG
                               @[@"", @"",    @"",    @"",   @"",     @"",     @""],
                               //CT
                               @[@"", @"M123", @"M123", @"M123", @"M456", @"M456", @"M456"]];
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return GCase3().currentIndex == 1 ? 16 : 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedString;
    if (GCase3().currentIndex == 1) {
        selectedString = GCase3().lcjcSelectedArrayStringR1;
    } else if(GCase3().currentIndex == 6){
        selectedString = GCase3().lcjcSelectedArrayStringR2;
    } else {
        selectedString = GCase3().lcjcSelectedArrayStringR3;
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
    if (GCase3().currentIndex == 1) {
        [self tableView:tableView didSelectRowForR1AtIndexPath:indexPath];
    } else if(GCase3().currentIndex == 6){
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
        if (GCase3().currentIndex == 1) {
            if (GCase3().lcjcSelectedArrayStringR1.length == 0) {
                [GInstance() showInfoMessage:@"请完成检查步骤！"];
                return;
            }
        } else if(GCase3().currentIndex == 6) {
            if (GCase3().lcjcSelectedArrayStringR2.length == 0) {
                [GInstance() showInfoMessage:@"请完成检查步骤！"];
                return;
            }
        } else if(GCase3().currentIndex == 11) {
            if (GCase3().lcjcSelectedArrayStringR3.length == 0) {
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

    NSMutableString *imageNameString = [NSMutableString stringWithString:_lcjcTableToImageNameArray[row]];

    if ([imageNameString hasSuffix:@"*"]) {
        [imageNameString deleteCharactersInRange:NSMakeRange(imageNameString.length - 1, 1)];
        hideFullImage = NO;
    }

    if (GCase3().currentIndex == 6) {
        NSArray *mappingArray = _imageMappingArray[row];
        
        NSString *mString = [NSString stringWithFormat:@"%@r2", mappingArray[GCase3().step1MNumber]];
        
        [imageNameString insertString:mString atIndex:0];
    }
    if (!hideFullImage) {
        _lcjcResultImageViewFull.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_full", imageNameString]];
    }
    _lcjcResultImageView.image = [UIImage imageNamed:imageNameString];
    return hideFullImage;
}

- (void)tableView:(UITableView *)tableView didSelectRowForR1AtIndexPath:(NSIndexPath *)indexPath
{
    Case3Data *globalData = GCase3();
    if (globalData.lcjcSelectedArrayStringR1.length == 0) {
        globalData.lcjcSelectedArrayStringR1 = [NSString string];
    }

    if (!_isLocked) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:247.0f/255 green:176.0f/255 blue:92.0f/255 alpha:1];
    }

    NSArray *selectedArray = [GCase3().lcjcSelectedArrayStringR1 componentsSeparatedByString:@","];
    NSMutableDictionary *parametersDictionary = [@{@"step": @"2",
                                                   @"action": @"check",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber,
                                                   @"item": _checkingStringArray[indexPath.row],
                                                   @"seq": [NSString stringWithFormat:@"%ld", (long)selectedArray.count]} mutableCopy];

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
}

- (void)tableView:(UITableView *)tableView didSelectRowForR2AtIndexPath:(NSIndexPath *)indexPath
{
    Case3Data *globalData = GCase3();
    if (globalData.lcjcSelectedArrayStringR2.length == 0) {
        globalData.lcjcSelectedArrayStringR2 = [NSString string];
    }

    if (!_isLocked) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:247.0f/255 green:176.0f/255 blue:92.0f/255 alpha:1];
    }

    NSArray *selectedArray = [GCase3().lcjcSelectedArrayStringR2 componentsSeparatedByString:@","];
    NSMutableDictionary *parametersDictionary = [@{@"step": @"7",
                                                   @"action": @"check",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber,
                                                   @"item": _checkingStringArray[indexPath.row],
                                                   @"seq": [NSString stringWithFormat:@"%ld", (long)selectedArray.count]} mutableCopy];

    NSLog(@"%@", parametersDictionary);
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
    Case3Data *globalData = GCase3();
    if (globalData.lcjcSelectedArrayStringR3.length == 0) {
        globalData.lcjcSelectedArrayStringR3 = [NSString string];
    }

    if (!_isLocked) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:247.0f/255 green:176.0f/255 blue:92.0f/255 alpha:1];
    }

    NSArray *selectedArray = [GCase3().lcjcSelectedArrayStringR3 componentsSeparatedByString:@","];
    NSMutableDictionary *parametersDictionary = [@{@"step": @"12",
                                                   @"action": @"check",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber,
                                                   @"item": _checkingStringArray[indexPath.row],
                                                   @"seq": [NSString stringWithFormat:@"%ld", (long)selectedArray.count]} mutableCopy];

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
                                         globalData.lcjcSelectedArrayStringR3 = [globalData.lcjcSelectedArrayStringR3 stringByAppendingFormat:@"%ld,", (long)indexPath.row];
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