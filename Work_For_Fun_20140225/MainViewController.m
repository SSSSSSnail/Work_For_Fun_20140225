//
//  MainViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 27/2/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "MainViewController.h"
#import "HZQKViewController.h"
#import "LCJCViewController.h"
#import "ZDJGViewController.h"
#import "ZLFAViewController.h"
#import "BCJZViewController.h"

#import "LLUIButton.h"
#import "LLUIPickView.h"
#import "LLCheckButton.h"
#import "LLCheckButtonGroup.h"

typedef NS_ENUM(NSUInteger, ScrollSubButtonTag)
{
    HZQKButton1 = 10, //患者情况
    LCJCButton1 = 11, //临床检查
    ZDJGButton1 = 12, //诊断结果
    ZLFAButton1 = 13, //治疗方案
    LCJJButton1 = 14, //临床结局

    BSHGButton2 = 15, //病史回顾
    LCJCButton2 = 16, //临床检查
    ZDJGButton2 = 17, //诊断结果
    ZLFAButton2 = 18, //治疗方案
    LCJJButton2 = 19  //临床结局
};



static float const DETAILVIEWHEIGHT = 768.0f;
static float const DETAILVIEWIDTH = 872.0f;

@interface MainViewController ()<ScrollViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *masterScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *detailScrollView;
@property (weak, nonatomic) IBOutlet UIView *step1MasterView;
@property (weak, nonatomic) IBOutlet UIView *step2MasterView;

@property (strong, nonatomic) HZQKViewController *hzqkViewController;
@property (strong, nonatomic) LCJCViewController *lcjcViewController;
@property (strong, nonatomic) ZDJGViewController *zdjgViewController;
@property (strong, nonatomic) ZLFAViewController *zlfaViewController;
@property (strong, nonatomic) BCJZViewController *bcjzViewController;

@property (strong, nonatomic) HZQKViewController *hzqkM2ViewController;
@property (strong, nonatomic) LCJCViewController *lcjcM2ViewController;
@property (strong, nonatomic) ZDJGViewController *zdjgM2ViewController;
@property (strong, nonatomic) ZLFAViewController *zlfaM2ViewController;
@property (strong, nonatomic) BCJZViewController *bcjzM2ViewController;

@property (strong, nonatomic) NSMutableArray *masterButtonArray;
@property (strong, nonatomic) NSArray *detailViewArray;

@property (strong, nonatomic) NSArray *masterTagArray;



- (IBAction)clickNext:(LLUIButton *)sender;


@end

@implementation MainViewController

#pragma mark -
#pragma mark Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.masterTagArray = @[
                            [NSNumber numberWithInt:HZQKButton1],
                            [NSNumber numberWithInt:LCJCButton1],
                            [NSNumber numberWithInt:ZDJGButton1],
                            [NSNumber numberWithInt:ZLFAButton1],
                            [NSNumber numberWithInt:LCJJButton1],
                            
                            [NSNumber numberWithInt:BSHGButton2],
                            [NSNumber numberWithInt:LCJCButton2],
                            [NSNumber numberWithInt:ZDJGButton2],
                            [NSNumber numberWithInt:ZLFAButton2],
                            [NSNumber numberWithInt:LCJJButton2]
                            ];

    self.masterButtonArray = [NSMutableArray array];

    self.hzqkViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"hzqkVC"];
    self.lcjcViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"lcjcVC"];
    self.zdjgViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zdjgVC"];
    self.zlfaViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zlfaVC"];
    self.bcjzViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bcjzVC"];
    
    self.hzqkM2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"hzqkVC"];
    self.lcjcM2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"lcjcVC"];
    self.zdjgM2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zdjgVC"];
    self.zlfaM2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zlfaVC"];
    self.bcjzM2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bcjzVC"];
    
    [self addChildViewController:_hzqkViewController];
    _hzqkViewController.scrollViewDelegate = self;
    [self addChildViewController:_lcjcViewController];
    _lcjcViewController.scrollViewDelegate = self;
    [self addChildViewController:_zdjgViewController];
    _zdjgViewController.scrollViewDelegate = self;
    [self addChildViewController:_zlfaViewController];
    _zlfaViewController.scrollViewDelegate = self;
    [self addChildViewController:_bcjzViewController];
    _bcjzViewController.scrollViewDelegate = self;
    
    [self addChildViewController:_hzqkM2ViewController];
    _hzqkM2ViewController.scrollViewDelegate = self;
    [self addChildViewController:_lcjcM2ViewController];
    _lcjcM2ViewController.scrollViewDelegate = self;
    [self addChildViewController:_zdjgM2ViewController];
    _zdjgM2ViewController.scrollViewDelegate = self;
    [self addChildViewController:_zlfaM2ViewController];
    _zlfaM2ViewController.scrollViewDelegate = self;
    [self addChildViewController:_bcjzM2ViewController];
    _bcjzM2ViewController.scrollViewDelegate = self;

    for (NSNumber *buttonTag in _masterTagArray) {
        UIButton *button = (UIButton *)[_step1MasterView viewWithTag:buttonTag.integerValue];
        if (button) {
            [_masterButtonArray addObject:button];
        } else {
//            NSLog(@"ButtonTag: %d", buttonTag.integerValue);
//            NSAssert(NO, @"Button not found!");
        }
    }

    for (NSNumber *buttonTag in _masterTagArray) {
        UIButton *button = (UIButton *)[_step2MasterView viewWithTag:buttonTag.integerValue];
        if (button) {
            [_masterButtonArray addObject:button];
        } else {
            //            NSLog(@"ButtonTag: %d", buttonTag.integerValue);
            //            NSAssert(NO, @"Button not found!");
        }
    }

    _masterScrollView.scrollEnabled = NO;
    _masterScrollView.contentSize = CGSizeMake(152, 1390);
    
    
    self.detailViewArray = @[_hzqkViewController.view, _lcjcViewController.view,
                             _zdjgViewController.view, _zlfaViewController.view,
                             _bcjzViewController.view, _hzqkM2ViewController.view,
                             _lcjcM2ViewController.view, _zdjgM2ViewController.view,
                             _zlfaM2ViewController.view, _bcjzM2ViewController.view];

    for (int i = 0; i < _detailViewArray.count; i++) {
        [_detailScrollView addSubview:((UIView *)_detailViewArray[i])];
        ((UIView *)_detailViewArray[i]).frame = CGRectMake(0.0f, DETAILVIEWHEIGHT * i, DETAILVIEWIDTH, DETAILVIEWHEIGHT);
    }
    
    _detailScrollView.scrollEnabled = NO;
    _detailScrollView.contentSize = CGSizeMake(DETAILVIEWIDTH, DETAILVIEWHEIGHT*_detailViewArray.count);
    /* xxxxxx */
//    [GInstance() loadData];

    UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    swipeGes.direction = UISwipeGestureRecognizerDirectionDown;
    [_step2MasterView addGestureRecognizer:swipeGes];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    GInstance().globalData.currentIndex = 5;
//    GInstance().globalData.r2Type = M1;
//    GInstance().globalData.fsStep2 = YES;
//    [_hzqkM2ViewController reloadViewDataForR2];
    if (GInstance().globalData.fsStep2) {
        [_masterScrollView scrollRectToVisible:CGRectMake(0.0f, 695.0f, 152.0f, 695.0f) animated:NO];
        [_hzqkM2ViewController reloadViewDataForR2];
        [_lcjcM2ViewController reloadViewDataForR2];
        [_zdjgM2ViewController reloadViewDataForR2];
        [_zdjgM2ViewController loadDataFromGlobalData];
        [_zlfaM2ViewController reloadViewDataForR2];
        [_bcjzM2ViewController reloadViewDataForR2];
    }
    [self refreshButtonAndView:GInstance().globalData.currentIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickNext:(LLUIButton *)sender
{
    if (sender.tag - 10 > GInstance().globalData.maxIndex) {
        [GInstance() showInfoMessage:@"请完成当前步骤！"];
        return;
    }
    [self refreshButtonAndView:sender.tag - 10];
}

- (void)refreshButtonAndView:(long)toIndex
{
    if (toIndex >= _masterButtonArray.count) {
        return;
    }

    for (NSUInteger i = 0; i < _masterButtonArray.count; i ++) {
        UIButton *toButton = _masterButtonArray[i];
        if (toIndex == i) {
            toButton.selected = YES;
        } else {
            toButton.selected = NO;
        }
    }

    GInstance().globalData.currentIndex = toIndex;
    GInstance().globalData.maxIndex = MAX(toIndex, GInstance().globalData.maxIndex);
    [_detailScrollView scrollRectToVisible:CGRectMake(0.0f, DETAILVIEWHEIGHT*toIndex, DETAILVIEWIDTH, DETAILVIEWHEIGHT) animated:YES];
//    switch (toIndex) {
//        case 5:
//            [_hzqkM2ViewController reloadViewDataForR2];
//            break;
//            case 6:
//            [_lcjcM2ViewController reloadViewDataForR2];
//            break;
//            case 7:
//            break;
//            case 8:
//            [_zlfaM2ViewController reloadViewDataForR2];
//            break;
//            case 9:
//            break;
//            
//        default:
//            break;
//    }
}

#pragma mark - ScrollViewController Delegate
- (void)didClickConfirmButton:(UIButton *)sender
{
    LLGlobalData *globalData = GInstance().globalData;
    if (globalData.currentIndex == 0) {
        //患者情况 确定
        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:1];
        } else {
#ifndef SKIPREQUEST
            NSDictionary *parametersDictionary = @{@"step": @"1",
                                                   @"action": @"info",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber};
            [GInstance() httprequestWithHUD:_hzqkViewController.view
                             withRequestURL:STEPURL
                             withParameters:parametersDictionary
                                 completion:^(NSDictionary *jsonDic) {
                                     NSLog(@"responseJson: %@", jsonDic);
                                     if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                         if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                             [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                         } else {
                                             [self refreshButtonAndView:1];
                                             [GInstance() savaData];
                                         }
                                     } else {
                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
                                         }
                                     }
                                 }];
#endif
#ifdef SKIPREQUEST
            [self refreshButtonAndView:1];
            [GInstance() savaData];
#endif
        }
    } else if (globalData.currentIndex == 1) {
        //临床检查第一轮确定
        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:2];
        } else {
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:@"请确认已经完成全部检查！"
                               cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{

            }]
                               otherButtonItems:[RIButtonItem itemWithLabel:@"确认" action:^{
#ifndef SKIPREQUEST
                NSDictionary *parametersDictionary = @{@"step": @"2",
                                                       @"action": @"checkconfirm",
                                                       @"subject_id": globalData.subjectId,
                                                       @"group_id": globalData.groupNumber};
                [GInstance() httprequestWithHUD:_lcjcViewController.view
                                 withRequestURL:STEPURL
                                 withParameters:parametersDictionary
                                     completion:^(NSDictionary *jsonDic) {
                                         NSLog(@"responseJson: %@", jsonDic);
                                         if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                             _lcjcViewController.isLocked = YES;
                                             if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                                 [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                             } else {
                                                 [self refreshButtonAndView:2];
                                                 [GInstance() savaData];
                                             }
                                         } else {
                                             if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                                 [GInstance() showErrorMessage:@"服务器结果异常!"];
                                             }
                                         }
                                     }];
#endif
#ifdef SKIPREQUEST
                _lcjcViewController.isLocked = YES;
                [self refreshButtonAndView:2];
                [GInstance() savaData];
#endif
            }], nil] show];
        }
    } else if (globalData.currentIndex == 2) {
        // 诊断结果 确定
        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:3];
        } else {
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:@"请确认已经完成诊断！"
                               cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{

            }]
                               otherButtonItems:[RIButtonItem itemWithLabel:@"确认" action:^{
#ifndef SKIPREQUEST
                NSDictionary *parametersDictionary = @{@"step": @"3",
                                                       @"action": @"diagnose",
                                                       @"subject_id": globalData.subjectId,
                                                       @"group_id": globalData.groupNumber,
                                                       @"zd": globalData.zdjgZDSelectItem,
                                                       @"wxpg": globalData.zdjgPGSelectItem,
                                                       @"t" : globalData.zdjgTSelectItem,
                                                       @"n" : globalData.zdjgNSelectItem,
                                                       @"m" : globalData.zdjgMSelectItem };

                [GInstance() httprequestWithHUD:_zdjgViewController.view
                                 withRequestURL:STEPURL
                                 withParameters:parametersDictionary
                                     completion:^(NSDictionary *jsonDic) {
                                         NSLog(@"responseJson: %@", jsonDic);
                                         if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]) {
                                             for (UIView *subView in [_zdjgViewController.view subviews]) {
                                                 if (subView.tag != 999) {
                                                     subView.userInteractionEnabled = NO;
                                                 }
                                             }
                                             if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                                 [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                             } else {
                                                 [self refreshButtonAndView:3];
                                                 [GInstance() savaData];
                                             }
                                         } else {
                                             if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                                 [GInstance() showErrorMessage:@"服务器结果异常!"];
                                             }
                                         }
                                     }];
#endif
#ifdef SKIPREQUEST
                for (UIView *subView in [_zdjgViewController.view subviews]) {
                    if (subView.tag != 999) {
                        subView.userInteractionEnabled = NO;
                    }
                }
                [self refreshButtonAndView:3];
                [GInstance() savaData];
#endif
            }], nil] show];
        }
    } else if (globalData.currentIndex == 3) {
        //治疗方案确定
        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:4];
        } else {
#ifndef SKIPREQUEST
            NSDictionary *parametersDictionary = @{@"step": @"4",
                                                   @"action": @"solution",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber,

                                                   @"zdjc": globalData.zlfaLeftSelectedIndex == 5 ? @"Y" : @"N",
                                                   @"cggz": globalData.zlfaLeftSelectedIndex == 1 ? @"Y" : @"N",
                                                   @"fqgz": globalData.zlfaLeftSelectedIndex == 2 ? @"Y" : @"N",
                                                   @"wfl": (globalData.zlfaLeftSelectedIndex == 3 || [globalData.zlfaFuzhuOrZhaoShe isEqualToString:@"W"]) ? @"Y" : @"N",
                                                   @"nfl": globalData.zlfaLeftSelectedIndex == 4 ? @"Y" : @"N",

                                                   @"xfz": globalData.zlfaRightSelectedIndex > 0 ? @"Y" : @"N",
                                                   @"xfqs": globalData.zlfaRightSelectedIndex == 1 ? @"Y" : @"N",
                                                   @"xfkx": globalData.zlfaRightSelectedIndex == 2 ? @"Y" : @"N",
                                                   @"xfzd": globalData.zlfaRightSelectedIndex == 3 ? @"Y" : @"N",
                                                   @"xfzgsrl": [self ifSelectedYaowu:@"xfzgsrl" isXinFuZhu:YES],
                                                   @"xfzlbrl": [self ifSelectedYaowu:@"xfzlbrl" isXinFuZhu:YES],
                                                   @"xfzdpl1": [self ifSelectedYaowu:@"xfzdpl1" isXinFuZhu:YES],
                                                   @"xfzdpl3": [self ifSelectedYaowu:@"xfzdpl3" isXinFuZhu:YES],
                                                   @"xfzbkla": [self ifSelectedYaowu:@"xfzbkla" isXinFuZhu:YES],
                                                   @"xfzfta": [self ifSelectedYaowu:@"xfzfta" isXinFuZhu:YES],

                                                   @"fz": [globalData.zlfaFuzhuOrZhaoShe isEqualToString:@"F"] ? @"Y" : @"N",
                                                   @"cx": [globalData.zlfaFuzhuType isEqualToString:@"C"] ? @"Y" : @"N",
                                                   @"jx": [globalData.zlfaFuzhuType isEqualToString:@"J"] ? @"Y" : @"N",
                                                   @"ssqs": [self ifSelectedFuzhu:@"ssqs"],
                                                   @"fzqs": [self ifSelectedFuzhu:@"fzqs"],
                                                   @"fzkx": [self ifSelectedFuzhu:@"fzkx"],
                                                   @"fzzd": [self ifSelectedFuzhu:@"fzzd"],

                                                   @"gsrl": [self ifSelectedYaowu:@"gsrl" isXinFuZhu:NO],
                                                   @"lbrl": [self ifSelectedYaowu:@"lbrl" isXinFuZhu:NO],
                                                   @"dpl1": [self ifSelectedYaowu:@"dpl1" isXinFuZhu:NO],
                                                   @"dpl3": [self ifSelectedYaowu:@"dpl3" isXinFuZhu:NO],
                                                   @"bkla": [self ifSelectedYaowu:@"bkla" isXinFuZhu:NO],
                                                   @"fta": [self ifSelectedYaowu:@"fta" isXinFuZhu:NO],
                                                   @"jk": [globalData.zlfaFuzhuYaoWuSeg1 isEqualToString:@"即刻"] ? @"Y" : @"N",
                                                   @"shff": [globalData.zlfaFuzhuYaoWuSeg1 isEqualToString:@"生化复发"] ? @"Y" : @"N"

                                                   };
            for (NSString *keyString in parametersDictionary.allKeys) {
                NSLog(@"%@ : %@", keyString, parametersDictionary[keyString]);
            }

            [GInstance() httprequestWithHUD:_zlfaViewController.view
                             withRequestURL:STEPURL
                             withParameters:parametersDictionary
                                 completion:^(NSDictionary *jsonDic) {
                                     NSLog(@"responseJson: %@", jsonDic);
                                     if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                         for (UIView *subView in [_zlfaViewController.view subviews]) {
                                             if (subView.tag != 999) {
                                                 subView.userInteractionEnabled = NO;
                                             }
                                         }
                                         if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                             [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                         } else {
                                             [self refreshButtonAndView:4];
                                             [_zlfaViewController rollToTopView];
                                             [_bcjzViewController changeLabelText:[self refreshResult]];
                                             [GInstance() savaData];
                                         }
                                     } else {
                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
                                         }
                                     }
                                 }];
#endif
#ifdef SKIPREQUEST
            for (UIView *subView in [_zlfaViewController.view subviews]) {
                if (subView.tag != 999) {
                    subView.userInteractionEnabled = NO;
                }
            }
            [self refreshButtonAndView:4];
            [_zlfaViewController rollToTopView];
            [_bcjzViewController changeLabelText:[self refreshResult]];
            [GInstance() savaData];
#endif
        }
    } else if (globalData.currentIndex == 4) {
        //病程进展 确定
        if (globalData.maxIndex > globalData.currentIndex) {
            [_masterScrollView scrollRectToVisible:CGRectMake(0.0f, 695.0f, 152.0f, 695.0f) animated:YES];
            [self refreshButtonAndView:5];
            globalData.fsStep2 = YES;
        } else {
            NSMutableString *indexString = [NSMutableString string];
            if (globalData.zlfaLeftSelectedIndex == 1 || globalData.zlfaLeftSelectedIndex == 2) {
                [indexString appendFormat:@"%d,", 0];
            }
            if (globalData.zlfaLeftSelectedIndex == 3 || globalData.zlfaLeftSelectedIndex == 4 || [globalData.zlfaFuzhuOrZhaoShe isEqualToString:@"W"]) {
                [indexString appendFormat:@"%d,", 1];
            }
            if (globalData.zlfaRightSelectedIndex > 0) {
                [indexString appendFormat:@"%d,", 2];
            }
            if ([globalData.zlfaFuzhuOrZhaoShe isEqualToString:@"F"]) {
                [indexString appendFormat:@"%d,", 3];
            }
#ifndef SKIPREQUEST
            NSDictionary *parametersDictionary = @{@"step": @"5",
                                                   @"action": @"result",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber,
                                                   @"solution": [NSString stringWithFormat:@"m%d",[_bcjzViewController mResultFromResult:[self refreshResult]] - 20],
                                                   @"col1": [NSString stringWithFormat:@"%d", [self refreshResult]],
                                                   @"col2": [_hzqkM2ViewController linchuangjiancheString],
                                                   @"col3": [_hzqkM2ViewController zhenduanString],
                                                   @"col4": [_hzqkM2ViewController weixianxingpingguString],
                                                   @"col5": [NSString stringWithFormat:@"T%@N%@M%@", GInstance().globalData.zdjgTSelectItem, GInstance().globalData.zdjgNSelectItem, GInstance().globalData.zdjgMSelectItem],
                                                   @"col6": [_hzqkM2ViewController loadZhiLiaoFangAn],
                                                   @"col7": indexString,
                                                   @"col8": [_hzqkM2ViewController isTypeBetween2to6] ? @"Y" : @"N",
                                                   @"col9": [_hzqkM2ViewController loadYaoWuFangAn],
                                                   @"col10": [_hzqkM2ViewController loadYaoWu]
                                                   };

            for (NSString *keyString in parametersDictionary.allKeys) {
                NSLog(@"%@ : %@", keyString, parametersDictionary[keyString]);
            }

            [GInstance() httprequestWithHUD:_bcjzViewController.view
                             withRequestURL:STEPURL
                             withParameters:parametersDictionary
                                 completion:^(NSDictionary *jsonDic) {
                                     NSLog(@"responseJson: %@", jsonDic);
                                     if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                         if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                             [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                         } else {
                                             [_masterScrollView scrollRectToVisible:CGRectMake(0.0f, 695.0f, 152.0f, 695.0f) animated:YES];
                                             globalData.fsStep2 = YES;
                                             [self refreshButtonAndView:5];
                                             [_hzqkM2ViewController reloadViewDataForR2];
                                             [GInstance() savaData];
                                         }
                                     } else {
                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
                                         }
                                     }
                                 }];
#endif
#ifdef SKIPREQUEST
            [_masterScrollView scrollRectToVisible:CGRectMake(0.0f, 695.0f, 152.0f, 695.0f) animated:YES];
            globalData.fsStep2 = YES;
            [self refreshButtonAndView:5];
            [_hzqkM2ViewController reloadViewDataForR2];
            [GInstance() savaData];
#endif
        }
    //R2
    } else if (globalData.currentIndex == 5) {
        ///病史回顾确定
        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:6];
        } else {
#ifndef SKIPREQUEST
            NSDictionary *parametersDictionary = @{@"step": @"6",
                                                   @"action": @"info",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber};
            [GInstance() httprequestWithHUD:_hzqkM2ViewController.view
                             withRequestURL:STEPURL
                             withParameters:parametersDictionary
                                 completion:^(NSDictionary *jsonDic) {
                                     NSLog(@"responseJson: %@", jsonDic);
                                     if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                         if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                             [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                         } else {
                                             [_lcjcM2ViewController reloadViewDataForR2];
                                             [self refreshButtonAndView:6];
                                             [GInstance() savaData];
                                         }
                                     } else {
                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
                                         }
                                     }
                                 }];
#endif
#ifdef SKIPREQUEST
            [_lcjcM2ViewController reloadViewDataForR2];
            [self refreshButtonAndView:6];
            [GInstance() savaData];
#endif
        }

    } else if (globalData.currentIndex == 6) {
        //临床检查第二轮确定
        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:7];
        } else {
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:@"请确认已经完成诊断！"
                               cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{

            }]
                               otherButtonItems:[RIButtonItem itemWithLabel:@"确认" action:^{
#ifndef SKIPREQUEST
                NSDictionary *parametersDictionary = @{@"step": @"7",
                                                       @"action": @"checkconfirm",
                                                       @"subject_id": globalData.subjectId,
                                                       @"group_id": globalData.groupNumber};
                [GInstance() httprequestWithHUD:_lcjcM2ViewController.view
                                 withRequestURL:STEPURL
                                 withParameters:parametersDictionary
                                     completion:^(NSDictionary *jsonDic) {
                                         NSLog(@"responseJson: %@", jsonDic);
                                         if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                             if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                                 [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                             } else {
                                                  _lcjcM2ViewController.isLocked = YES;
                                                 [_zdjgM2ViewController loadDataFromGlobalData];
                                                 [self refreshButtonAndView:7];
                                                 [_zdjgM2ViewController reloadViewDataForR2];
                                                 [GInstance() savaData];
                                             }
                                         } else {
                                             if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                                 [GInstance() showErrorMessage:@"服务器结果异常!"];
                                             }
                                         }
                                     }];
#endif
#ifdef SKIPREQUEST
                _lcjcM2ViewController.isLocked = YES;
                [_zdjgM2ViewController loadDataFromGlobalData];
                [self refreshButtonAndView:7];
                [_zdjgM2ViewController reloadViewDataForR2];
                [GInstance() savaData];
#endif
            }], nil] show];
        }
    } else if (globalData.currentIndex == 7) {
        //诊断结果 第二轮确定
        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:8];
        } else {
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:@"请确认已经完成诊断！"
                               cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{

            }]
                               otherButtonItems:[RIButtonItem itemWithLabel:@"确认" action:^{
                NSMutableDictionary *parametersDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"step": @"8",
                                                                                                            @"action": @"diagnose",
                                                                                                            @"subject_id": globalData.subjectId,
                                                                                                            @"group_id": globalData.groupNumber,
                                                                                                            @"zd": globalData.zdjgZDSelectItemR2,
                                                                                                            @"wxpg": globalData.zdjgPGSelectItemR2,
                                                                                                            }];
                if (globalData.zdjgTSelectItemR2) {
                    [parametersDictionary setObject:globalData.zdjgTSelectItemR2 forKey:@"t"];
                }
                if (globalData.zdjgNSelectItemR2) {
                    [parametersDictionary setObject:globalData.zdjgNSelectItemR2 forKey:@"n"];
                }
                if (globalData.zdjgMSelectItemR2) {
                    [parametersDictionary setObject:globalData.zdjgMSelectItemR2 forKey:@"m"];
                }
#ifndef SKIPREQUEST
                [GInstance() httprequestWithHUD:_zdjgM2ViewController.view
                                 withRequestURL:STEPURL
                                 withParameters:parametersDictionary
                                     completion:^(NSDictionary *jsonDic) {
                                         NSLog(@"responseJson: %@", jsonDic);
                                         if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                             for (UIView *subView in [_zdjgM2ViewController.view subviews]) {
                                                 if (subView.tag != 999) {
                                                     subView.userInteractionEnabled = NO;
                                                 }
                                             }
                                             if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                                 [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                             } else {
                                                 [self refreshButtonAndView:8];
                                                 [GInstance() savaData];
                                                 [_zlfaM2ViewController reloadViewDataForR2];
                                             }
                                         } else {
                                             if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                                 [GInstance() showErrorMessage:@"服务器结果异常!"];
                                             }
                                         }
                                     }];
#endif
#ifdef SKIPREQUEST
                for (UIView *subView in [_zdjgM2ViewController.view subviews]) {
                    if (subView.tag != 999) {
                        subView.userInteractionEnabled = NO;
                    }
                }
                [self refreshButtonAndView:8];
                [GInstance() savaData];
                [_zlfaM2ViewController reloadViewDataForR2];
#endif
            }], nil] show];
        }
    } else if (globalData.currentIndex == 8) {
        //治疗方案 第二轮确定
        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:9];
        } else {
#ifndef SKIPREQUEST
            NSDictionary *parametersDictionary = @{@"step": @"9",
                                                   @"action": @"solution",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber,
                                                   @"solution": [NSString stringWithFormat:@"m%d",[_bcjzViewController mResultFromResult:globalData.r1Result] - 20],

                                                   @"zdjc": globalData.zlfaLeftSelectedIndex == 5 ? @"Y" : @"N",
                                                   @"cggz": globalData.zlfaLeftSelectedIndex == 1 ? @"Y" : @"N",
                                                   @"fqgz": globalData.zlfaLeftSelectedIndex == 2 ? @"Y" : @"N",
                                                   @"wfl": globalData.zlfaLeftSelectedIndex == 3 ? @"Y" : @"N",
                                                   @"nfl": globalData.zlfaLeftSelectedIndex == 4 ? @"Y" : @"N",

                                                   @"fz": globalData.zlfaR2RightSelectedIndex == 1 ? @"Y" : @"N",
                                                   @"cx": [globalData.zlfaFuzhuType isEqualToString:@"C"] ? @"Y" : @"N",
                                                   @"jx": [globalData.zlfaFuzhuType isEqualToString:@"J"] ? @"Y" : @"N",
                                                   @"ssqs": [self ifSelectedFuzhu:@"ssqs"],
                                                   @"fzqs": [self ifSelectedFuzhu:@"fzqs"],
                                                   @"fzkx": [self ifSelectedFuzhu:@"fzkx"],
                                                   @"fzzd": [self ifSelectedFuzhu:@"fzzd"],

                                                   @"gsrl": [self ifSelectedYaowu:@"gsrl" isXinFuZhu:NO],
                                                   @"lbrl": [self ifSelectedYaowu:@"lbrl" isXinFuZhu:NO],
                                                   @"dpl1": [self ifSelectedYaowu:@"dpl1" isXinFuZhu:NO],
                                                   @"dpl3": [self ifSelectedYaowu:@"dpl3" isXinFuZhu:NO],
                                                   @"bkla": [self ifSelectedYaowu:@"bkla" isXinFuZhu:NO],
                                                   @"fta": [self ifSelectedYaowu:@"fta" isXinFuZhu:NO],

                                                   @"zdkx": globalData.zlfaR2RightSelectedIndex == 3 ? @"Y" : @"N",
                                                   @"hl": globalData.zlfaR2RightSelectedIndex == 2 ? @"Y" : @"N",
                                                   @"nfm2": globalData.zlfaR2RightSelectedIndex == 4 ? @"Y" : @"N",
                                                   @"cjs": [globalData.zlfaR2RightYaowuSelected isEqualToString:@"C"] ? @"Y" : @"N",
                                                   @"fta2": [globalData.zlfaR2RightYaowuSelected isEqualToString:@"F"] ? @"Y" : @"N"
                                                   };

            for (NSString *keyString in parametersDictionary.allKeys) {
                NSLog(@"%@ : %@", keyString, parametersDictionary[keyString]);
            }

            [GInstance() httprequestWithHUD:_zlfaM2ViewController.view
                             withRequestURL:STEPURL
                             withParameters:parametersDictionary
                                 completion:^(NSDictionary *jsonDic) {
                                     NSLog(@"responseJson: %@", jsonDic);
                                     if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                         for (UIView *subView in [_zlfaM2ViewController.view subviews]) {
                                             if (subView.tag != 999) {
                                                 subView.userInteractionEnabled = NO;
                                             }
                                         }
                                         if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                             [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                         } else {
                                             [self refreshButtonAndView:9];
                                             [_zlfaM2ViewController rollToTopView];
                                             [_bcjzM2ViewController reloadViewDataForR2];
                                             [GInstance() savaData];
                                         }
                                     } else {
                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
                                         }
                                     }
                                 }];
#endif
#ifdef SKIPREQUEST
            for (UIView *subView in [_zlfaM2ViewController.view subviews]) {
                if (subView.tag != 999) {
                    subView.userInteractionEnabled = NO;
                }
            }
            [self refreshButtonAndView:9];
            [_zlfaM2ViewController rollToTopView];
            [_bcjzM2ViewController reloadViewDataForR2];
            [GInstance() savaData];
#endif
        }
    } else if (globalData.currentIndex == 9) {
        // 病程进展 第二轮确定
#ifndef SKIPREQUEST
        NSDictionary *parametersDictionary = @{@"step": @"10",
                                               @"action": @"result",
                                               @"subject_id": globalData.subjectId,
                                               @"group_id": globalData.groupNumber};
        [GInstance() httprequestWithHUD:_bcjzM2ViewController.view
                         withRequestURL:STEPURL
                         withParameters:parametersDictionary
                             completion:^(NSDictionary *jsonDic) {
                                 NSLog(@"responseJson: %@", jsonDic);
                                 if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                     [GInstance() showInfoMessage:@"治疗结束！"];
                                     [GInstance() savaData];
                                 } else {
                                     if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                         [GInstance() showErrorMessage:@"服务器结果异常!"];
                                     }
                                 }
                             }];
#endif
#ifdef SKIPREQUEST
        [GInstance() showInfoMessage:@"治疗结束！"];
        [GInstance() savaData];
#endif
    }
}

- (BCJZResult)refreshResult
{
    BCJZResult result;
    LLGlobalData *gData = GInstance().globalData;

    if (gData.zlfaLeftSelectedIndex == 1 || gData.zlfaLeftSelectedIndex == 2) { //选择手术
        if (gData.zlfaRightSelectedIndex > 0) { //选择新辅助
            if ([gData.zlfaFuzhuType isEqualToString:@"C"]) { //做补充 持续
                result = XFZNFMGZSFZNFMCX;
            } else if ([gData.zlfaFuzhuType isEqualToString:@"J"]) { //做补充 间歇
                result = XFZNFMGZSFZNFMJX;
            } else { //未做补充
                result = XFZNFMGZS;
            }
        } else { //未选择新辅助
            if ([gData.zlfaFuzhuOrZhaoShe isEqualToString:@"W"]) { //选择外照射
                result = GZSFL;
            } else if ([gData.zlfaFuzhuOrZhaoShe isEqualToString:@"F"]) { //选择补充
                if ([gData.zlfaFuzhuType isEqualToString:@"C"]) { //做补充 持续
                    result = GZSFZNFMCX;
                } else { //做补充 间歇
                    result = GZSFZNFMJX;
                }
            } else {
                result = GZS;
            }
        }
    } else if (gData.zlfaLeftSelectedIndex == 3 || gData.zlfaLeftSelectedIndex == 4){ //放疗
        if ([gData.zlfaFuzhuType isEqualToString:@"C"]) { //做补充 持续
            result = FLFZNFMCX;
        } else if ([gData.zlfaFuzhuType isEqualToString:@"J"]) { //做补充 间歇
            result = FLFZNFMJX;
        } else { //未做补充
            result = FL;
        }
    } else { //主动监测
        result = ZDJC;
    }

    return result;
}

- (NSString *)ifSelectedYaowu:(NSString *)yaowuName isXinFuZhu:(BOOL)isXinFuZhu
{
    NSDictionary *yaowuDic = @{@"达菲林 3月剂型":@[@"xfzdpl3", @"dpl3"],
                               @"达菲林 1月剂型":@[@"xfzdpl1", @"dpl1"],
                               @"戈舍瑞林":@[@"xfzgsrl", @"gsrl"],
                               @"亮丙瑞林":@[@"xfzlbrl", @"lbrl"],
                               @"比卡鲁胺":@[@"xfzbkla", @"bkla"],
                               @"氟他胺":@[@"xfzfta", @"fta"]
                               };
    if (isXinFuZhu) {
        NSString *yaowu1 = GInstance().globalData.zlfaXinFuZhuYaoWuSeg1;
        NSString *yaowu2 = GInstance().globalData.zlfaXinFuZhuYaoWuSeg2;
        NSString *mergeName = [NSString stringWithFormat:@"%@%@", yaowuDic[yaowu1][0], yaowuDic[yaowu2][0]];
        if ([mergeName hasPrefix:yaowuName] || [mergeName hasSuffix:yaowuName]) {
            return @"Y";
        }else {
            return @"N";
        }
    } else {
        NSString *yaowu1;
        NSString *yaowu2;
        if (GInstance().globalData.isFSSetp2) {
            yaowu1 = GInstance().globalData.zlfaR2FuzhuYaoWuSeg1;
            yaowu2 = GInstance().globalData.zlfaR2FuzhuYaoWuSeg2;
        } else {
            yaowu1 = GInstance().globalData.zlfaFuzhuYaoWuSeg2;
            yaowu2 = GInstance().globalData.zlfaFuzhuYaoWuSeg3;
        }
        NSString *mergeName = [NSString stringWithFormat:@"%@%@", yaowuDic[yaowu1][1], yaowuDic[yaowu2][1]];
        if ([mergeName hasPrefix:yaowuName] || [mergeName hasSuffix:yaowuName]) {
            return @"Y";
        }else {
            return @"N";
        }
    }
}

- (NSString *)ifSelectedFuzhu:(NSString *)fuzhuName
{
    NSArray *fuzhuArray = @[@"ssqs", @"fzqs", @"fzkx", @"fzzd"];
    NSUInteger keyInt;
    if ([GInstance().globalData.zlfaFuzhuType isEqualToString:@"C"]) {
        keyInt = GInstance().globalData.zlfaFuzhuSelectedIndex - 1;
    } else if ([GInstance().globalData.zlfaFuzhuType isEqualToString:@"J"]){
        keyInt = GInstance().globalData.zlfaFuzhuSelectedIndex;
    } else {
        return @"N";
    }
    if ([fuzhuArray[keyInt] isEqualToString:fuzhuName]) {
        return @"Y";
    } else {
        return @"N";
    }
}

- (void)swipeDown:(id)sender
{
    [_masterScrollView scrollRectToVisible:CGRectMake(0.0f, 0.0f, 152.0f, 695.0f) animated:YES];
    GInstance().globalData.currentIndex = 0;
    GInstance().globalData.fsStep2 = NO;
    [self refreshButtonAndView:0];
}

@end
