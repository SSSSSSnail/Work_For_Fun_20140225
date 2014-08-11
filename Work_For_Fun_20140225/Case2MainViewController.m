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

#import "BSHGC2ViewController.h"
#import "ZDJGS2C2ViewController.h"
#import "ZLFAS2C2ViewController.h"

#import "BSHGS3ViewController.h"
#import "ZLFAS3C2ViewController.h"

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

@property (strong, nonatomic) BSHGC2ViewController   *hzqk2ViewController;
@property (strong, nonatomic) LCJCC2ViewController   *lcjc2ViewController;
@property (strong, nonatomic) ZDJGS2C2ViewController *zdjg2ViewController;
@property (strong, nonatomic) ZLFAS2C2ViewController *zlfa2ViewController;
@property (strong, nonatomic) BCJZC2ViewController   *bcjz2ViewController;

@property (strong, nonatomic) BSHGS3ViewController *hzqk3ViewController;
@property (strong, nonatomic) LCJCC2ViewController *lcjc3ViewController;
@property (strong, nonatomic) ZDJGS2C2ViewController *zdjg3ViewController;
@property (strong, nonatomic) ZLFAS3C2ViewController *zlfa3ViewController;
@property (strong, nonatomic) BCJZC2ViewController *bcjz3ViewController;

@property (strong, nonatomic) NSMutableArray *masterButtonArray;
@property (strong, nonatomic) NSArray *detailViewArray;

@property (strong, nonatomic) NSArray *masterTagArray;

- (IBAction)clickNext:(LLUIButton *)sender;

- (IBAction)dateButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *c2DateLabel;
@property (weak, nonatomic) IBOutlet UIView *c2DateView;
@property (strong, nonatomic) NSArray *c2DateMappingArrayR1;
@property (strong, nonatomic) NSArray *c2DateMappingArrayR2;
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

    //访视1
    self.hzqk1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"hzqkVC"];
    self.lcjc1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"lcjcVC"];
    self.zdjg1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zdjgVC"];
    self.zlfa1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zlfaVC"];
    self.bcjz1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bcjzVC"];

    //访视2
    self.hzqk2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bshgVC"];
    self.lcjc2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"lcjcVC"];
    self.zdjg2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zdjg2VC"];
    self.zlfa2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zlfa2VC"];
    self.bcjz2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bcjzVC"];
    //访视3
    self.hzqk3ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bshg3VC"];
    self.lcjc3ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"lcjcVC"];
    self.zdjg3ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zdjg2VC"];
    self.zlfa3ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zlfa3VC"];
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
                             _lcjc2ViewController.view,
                             _zdjg2ViewController.view,
                             _zlfa2ViewController.view,
                             _bcjz2ViewController.view,

                             _hzqk3ViewController.view,
                             _lcjc3ViewController.view,
                             _zdjg3ViewController.view,
                             _zlfa3ViewController.view,
                             _bcjz3ViewController.view
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

    UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownCase2:)];
    swipeGes.direction = UISwipeGestureRecognizerDirectionDown;
    [_step2MasterView addGestureRecognizer:swipeGes];
    UISwipeGestureRecognizer *swipeGes3 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownCase2:)];
    swipeGes3.direction = UISwipeGestureRecognizerDirectionDown;
    [_step3MasterView addGestureRecognizer:swipeGes3];

    _c2DateLabel.font = [UIFont miscrosoftYaHeiFontWithSize:22.0f];
    _c2DateLabel.textColor = [UIColor colorWithRed:246.0f/255 green:134.0f/255 blue:2.0f/255 alpha:1];
    _c2DateLabel.text = @"";

    self.c2DateMappingArrayR1 = @[@0, @0, @25, @34, @34, @34, @25, @31, @28, @19]; //M值
    self.c2DateMappingArrayR2 = @[@0, @0,                   //M0 M1
                                  @[@0, @19, @20],          //M2
                                  @[@0, @10, @11, @10, @19], //M3
                                  @[@0, @10, @11, @10, @19], //M4
                                  @[@0, @10, @11, @10, @19], //M5
                                  @[@0, @13],               //M6
                                  @[@0, @13, @16, @13],     //M7
                                  @[@0, @10, @13, @10],     //M8
                                  @[@0, @13, @13, @10, @10] //M3
                                  ];
 }

#pragma mark - 测试模式
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
#ifndef SKIPREQUEST
    [self refreshButtonAndView:GCase2().currentIndex];
#endif

#ifdef SKIPREQUEST
    [self refreshButtonAndView:0];
//    GCase2().currentStep = Case2Step3;
//    GCase2().step1MNumber = 3;
//    GCase2().step2SNumber = 1;
//    [self refreshButtonAndView:12];
//    [_lcjc3ViewController refresh];
//    [_zlfa2ViewController refresh];
//    [_hzqk2ViewController refresh];
//    [_zlfa3ViewController refresh];
#endif
}

- (void)swipeDownCase2:(id)sender {
    if (GCase2().currentIndex > 4 &&  GCase2().currentIndex <10) {
        [self refreshButtonAndView:0];
    }

    if (GCase2().currentIndex > 9) {
        [self refreshButtonAndView:5];
    }

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
    [_detailScrollView scrollRectToVisible:CGRectMake(0.0f, DETAILVIEWHEIGHT * toIndex, DETAILVIEWIDTH, DETAILVIEWHEIGHT) animated:YES];

    int scrollNumber;
    if (toIndex <5) {
        scrollNumber = 0;
        _masterBGImageView.image = [UIImage imageNamed:@"leftMenuBG"];
    } else if (toIndex < 10) {
        scrollNumber = 1;
        _masterBGImageView.image = [UIImage imageNamed:@"c2leftMenuBG"];
    } else {
        scrollNumber = 2;
        _masterBGImageView.image = [UIImage imageNamed:@"c2leftMenu3BG"];
    }

    [_masterScrollView scrollRectToVisible:CGRectMake(0, MASTERVIEWHEIGHT * scrollNumber, MASTERVIEWWIDTH, MASTERVIEWHEIGHT) animated:YES];

    [self refreshDateLabel:toIndex];
}

- (void)refreshDateLabel:(long)toIndex
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];

    NSDate *fromDate = [dateFormatter dateFromString:@"2000/03/08"];
    NSDate *toDate;

    if (GCase2().currentIndex < 4) {
        toDate = fromDate;
    } else if (GCase2().currentIndex < 9) {
        toDate = [self addMonths:@[_c2DateMappingArrayR1[GCase2().step1MNumber], @0, @0] nowDate:fromDate];
    } else if (GCase2().currentIndex < 14) {
        toDate = [self addMonths:@[_c2DateMappingArrayR1[GCase2().step1MNumber], _c2DateMappingArrayR2[GCase2().step1MNumber][GCase2().step2SNumber], @0] nowDate:fromDate];
    } else {
        if (GCase2().zlfa3SegmentSelectedIndex == 5 || GCase2().zlfa3SegmentSelectedIndex == 6) {
            toDate = [self addMonths:@[_c2DateMappingArrayR1[GCase2().step1MNumber], _c2DateMappingArrayR2[GCase2().step1MNumber][GCase2().step2SNumber], @4] nowDate:fromDate];
        } else {
            toDate = [self addMonths:@[_c2DateMappingArrayR1[GCase2().step1MNumber], _c2DateMappingArrayR2[GCase2().step1MNumber][GCase2().step2SNumber], @7] nowDate:fromDate];
        }
    }
    _c2DateLabel.text = [dateFormatter stringFromDate:toDate];
    _c2DateView.hidden = NO;
    [GInstance() animationDateInOut:_c2DateView withCompletion:^{}];
}

- (IBAction)dateButtonClick:(UIButton *)sender
{
    [GInstance() animationScaleDownOut:_c2DateView withCompletion:^{
        _c2DateView.hidden = YES;
    }];
}

- (NSDate *)addMonths:(NSArray *)monthNumberArray nowDate:(NSDate *)nowDate
{
    __block int totalMonths = 0;

    NSLog(@"%@", monthNumberArray);

    [monthNumberArray enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        totalMonths = totalMonths + obj.intValue;
    }];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:totalMonths];
    [adcomps setDay:0];

    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:nowDate options:0];
    return newdate;
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
#pragma mark 患者情况访视一
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
                                             [_lcjc1ViewController refresh];
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
#pragma mark 临床检查访视一
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
#pragma mark 诊断结果访视一
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
#pragma mark 治疗方案访视一
        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:4];
        } else {
            NSDictionary *parametersDictionary = @{@"step": @"4",
                                                   @"action": @"solution",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber,
                                                   @"ddgc": globalData.zlfaLeftSelectedIndex == 4 ? @"Y" : @"N",
                                                   @"cggz": globalData.zlfaLeftSelectedIndex == 1 ? @"Y" : @"N",
                                                   @"fqgz": globalData.zlfaLeftSelectedIndex == 2 ? @"Y" : @"N",
                                                   @"wfl": (globalData.zlfaLeftSelectedIndex == 3 || globalData.zlfaWaifangliao == 1)? @"Y" : @"N",
                                                   @"dynf": globalData.zlfaRightSelectedIndex == 1 ? @"Y" : @"N",
                                                   @"lhnf": globalData.zlfaLianheSelectedIndex == 1 ? @"Y" : @"N",
                                                   @"xfz": globalData.zlfaRightSelectedIndex == 2 ? @"Y" : @"N",
                                                   @"fz": globalData.zlfaFuzhuSelectedIndex == 1 ? @"Y" : @"N",
                                                   @"xfqs": (globalData.zlfaChixujianxieDetailSelectedIndex == 1 && globalData.zlfaRightSelectedIndex == 2)? @"Y" : @"N",
                                                   @"xfkx": (globalData.zlfaChixujianxieDetailSelectedIndex == 2 && globalData.zlfaRightSelectedIndex == 2)? @"Y" : @"N",
                                                   @"xfzd": (globalData.zlfaChixujianxieDetailSelectedIndex == 3 && globalData.zlfaRightSelectedIndex == 2)? @"Y" : @"N",
                                                   @"xfzgsrl": [self ifSelectedYaowu:@"xfzgsrl" isXinFuZhu:YES],
                                                   @"xfzlbrl": [self ifSelectedYaowu:@"xfzlbrl" isXinFuZhu:YES],
                                                   @"xfzdpl1": [self ifSelectedYaowu:@"xfzdpl1" isXinFuZhu:YES],
                                                   @"xfzdpl3": [self ifSelectedYaowu:@"xfzdpl3" isXinFuZhu:YES],
                                                   @"xfzbkla": [self ifSelectedYaowu:@"xfzbkla" isXinFuZhu:YES],
                                                   @"xfzfta": [self ifSelectedYaowu:@"xfzfta" isXinFuZhu:YES],
                                                   
                                                   @"cx": (globalData.zlfaFuzhuChixuJianxieSelectedIndex == 1 ||
                                                           (globalData.zlfaChixuJianxieSelectedIndex == 1 && globalData.zlfaRightSelectedIndex != 2))? @"Y" : @"N",
                                                   @"jx": (globalData.zlfaFuzhuChixuJianxieSelectedIndex == 2 ||
                                                           (globalData.zlfaChixuJianxieSelectedIndex == 2 && globalData.zlfaRightSelectedIndex != 2)) ? @"Y" : @"N",
                                                   @"ssqs": (globalData.zlfaFuzhuChixujianxieDetailSelectedIndex == 4 ||
                                                             (globalData.zlfaChixujianxieDetailSelectedIndex == 4 && globalData.zlfaRightSelectedIndex != 2)) ? @"Y" : @"N",
                                                   @"fzqs": (globalData.zlfaFuzhuChixujianxieDetailSelectedIndex == 1 ||
                                                             (globalData.zlfaChixujianxieDetailSelectedIndex == 1 && globalData.zlfaRightSelectedIndex != 2)) ? @"Y" : @"N",
                                                   @"fzkx": (globalData.zlfaFuzhuChixujianxieDetailSelectedIndex == 2 ||
                                                             (globalData.zlfaChixujianxieDetailSelectedIndex == 2 && globalData.zlfaRightSelectedIndex != 2)) ? @"Y" : @"N",
                                                   @"fzzd": (globalData.zlfaFuzhuChixujianxieDetailSelectedIndex == 3 ||
                                                             (globalData.zlfaChixujianxieDetailSelectedIndex == 3 && globalData.zlfaRightSelectedIndex != 2)) ? @"Y" : @"N",

                                                   @"gsrl": [self ifSelectedYaowu:@"gsrl" isXinFuZhu:NO],
                                                   @"lbrl": [self ifSelectedYaowu:@"lbrl" isXinFuZhu:NO],
                                                   @"dpl1": [self ifSelectedYaowu:@"dpl1" isXinFuZhu:NO],
                                                   @"dpl3": [self ifSelectedYaowu:@"dpl3" isXinFuZhu:NO],
                                                   @"bkla": [self ifSelectedYaowu:@"bkla" isXinFuZhu:NO],
                                                   @"fta": [self ifSelectedYaowu:@"fta" isXinFuZhu:NO],
                                                   @"solution": [NSString stringWithFormat:@"m%ld", (long)[self countStep1MNumber]]
                                                   };

            NSLog(@"%@", parametersDictionary);

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
#pragma mark 病程进展访视一
        if (globalData.maxIndex > globalData.currentIndex) {
            globalData.currentStep = Case2Step2;
            [self refreshButtonAndView:5];
        } else {
            NSDictionary *parametersDictionary = @{@"step": @"5",
                                                   @"action": @"result",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber,
                                                   @"solution": [NSString stringWithFormat:@"m%ld", (long)[self countStep1MNumber]],
                                                   @"col1": [NSString stringWithFormat:@"m%ld|%@", (long)GCase2().step1MNumber, [_hzqk2ViewController chixujianxieString2]],
                                                   @"col2": [_hzqk2ViewController linchuangjiancheString2],
                                                   @"col3": [_hzqk2ViewController zhenduanString2],
                                                   @"col4": [_hzqk2ViewController weixianxingpingguString2],
                                                   @"col5": [NSString stringWithFormat:@"T%@N%@M%@", GCase2().zdjgTSelectItem, GCase2().zdjgNSelectItem, GCase2().zdjgMSelectItem],
                                                   @"col6": [_hzqk2ViewController loadZhiLiaoFangAn2],
                                                   @"col7": [_hzqk2ViewController loadButtonString2],
                                                   @"col8": [_hzqk2ViewController isTypeBetween2to7] ? @"Y" : @"N",
                                                   @"col9": [_hzqk2ViewController loadYaoWuFangAn2],
                                                   @"col10": [_hzqk2ViewController loadYaoWu2],

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
                                             globalData.currentStep = Case2Step2;
                                             [self refreshButtonAndView:5];
                                             [_hzqk2ViewController refresh];
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
#pragma mark 病史回顾访视二
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
                                             [_lcjc2ViewController refresh];
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
    } else if (globalData.currentIndex == 6) {
#pragma mark 临床检查访视二
        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:7];
        } else {
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:@"请确认已经完成诊断！"
                               cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{

            }]
                               otherButtonItems:[RIButtonItem itemWithLabel:@"确认" action:^{
                NSDictionary *parametersDictionary = @{@"step": @"7",
                                                       @"action": @"checkconfirm",
                                                       @"subject_id": globalData.subjectId,
                                                       @"group_id": globalData.groupNumber};
                [GInstance() httprequestWithHUD:_lcjc2ViewController.view
                                 withRequestURL:STEPURL
                                 withParameters:parametersDictionary
                                     completion:^(NSDictionary *jsonDic) {
                                         NSLog(@"responseJson: %@", jsonDic);
                                         if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                             if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                                 [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                             } else {
                                                 _lcjc2ViewController.isLocked = YES;
                                                 [self refreshButtonAndView:7];
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
    } else if (globalData.currentIndex == 7) {
#pragma mark 诊断结果访视二
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
                                                                                                            @"zd": globalData.zdjg2ZDSelectItem}];
                [GInstance() httprequestWithHUD:_zdjg2ViewController.view
                                 withRequestURL:STEPURL
                                 withParameters:parametersDictionary
                                     completion:^(NSDictionary *jsonDic) {
                                         NSLog(@"responseJson: %@", jsonDic);
                                         if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                             for (UIView *subView in [_zdjg2ViewController.view subviews]) {
                                                 if (subView.tag != 999) {
                                                     subView.userInteractionEnabled = NO;
                                                 }
                                             }
                                             if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                                 [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                             } else {
                                                 [self refreshButtonAndView:8];
                                                 [_zlfa2ViewController refresh];
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
    } else if (globalData.currentIndex == 8) {
#pragma mark 治疗方案访视二
        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:9];
        } else {
            NSDictionary *parametersDictionary = @{@"step": @"9",
                                                   @"action": @"solution",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber,
                                                   @"solution": [NSString stringWithFormat:@"m%lds%ld", (long)GCase2().step1MNumber, (long)[self countStep2SNumber]],

                                                   @"cggz": globalData.zlfa2SegmentSelectedIndex == 1 ? @"Y" :@"N",
                                                   @"fqgz": globalData.zlfa2SegmentSelectedIndex == 2 ? @"Y" :@"N",
                                                   @"wfl": globalData.zlfa2SegmentSelectedIndex == 3 ? @"Y" :@"N",
                                                   @"nfm": globalData.zlfa2SegmentSelectedIndex == 4 ? @"Y" :@"N",
                                                   @"zdkx": globalData.zlfa2SegmentSelectedIndex == 5 ? @"Y" :@"N",
                                                   @"hl": globalData.zlfa2SegmentSelectedIndex == 7 ? @"Y" :@"N",
                                                   @"nfm2": globalData.zlfa2SegmentSelectedIndex == 6 ? @"Y" :@"N",

                                                   @"fz": @"N",
                                                   @"cx": globalData.zlfaChixuJianxieNeifenSelectedIndex == 1 ? @"Y" :@"N",
                                                   @"jx": globalData.zlfaChixuJianxieNeifenSelectedIndex == 2 ? @"Y" :@"N",

                                                   @"ssqs": globalData.zlfaChixuJianxieNeifenDetailSelectedIndex == 4 ? @"Y" :@"N",
                                                   @"dyqs": globalData.zlfaChixuJianxieNeifenDetailSelectedIndex == 1 ? @"Y" :@"N",
                                                   @"dykx": globalData.zlfaChixuJianxieNeifenDetailSelectedIndex == 2 ? @"Y" :@"N",
                                                   @"zdxd": globalData.zlfaChixuJianxieNeifenDetailSelectedIndex == 3 ? @"Y" :@"N",
                                                   @"gsrl": [self ifSelectedYaowu:@"gsrl" isXinFuZhu:NO],
                                                   @"lbrl": [self ifSelectedYaowu:@"lbrl" isXinFuZhu:NO],
                                                   @"dpl1": [self ifSelectedYaowu:@"dpl1" isXinFuZhu:NO],
                                                   @"dpl3": [self ifSelectedYaowu:@"dpl3" isXinFuZhu:NO],
                                                   @"bkla": [self ifSelectedYaowu:@"bkla" isXinFuZhu:NO],
                                                   @"fta": [self ifSelectedYaowu:@"fta" isXinFuZhu:NO],

                                                   @"cjs": globalData.zlfa2ErfenSelectedIndex == 1 ? @"Y" :@"N",
                                                   @"fta2": globalData.zlfa2ErfenSelectedIndex == 2 ? @"Y" :@"N"
                                                   };

            for (NSString *keyString in parametersDictionary.allKeys) {
                NSLog(@"%@ : %@", keyString, parametersDictionary[keyString]);
            }

            [GInstance() httprequestWithHUD:_zlfa2ViewController.view
                             withRequestURL:STEPURL
                             withParameters:parametersDictionary
                                 completion:^(NSDictionary *jsonDic) {
                                     NSLog(@"responseJson: %@", jsonDic);
                                     if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                         for (UIView *subView in [_zlfa2ViewController.view subviews]) {
                                             if (subView.tag != 999) {
                                                 subView.userInteractionEnabled = NO;
                                             }
                                         }
                                         if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                             [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                         } else {
                                             GCase2().step2SNumber = [self countStep2SNumber];
                                             [self refreshButtonAndView:9];
                                             [_zlfa2ViewController rollToTopView];
                                             [_bcjz2ViewController refresh:GCase2().step1MNumber sNumber:GCase2().step2SNumber];
                                             [GInstance() savaData];
                                         }
                                     } else {
                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
                                         }
                                     }
                                 }];
        }
    } else if (globalData.currentIndex == 9) {
#pragma mark 病程进展访视二
        if (globalData.maxIndex > globalData.currentIndex) {
            globalData.currentStep = Case2Step3;
            [self refreshButtonAndView:10];
        } else {
            NSDictionary *parametersDictionary = @{@"step": @"10",
                                                   @"action": @"result",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber,
                                                   @"col1": [NSString stringWithFormat:@"m%ld|%@", (long)GCase2().step1MNumber, [_hzqk2ViewController chixujianxieString2]],
                                                   @"col2": [_hzqk2ViewController linchuangjiancheString2],
                                                   @"col3": [_hzqk2ViewController zhenduanString2],
                                                   @"col4": [_hzqk2ViewController weixianxingpingguString2],
                                                   @"col5": [NSString stringWithFormat:@"T%@N%@M%@", GCase2().zdjgTSelectItem, GCase2().zdjgNSelectItem, GCase2().zdjgMSelectItem],
                                                   @"col6": [_hzqk2ViewController loadZhiLiaoFangAn2],
                                                   @"col7": [_hzqk2ViewController loadButtonString2],
                                                   @"col8": [_hzqk2ViewController isTypeBetween2to7] ? @"Y" : @"N",
                                                   @"col9": [_hzqk2ViewController loadYaoWuFangAn2],
                                                   @"col10": [_hzqk2ViewController loadYaoWu2],
                                                   @"col11": [NSString stringWithFormat:@"m%lds%ld|%@", (long)GCase2().step1MNumber, (long)GCase2().step2SNumber, [_hzqk3ViewController chixujianxieString3]],
                                                   @"col12": [_hzqk3ViewController linchuangjiancheString3],
                                                   @"col13": [_hzqk3ViewController zhenduanString3],
                                                   @"col16": [_hzqk3ViewController loadZhiLiaoFangAn3],
                                                   @"col17": [_hzqk3ViewController loadButtonString3],
                                                   @"col18": [_hzqk3ViewController loadYaoWuFangAn3],
                                                   @"col19": [_hzqk3ViewController loadYaoWu3],
                                                   @"solution": [NSString stringWithFormat:@"m%lds%ld", (long)GCase2().step1MNumber, (long)GCase2().step2SNumber]
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
                                             globalData.currentStep = Case2Step3;
                                             [self refreshButtonAndView:10];
                                             [_hzqk3ViewController refresh];
                                             [GInstance() savaData];
                                         }
                                     } else {
                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
                                         }
                                     }
                                 }];
        }
    } else if (globalData.currentIndex == 10) {
#pragma mark 病史回顾访视三
        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:11];
        } else {
            NSDictionary *parametersDictionary = @{@"step": @"11",
                                                   @"action": @"info",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber};
            [GInstance() httprequestWithHUD:_hzqk3ViewController.view
                             withRequestURL:STEPURL
                             withParameters:parametersDictionary
                                 completion:^(NSDictionary *jsonDic) {
                                     NSLog(@"responseJson: %@", jsonDic);
                                     if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                         if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                             [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                         } else {
                                             [_lcjc3ViewController refresh];
                                             [self refreshButtonAndView:11];
                                             [GInstance() savaData];
                                         }
                                     } else {
                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
                                         }
                                     }
                                 }];
        }
    } else if (globalData.currentIndex == 11) {
#pragma mark 临床检查访视三
        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:12];
        } else {
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:@"请确认已经完成诊断！"
                               cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{

            }]
                               otherButtonItems:[RIButtonItem itemWithLabel:@"确认" action:^{
                NSDictionary *parametersDictionary = @{@"step": @"12",
                                                       @"action": @"checkconfirm",
                                                       @"subject_id": globalData.subjectId,
                                                       @"group_id": globalData.groupNumber};
                [GInstance() httprequestWithHUD:_lcjc3ViewController.view
                                 withRequestURL:STEPURL
                                 withParameters:parametersDictionary
                                     completion:^(NSDictionary *jsonDic) {
                                         NSLog(@"responseJson: %@", jsonDic);
                                         if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                             if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                                 [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                             } else {
                                                 _lcjc3ViewController.isLocked = YES;
                                                 [self refreshButtonAndView:12];
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
    } else if (globalData.currentIndex == 12) {
#pragma mark 诊断结果访视三
        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:13];
        } else {
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:@"请确认已经完成诊断！"
                               cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{

            }]
                               otherButtonItems:[RIButtonItem itemWithLabel:@"确认" action:^{
                NSMutableDictionary *parametersDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"step": @"13",
                                                                                                            @"action": @"diagnose",
                                                                                                            @"subject_id": globalData.subjectId,
                                                                                                            @"group_id": globalData.groupNumber,
                                                                                                            @"zd": globalData.zdjg3ZDSelectItem}];
                [GInstance() httprequestWithHUD:_zdjg3ViewController.view
                                 withRequestURL:STEPURL
                                 withParameters:parametersDictionary
                                     completion:^(NSDictionary *jsonDic) {
                                         NSLog(@"responseJson: %@", jsonDic);
                                         if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                             for (UIView *subView in [_zdjg3ViewController.view subviews]) {
                                                 if (subView.tag != 999) {
                                                     subView.userInteractionEnabled = NO;
                                                 }
                                             }
                                             if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                                 [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                             } else {
                                                 [self refreshButtonAndView:13];
                                                 [_zlfa3ViewController refresh];
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
    } else if (globalData.currentIndex == 13) {
#pragma mark 治疗方案访视三
        if (globalData.maxIndex > globalData.currentIndex) {
            [self refreshButtonAndView:14];
        } else {
            NSDictionary *parametersDictionary = @{@"step": @"14",
                                                   @"action": @"solution",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber,
                                                   @"solution": [NSString stringWithFormat:@"m%lds%ld", (long)GCase2().step1MNumber, (long)[self countStep2SNumber]],

                                                   @"gt": globalData.zlfa3GutongSelectedIndex == 1 ? @"Y" :@"N",
                                                   @"nfm": globalData.zlfa3SegmentSelectedIndex == 4 ? @"Y" :@"N",
                                                   @"zdkx": globalData.zlfa3SegmentSelectedIndex == 5 ? @"Y" :@"N",
                                                   @"hl": globalData.zlfa3SegmentSelectedIndex == 7 ? @"Y" :@"N",
                                                   @"nfm2": globalData.zlfa3SegmentSelectedIndex == 6 ? @"Y" :@"N",
                                                   @"abtl": globalData.zlfa3SegmentSelectedIndex == 8 ? @"Y" :@"N",

                                                   @"fz": @"N",
                                                   @"cx": globalData.zlfa3ChixuJianxieNeifenSelectedIndex == 1 ? @"Y" :@"N",
                                                   @"jx": globalData.zlfa3ChixuJianxieNeifenSelectedIndex == 2 ? @"Y" :@"N",

                                                   @"ssqs": globalData.zlfa3ChixuJianxieNeifenDetailSelectedIndex == 4 ? @"Y" :@"N",
                                                   @"dyqs": globalData.zlfa3ChixuJianxieNeifenDetailSelectedIndex == 1 ? @"Y" :@"N",
                                                   @"dykx": globalData.zlfa3ChixuJianxieNeifenDetailSelectedIndex == 2 ? @"Y" :@"N",
                                                   @"zdxd": globalData.zlfa3ChixuJianxieNeifenDetailSelectedIndex == 3 ? @"Y" :@"N",
                                                   @"gsrl": [self ifSelectedYaowu:@"gsrl" isXinFuZhu:NO],
                                                   @"lbrl": [self ifSelectedYaowu:@"lbrl" isXinFuZhu:NO],
                                                   @"dpl1": [self ifSelectedYaowu:@"dpl1" isXinFuZhu:NO],
                                                   @"dpl3": [self ifSelectedYaowu:@"dpl3" isXinFuZhu:NO],
                                                   @"bkla": [self ifSelectedYaowu:@"bkla" isXinFuZhu:NO],
                                                   @"fta": [self ifSelectedYaowu:@"fta" isXinFuZhu:NO],

                                                   @"cjs": globalData.zlfa3ErfenSelectedIndex == 1 ? @"Y" :@"N",
                                                   @"fta2": globalData.zlfa3ErfenSelectedIndex == 2 ? @"Y" :@"N"
                                                   };

            for (NSString *keyString in parametersDictionary.allKeys) {
                NSLog(@"%@ : %@", keyString, parametersDictionary[keyString]);
            }

            [GInstance() httprequestWithHUD:_zlfa3ViewController.view
                             withRequestURL:STEPURL
                             withParameters:parametersDictionary
                                 completion:^(NSDictionary *jsonDic) {
                                     NSLog(@"responseJson: %@", jsonDic);
                                     if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                         for (UIView *subView in [_zlfa3ViewController.view subviews]) {
                                             if (subView.tag != 999) {
                                                 subView.userInteractionEnabled = NO;
                                             }
                                         }
                                         if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
                                             [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
                                         } else {
                                             GCase2().step2SNumber = [self countStep2SNumber];
                                             [self refreshButtonAndView:14];
                                             [_zlfa3ViewController rollToTopView];
                                             [_bcjz3ViewController refresh];
                                             [GInstance() savaData];
                                         }
                                     } else {
                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
                                         }
                                     }
                                 }];
        }
    } else if (globalData.currentIndex == 14) {
        // 病程进展 第二轮确定
        NSDictionary *parametersDictionary = @{@"step": @"15",
                                               @"action": @"result",
                                               @"subject_id": globalData.subjectId,
                                               @"group_id": globalData.groupNumber};
        [GInstance() httprequestWithHUD:_bcjz3ViewController.view
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

    if (GCase2().zlfaRightSelectedIndex == 1) {
        mNumber = 9;
    }

    GCase2().step1MNumber = mNumber;

    NSLog(@"MNUMBER: %ld", (long)mNumber);
    return mNumber;
}

- (NSUInteger)countStep2SNumber
{
    if (GCase2().zlfa2SegmentSelectedIndex == 4 || //内分泌
        GCase2().zlfa2SegmentSelectedIndex == 1 || //手术1
        GCase2().zlfa2SegmentSelectedIndex == 2 || //手术2
        GCase2().zlfa2SegmentSelectedIndex == 5 //中断
        ) {
        return 1;
    }

    if ((GCase2().zlfa2SegmentSelectedIndex == 7 && GCase2().step1MNumber != 9) || //化疗
        ((GCase2().step1MNumber == 9 || GCase2().step1MNumber == 2) && GCase2().zlfa2SegmentSelectedIndex == 3) //外放疗
        ) {
        return 2;
    }

    if ((GCase2().zlfa2SegmentSelectedIndex == 6 && GCase2().step1MNumber != 9) || //二线
        (GCase2().zlfa2SegmentSelectedIndex == 7 && GCase2().step1MNumber == 9) //放疗
        ) {
        return 3;
    }

    if ((GCase2().zlfa2SegmentSelectedIndex == 6 && GCase2().step1MNumber == 9) || //二线
        (GCase2().step1MNumber != 9 && GCase2().step1MNumber != 2 && GCase2().zlfa2SegmentSelectedIndex == 3) //外放疗
        ) {
        return 4;
    }
    return 0;
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
        NSString *yaowu1 = GCase2().zlfaXinfuzhuYaowuName1;
        NSString *yaowu2 = GCase2().zlfaXinfuzhuYaowuName2;
        NSString *mergeName = [NSString stringWithFormat:@"%@%@", yaowuDic[yaowu1][0], yaowuDic[yaowu2][0]];
        if ([mergeName hasPrefix:yaowuName] || [mergeName hasSuffix:yaowuName]) {
            return @"Y";
        }else {
            return @"N";
        }
    } else {
        NSString *yaowu1;
        NSString *yaowu2;
        if (GCase2().currentStep == Case2Step1) {
            yaowu1 = GCase2().zlfaYaowuName1;
            yaowu2 = GCase2().zlfaYaowuName2;
        } else if (GCase2().currentStep == Case2Step2){
            yaowu1 = GCase2().zlfaNeifenmiYaowuName1;
            yaowu2 = GCase2().zlfaNeifenmiYaowuName2;
        } else {
            yaowu1 = GCase2().zlfa3NeifenmiYaowuName1;
            yaowu2 = GCase2().zlfa3NeifenmiYaowuName2;
        }
        NSString *mergeName = [NSString stringWithFormat:@"%@%@", yaowuDic[yaowu1][1], yaowuDic[yaowu2][1]];
        if ([mergeName hasPrefix:yaowuName] || [mergeName hasSuffix:yaowuName]) {
            return @"Y";
        }else {
            return @"N";
        }
    }
}

@end
