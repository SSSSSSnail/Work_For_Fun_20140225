//
//  Case2MainViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 25/7/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "Case2MainViewController.h"
#import "HZQKC2ViewController.h"
#import "LCJCC2ViewController.h"
#import "ZDJGC2ViewController.h"
#import "ZLFAC2ViewController.h"
#import "BCJZC2ViewController.h"

#import "Case2Data.h"

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

    HZQKButton2 = 15, //病史回顾
    LCJCButton2 = 16, //临床检查
    ZDJGButton2 = 17, //诊断结果
    ZLFAButton2 = 18, //治疗方案
    LCJJButton2 = 19,  //临床结局

    HZQKButton3 = 20, //病史回顾
    LCJCButton3 = 21, //临床检查
    ZDJGButton3 = 22, //诊断结果
    ZLFAButton3 = 23, //治疗方案
    LCJJButton3 = 24  //临床结局
};

static float const DETAILVIEWHEIGHT = 768.0f;
static float const DETAILVIEWIDTH = 872.0f;

static float const MASTERVIEWHEIGHT = 695.0f;
static float const MASTERVIEWWIDTH = 152.0f;

@interface Case2MainViewController ()<ScrollViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *masterScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *detailScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *masterBGImageView;

@property (weak, nonatomic) IBOutlet UIView *step1MasterView;
@property (weak, nonatomic) IBOutlet UIView *step2MasterView;
@property (weak, nonatomic) IBOutlet UIView *step3MasterView;

@property (strong, nonatomic) HZQKC2ViewController *hzqk1ViewController;
@property (strong, nonatomic) LCJCC2ViewController *lcjc1ViewController;
@property (strong, nonatomic) ZDJGC2ViewController *zdjg1ViewController;
@property (strong, nonatomic) ZLFAC2ViewController *zlfa1ViewController;
@property (strong, nonatomic) BCJZC2ViewController *bcjz1ViewController;

@property (strong, nonatomic) HZQKC2ViewController *hzqk2ViewController;
@property (strong, nonatomic) LCJCC2ViewController *lcjc2ViewController;
@property (strong, nonatomic) ZDJGC2ViewController *zdjg2ViewController;
@property (strong, nonatomic) ZLFAC2ViewController *zlfa2ViewController;
@property (strong, nonatomic) BCJZC2ViewController *bcjz2ViewController;

@property (strong, nonatomic) HZQKC2ViewController *hzqk3ViewController;
@property (strong, nonatomic) LCJCC2ViewController *lcjc3ViewController;
@property (strong, nonatomic) ZDJGC2ViewController *zdjg3ViewController;
@property (strong, nonatomic) ZLFAC2ViewController *zlfa3ViewController;
@property (strong, nonatomic) BCJZC2ViewController *bcjz3ViewController;

@property (strong, nonatomic) NSMutableArray *masterButtonArray;
@property (strong, nonatomic) NSArray *detailViewArray;

@property (strong, nonatomic) NSArray *masterTagArray;

- (IBAction)clickNext:(LLUIButton *)sender;

@end

@implementation Case2MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.masterTagArray = @[
                            [NSNumber numberWithInt:HZQKButton1],
                            [NSNumber numberWithInt:LCJCButton1],
                            [NSNumber numberWithInt:ZDJGButton1],
                            [NSNumber numberWithInt:ZLFAButton1],
                            [NSNumber numberWithInt:LCJJButton1],

                            [NSNumber numberWithInt:HZQKButton2],
                            [NSNumber numberWithInt:LCJCButton2],
                            [NSNumber numberWithInt:ZDJGButton2],
                            [NSNumber numberWithInt:ZLFAButton2],
                            [NSNumber numberWithInt:LCJJButton2],

                            [NSNumber numberWithInt:HZQKButton3],
                            [NSNumber numberWithInt:LCJCButton3],
                            [NSNumber numberWithInt:ZDJGButton3],
                            [NSNumber numberWithInt:ZLFAButton3],
                            [NSNumber numberWithInt:LCJJButton3]
                            ];

    self.masterButtonArray = [NSMutableArray array];

    self.hzqk1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"hzqkVC"];
    self.lcjc1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"lcjcVC"];
    self.zdjg1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zdjgVC"];
    self.zlfa1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zlfaVC"];
    self.bcjz1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bcjzVC"];

    self.hzqk2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"hzqkVC"];
    self.lcjc2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"lcjcVC"];
    self.zdjg2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zdjgVC"];
    self.zlfa2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zlfaVC"];
    self.bcjz2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bcjzVC"];

    self.hzqk3ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"hzqkVC"];
    self.lcjc3ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"lcjcVC"];
    self.zdjg3ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zdjgVC"];
    self.zlfa3ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zlfaVC"];
    self.bcjz3ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bcjzVC"];

    [self addChildViewController:_hzqk1ViewController];
    _hzqk1ViewController.scrollViewDelegate = self;
    [self addChildViewController:_lcjc1ViewController];
    _lcjc1ViewController.scrollViewDelegate = self;
    [self addChildViewController:_zdjg1ViewController];
    _zdjg1ViewController.scrollViewDelegate = self;
    [self addChildViewController:_zlfa1ViewController];
    _zlfa1ViewController.scrollViewDelegate = self;
    [self addChildViewController:_bcjz1ViewController];
    _bcjz1ViewController.scrollViewDelegate = self;

    [self addChildViewController:_hzqk2ViewController];
    _hzqk2ViewController.scrollViewDelegate = self;
    [self addChildViewController:_lcjc2ViewController];
    _lcjc2ViewController.scrollViewDelegate = self;
    [self addChildViewController:_zdjg2ViewController];
    _zdjg2ViewController.scrollViewDelegate = self;
    [self addChildViewController:_zlfa2ViewController];
    _zlfa2ViewController.scrollViewDelegate = self;
    [self addChildViewController:_bcjz2ViewController];
    _bcjz2ViewController.scrollViewDelegate = self;

    [self addChildViewController:_hzqk3ViewController];
    _hzqk3ViewController.scrollViewDelegate = self;
    [self addChildViewController:_lcjc3ViewController];
    _lcjc3ViewController.scrollViewDelegate = self;
    [self addChildViewController:_zdjg3ViewController];
    _zdjg3ViewController.scrollViewDelegate = self;
    [self addChildViewController:_zlfa3ViewController];
    _zlfa3ViewController.scrollViewDelegate = self;
    [self addChildViewController:_bcjz3ViewController];
    _bcjz3ViewController.scrollViewDelegate = self;

    for (NSNumber *buttonTag in _masterTagArray) {
        UIButton *button = (UIButton *)[_step1MasterView viewWithTag:buttonTag.integerValue];
        if (button) {
            [_masterButtonArray addObject:button];
        }
    }

    for (NSNumber *buttonTag in _masterTagArray) {
        UIButton *button = (UIButton *)[_step2MasterView viewWithTag:buttonTag.integerValue];
        if (button) {
            [_masterButtonArray addObject:button];
        }
    }

    for (NSNumber *buttonTag in _masterTagArray) {
        UIButton *button = (UIButton *)[_step3MasterView viewWithTag:buttonTag.integerValue];
        if (button) {
            [_masterButtonArray addObject:button];
        }
    }

    self.detailViewArray = @[_hzqk1ViewController.view,
                             _lcjc1ViewController.view,
                             _zdjg1ViewController.view,
                             _zlfa1ViewController.view,
                             _bcjz1ViewController.view,

                             _hzqk2ViewController.view,
                             _lcjc2ViewController.view
//                             _zdjg2ViewController.view,
//                             _zlfa2ViewController.view,
//                             _bcjz2ViewController.view,
//                             
//                             _hzqk3ViewController.view,
//                             _lcjc3ViewController.view,
//                             _zdjg3ViewController.view,
//                             _zlfa3ViewController.view,
//                             _bcjz3ViewController.view
                             ];

    for (int i = 0; i < _detailViewArray.count; i++) {
        [_detailScrollView addSubview:((UIView *)_detailViewArray[i])];
        ((UIView *)_detailViewArray[i]).frame = CGRectMake(0.0f, DETAILVIEWHEIGHT * i, DETAILVIEWIDTH, DETAILVIEWHEIGHT);
    }

    _detailScrollView.scrollEnabled = NO;
    _detailScrollView.contentSize = CGSizeMake(DETAILVIEWIDTH, DETAILVIEWHEIGHT*_detailViewArray.count);
    _detailScrollView.clipsToBounds = NO;

    _masterScrollView.scrollEnabled = NO;
    _masterScrollView.contentSize = CGSizeMake(MASTERVIEWWIDTH, MASTERVIEWHEIGHT * 3);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self refreshButtonAndView:GCase2().currentIndex];
//    [self refreshButtonAndView:6];
//    GCase2().currentStep = Case2Step2;
//    GCase2().step1MNumber = 1;
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

    GCase2().currentIndex = toIndex;
    GCase2().maxIndex = MAX(toIndex, GCase2().maxIndex);
    [_detailScrollView scrollRectToVisible:CGRectMake(0.0f, DETAILVIEWHEIGHT*toIndex, DETAILVIEWIDTH, DETAILVIEWHEIGHT) animated:YES];
//    [_masterScrollView scrollRectToVisible:CGRectMake(0, MASTERVIEWHEIGHT*GCase2().currentStep, MASTERVIEWWIDTH, MASTERVIEWHEIGHT) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)clickNext:(LLUIButton *)sender
{
    if (sender.tag - 10 > GCase2().maxIndex) {
        [GInstance() showInfoMessage:@"请完成当前步骤！"];
        return;
    }
    [self refreshButtonAndView:sender.tag - 10];
}

#pragma mark - ScrollViewController Delegate
- (void)didClickConfirmButton:(UIButton *)sender
{
    Case2Data *globalData = GCase2();
    if (globalData.currentIndex == 0) {
        //患者情况 确定
        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:1];
        } else {
            NSDictionary *parametersDictionary = @{@"step": @"1",
                                                   @"action": @"info",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber};
            [GInstance() httprequestWithHUD:_hzqk1ViewController.view
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
                NSDictionary *parametersDictionary = @{@"step": @"2",
                                                       @"action": @"checkconfirm",
                                                       @"subject_id": globalData.subjectId,
                                                       @"group_id": globalData.groupNumber};
                [GInstance() httprequestWithHUD:_lcjc1ViewController.view
                                 withRequestURL:STEPURL
                                 withParameters:parametersDictionary
                                     completion:^(NSDictionary *jsonDic) {
                                         NSLog(@"responseJson: %@", jsonDic);
                                         if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                             _lcjc1ViewController.isLocked = YES;
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
                NSDictionary *parametersDictionary = @{@"step": @"3",
                                                       @"action": @"diagnose",
                                                       @"subject_id": globalData.subjectId,
                                                       @"group_id": globalData.groupNumber,
                                                       @"zd": globalData.zdjgZDSelectItem,
                                                       @"wxpg": globalData.zdjgPGSelectItem,
                                                       @"t" : globalData.zdjgTSelectItem,
                                                       @"n" : globalData.zdjgNSelectItem,
                                                       @"m" : globalData.zdjgMSelectItem };

                [GInstance() httprequestWithHUD:_zdjg1ViewController.view
                                 withRequestURL:STEPURL
                                 withParameters:parametersDictionary
                                     completion:^(NSDictionary *jsonDic) {
                                         NSLog(@"responseJson: %@", jsonDic);
                                         if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]) {
                                             for (UIView *subView in [_zdjg1ViewController.view subviews]) {
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
            }], nil] show];
        }
    } else if (globalData.currentIndex == 3) {
        //治疗方案确定

        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:4];
        } else {
            NSDictionary *parametersDictionary = @{@"step": @"4",
                                                   @"action": @"solution",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber,
                                                   };

            [GInstance() httprequestWithHUD:_zlfa1ViewController.view
                             withRequestURL:STEPURL
                             withParameters:parametersDictionary
                                 completion:^(NSDictionary *jsonDic) {
                                     NSLog(@"responseJson: %@", jsonDic);
                                     if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                         for (UIView *subView in [_zlfa1ViewController.view subviews]) {
                                             if (subView.tag != 999) {
                                                 subView.userInteractionEnabled = NO;
                                             }
                                         }
                                         if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                             [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                         } else {
                                             [_bcjz1ViewController refresh:[self countStep1MNumber]];
                                             [self refreshButtonAndView:4];
                                             [_zlfa1ViewController rollToTopView];
                                         }
                                     } else {
                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
                                         }
                                     }
                                 }];
        }
    } else if (globalData.currentIndex == 4) {
        //病程进展 确定
        if (globalData.maxIndex > globalData.currentIndex) {
            [_masterScrollView scrollRectToVisible:CGRectMake(0.0f, MASTERVIEWHEIGHT, MASTERVIEWWIDTH, MASTERVIEWHEIGHT) animated:YES];
            _masterBGImageView.image = [UIImage imageNamed:@"c2leftMenuBG"];
            [self refreshButtonAndView:5];
            globalData.currentStep = Case2Step2;
        } else {
            NSDictionary *parametersDictionary = @{@"step": @"5",
                                                   @"action": @"result",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber,
                                                   };

            [GInstance() httprequestWithHUD:_bcjz1ViewController.view
                             withRequestURL:STEPURL
                             withParameters:parametersDictionary
                                 completion:^(NSDictionary *jsonDic) {
                                     NSLog(@"responseJson: %@", jsonDic);
                                     if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                         if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                             [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                         } else {
                                             [_masterScrollView scrollRectToVisible:CGRectMake(0.0f, MASTERVIEWHEIGHT, MASTERVIEWWIDTH, MASTERVIEWHEIGHT) animated:YES];
                                             _masterBGImageView.image = [UIImage imageNamed:@"c2leftMenuBG"];
                                             globalData.currentStep = Case2Step2;
                                             [self refreshButtonAndView:5];
//                                             [_hzqkM2ViewController reloadViewDataForR2];
                                             [GInstance() savaData];
                                         }
                                     } else {
                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
                                         }
                                     }
                                 }];
        }
    } else if (globalData.currentIndex == 5) {
        ///病史回顾确定
        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:6];
        } else {
            NSDictionary *parametersDictionary = @{@"step": @"6",
                                                   @"action": @"info",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber};
            [GInstance() httprequestWithHUD:_hzqk2ViewController.view
                             withRequestURL:STEPURL
                             withParameters:parametersDictionary
                                 completion:^(NSDictionary *jsonDic) {
                                     NSLog(@"responseJson: %@", jsonDic);
                                     if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                         if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                             [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                         } else {
                                             [self refreshButtonAndView:6];
                                             [GInstance() savaData];
                                         }
                                     } else {
                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
                                         }
                                     }
                                 }];
        }
    }

    
}

- (NSUInteger)countStep1MNumber
{
    NSUInteger mNumber = 0;
    if (GCase2().zlfaLeftSelectedIndex == 4) {
        mNumber = 1;
    } else if (GCase2().zlfaLeftSelectedIndex == 1 || GCase2().zlfaLeftSelectedIndex == 2) {
        if (GCase2().zlfaRightSelectedIndex == 0) {
            if (GCase2().zlfaWaifangliao == 1) {
                if (GCase2().zlfaLianheSelectedIndex == 1) {
                    mNumber = 7;
                } else {
                    mNumber = 6;
                }
            } else {
                if (GCase2().zlfaFuzhuSelectedIndex == 1) {
                    mNumber = 3;
                } else {
                    mNumber = 2;
                }
            }
        } else {
            if (GCase2().zlfaFuzhuSelectedIndex == 1) {
                mNumber = 5;
            } else {
                mNumber = 4;
            }
        }
    } else if (GCase2().zlfaLeftSelectedIndex == 3) {
        mNumber = 8;
    }

    GCase2().step1MNumber = mNumber;

    NSLog(@"MNUMBER: %ld", mNumber);
    return mNumber;
}

@end
