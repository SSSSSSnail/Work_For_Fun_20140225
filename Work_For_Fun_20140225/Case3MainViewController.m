//
//  Case2MainViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 25/7/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "Case3MainViewController.h"
#import "HZQKC3ViewController.h"
#import "LCJCC3ViewController.h"
#import "ZDJGC3ViewController.h"
#import "ZLFAC3ViewController.h"
#import "BCJZC3ViewController.h"
//
#import "BSHGC3ViewController.h"
#import "ZDJGS2C3ViewController.h"
#import "ZLFAS2C3ViewController.h"
//
//#import "BSHGS3ViewController.h"
//#import "ZLFAS3C2ViewController.h"

#import "Case3Data.h"

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

@interface Case3MainViewController ()<ScrollViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *masterScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *detailScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *masterBGImageView;

@property (weak, nonatomic) IBOutlet UIView *step1MasterView;
@property (weak, nonatomic) IBOutlet UIView *step2MasterView;
@property (weak, nonatomic) IBOutlet UIView *step3MasterView;

@property (strong, nonatomic) HZQKC3ViewController *hzqk1ViewController;
@property (strong, nonatomic) LCJCC3ViewController *lcjc1ViewController;
@property (strong, nonatomic) ZDJGC3ViewController *zdjg1ViewController;
@property (strong, nonatomic) ZLFAC3ViewController *zlfa1ViewController;
@property (strong, nonatomic) BCJZC3ViewController *bcjz1ViewController;
//
@property (strong, nonatomic) BSHGC3ViewController   *hzqk2ViewController;
@property (strong, nonatomic) LCJCC3ViewController   *lcjc2ViewController;
@property (strong, nonatomic) ZDJGS2C3ViewController *zdjg2ViewController;
@property (strong, nonatomic) ZLFAS2C3ViewController *zlfa2ViewController;
@property (strong, nonatomic) BCJZC3ViewController   *bcjz2ViewController;
//
//@property (strong, nonatomic) BSHGS3ViewController *hzqk3ViewController;
//@property (strong, nonatomic) LCJCC2ViewController *lcjc3ViewController;
//@property (strong, nonatomic) ZDJGS2C2ViewController *zdjg3ViewController;
//@property (strong, nonatomic) ZLFAS3C2ViewController *zlfa3ViewController;
//@property (strong, nonatomic) BCJZC2ViewController *bcjz3ViewController;

@property (strong, nonatomic) NSMutableArray *masterButtonArray;
@property (strong, nonatomic) NSArray *detailViewArray;

@property (strong, nonatomic) NSArray *masterTagArray;

- (IBAction)clickNext:(LLUIButton *)sender;

- (IBAction)dateButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *c3DateLabel;
@property (weak, nonatomic) IBOutlet UIView *c3DateView;
@property (strong, nonatomic) NSArray *c3DateMappingArrayR1;
@property (strong, nonatomic) NSArray *c3DateMappingArrayR2;
@end

@implementation Case3MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.masterTagArray = @[
                            @(HZQKButton1),
                            @(LCJCButton1),
                            @(ZDJGButton1),
                            @(ZLFAButton1),
                            @(LCJJButton1),

                            @(HZQKButton2),
                            @(LCJCButton2),
                            @(ZDJGButton2),
                            @(ZLFAButton2),
                            @(LCJJButton2)
                            ];

    self.masterButtonArray = [NSMutableArray array];

    //访视1
    self.hzqk1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"hzqkVC"];
    self.lcjc1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"lcjcVC"];
    self.zdjg1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zdjgVC"];
    self.zlfa1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zlfaVC"];
    self.bcjz1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bcjzVC"];
//
    //访视2
    self.hzqk2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bshgVC"];
    self.lcjc2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"lcjcVC"];
    self.zdjg2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zdjg2VC"];
    self.zlfa2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zlfa2VC"];
    self.bcjz2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bcjzVC"];

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
//

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
//
                             _hzqk2ViewController.view,
                             _lcjc2ViewController.view,
                             _zdjg2ViewController.view,
                             _zlfa2ViewController.view,
                             _bcjz2ViewController.view,

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

    UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownCase3:)];
    swipeGes.direction = UISwipeGestureRecognizerDirectionDown;
    [_step2MasterView addGestureRecognizer:swipeGes];
    UISwipeGestureRecognizer *swipeGes3 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownCase3:)];
    swipeGes3.direction = UISwipeGestureRecognizerDirectionDown;
    [_step3MasterView addGestureRecognizer:swipeGes3];

    _c3DateLabel.font = [UIFont miscrosoftYaHeiFontWithSize:22.0f];
    _c3DateLabel.textColor = [UIColor colorWithRed:246.0f/255 green:134.0f/255 blue:2.0f/255 alpha:1];
    _c3DateLabel.text = @"";


    self.c3DateMappingArrayR1 = @[@(0), @(30), @(36), @(42), @(39), @(42), @(24)];
    self.c3DateMappingArrayR2 = @[@0,
                                  @[@0, @6, @6, @12, @1, @12], //M1
                                  @[@0, @2, @2, @3, @1, @3],          //M2
                                  @[@0, @6, @6, @12, @1, @12], //M3
                                  @[@0, @6, @6, @12, @1, @12], //M4
                                  @[@0, @6, @6, @12, @1, @12], //M5
                                  @[@0, @6, @3, @6, @3]                     //M6
                                  ];
 }

#pragma mark - 测试模式
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
#ifndef SKIPREQUEST
    [self refreshButtonAndView:GCase3().currentIndex];
#endif

#ifdef SKIPREQUEST
    [self refreshButtonAndView:0];
//    GCase3().currentStep = Case2Step1;
//    GCase3().step1MNumber = 3;
//    GCase3().step2SNumber = 1;
//    [self refreshButtonAndView:3];
//    [_lcjc3ViewController refresh];
//    [_zlfa2ViewController refresh];
//    [_hzqk2ViewController refresh];
//    [_zlfa3ViewController refresh];
#endif
}

- (void)swipeDownCase3:(id)sender {
    if (GCase3().currentIndex > 4 &&  GCase3().currentIndex <10) {
        [self refreshButtonAndView:0];
    }

    if (GCase3().currentIndex > 9) {
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

    GCase3().currentIndex = toIndex;
    GCase3().maxIndex = MAX(toIndex, GCase3().maxIndex);
    [_detailScrollView scrollRectToVisible:CGRectMake(0.0f, DETAILVIEWHEIGHT * toIndex, DETAILVIEWIDTH, DETAILVIEWHEIGHT) animated:YES];

    int scrollNumber;
    if (toIndex <5) {
        scrollNumber = 0;
        _masterBGImageView.image = [UIImage imageNamed:@"zuocecaidan_c3"];
    } else if (toIndex < 10) {
        scrollNumber = 1;
        _masterBGImageView.image = [UIImage imageNamed:@"zuocecaidan_c3r2"];
    } else {
        scrollNumber = 2;
        _masterBGImageView.image = [UIImage imageNamed:@"zuocecaidan_c3"];
    }

    [_masterScrollView scrollRectToVisible:CGRectMake(0, MASTERVIEWHEIGHT * scrollNumber, MASTERVIEWWIDTH, MASTERVIEWHEIGHT) animated:YES];

    [self refreshDateLabel:toIndex];
}

- (void)refreshDateLabel:(long)toIndex
{
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    }
    NSDate *fromDate = [dateFormatter dateFromString:@"2010/06/18"];
    NSDate *toDate;

    if (GCase3().currentIndex < 4) {
        toDate = fromDate;
    } else if (GCase3().currentIndex < 9) {
        toDate = [self addMonths:@[_c3DateMappingArrayR1[GCase3().step1MNumber], @0, @0] nowDate:fromDate];
    } else if (GCase3().currentIndex < 14) {
        toDate = [self addMonths:@[_c3DateMappingArrayR1[GCase3().step1MNumber], _c3DateMappingArrayR2[GCase3().step1MNumber][GCase3().step2SNumber], @0] nowDate:fromDate];
    } else {
//        if (GCase3().zlfa3SegmentSelectedIndex == 5 || GCase3().zlfa3SegmentSelectedIndex == 6) {
//            toDate = [self addMonths:@[_c2DateMappingArrayR1[GCase3().step1MNumber], _c2DateMappingArrayR2[GCase3().step1MNumber][GCase3().step2SNumber], @4] nowDate:fromDate];
//        } else {
//            toDate = [self addMonths:@[_c2DateMappingArrayR1[GCase3().step1MNumber], _c2DateMappingArrayR2[GCase3().step1MNumber][GCase3().step2SNumber], @7] nowDate:fromDate];
//        }
    }
    _c3DateLabel.text = [dateFormatter stringFromDate:toDate];
    _c3DateView.hidden = NO;
    [GInstance() animationDateInOut:_c3DateView withCompletion:^{}];
}

- (IBAction)dateButtonClick:(UIButton *)sender
{
    [GInstance() animationScaleDownOut:_c3DateView withCompletion:^{
        _c3DateView.hidden = YES;
    }];
}

- (NSDate *)addMonths:(NSArray *)monthNumberArray nowDate:(NSDate *)nowDate
{
    __block int totalMonths = 0;

    NSLog(@"%@", monthNumberArray);

    [monthNumberArray enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        totalMonths = totalMonths + obj.intValue;
    }];

    static NSCalendar *calendar = nil;
    if (!calendar) {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
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
    if (sender.tag - 10 > GCase3().maxIndex) {
        [GInstance() showInfoMessage:@"请完成当前步骤！"];
        return;
    }
    [self refreshButtonAndView:sender.tag - 10];
}

#pragma mark - ScrollViewController Delegate
- (void)didClickConfirmButton:(UIButton *)sender
{
    Case3Data *globalData = GCase3();
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
                                                   @"nf1": globalData.zlfaRightSelectedIndex == 1 || globalData.zlfaBuchongRightSelectedIndex == 1 ? YCase : NCase,
                                                   @"hl": globalData.zlfaLeftSelectedIndex == 2 ? YCase : NCase,
                                                   @"wfl": globalData.zlfaLeftSelectedIndex == 3 || globalData.zlfaBuchongLeftSelectedIndex == 3 ? YCase : NCase,
                                                   @"gzbk": globalData.zlfaLeftSelectedIndex == 4 ? YCase : NCase,
                                                   @"gzpq": globalData.zlfaLeftSelectedIndex == 5 ? YCase : NCase,
                                                   @"ssqs": globalData.zlfaNeifenmiSelectedIndex == 1 || globalData.zlfaBuchongNeifenmiSelectedIndex == 1 ? YCase : NCase,
                                                   @"zdzd": globalData.zlfaNeifenmiSelectedIndex == 2 || globalData.zlfaBuchongNeifenmiSelectedIndex == 2 ? YCase : NCase,
                                                   
                                                   @"gsrl": [self ifSelectedYaowu:@"gsrl" isBuchong:NO],
                                                   @"lbrl": [self ifSelectedYaowu:@"lbrl" isBuchong:NO],
                                                   @"dpl1": [self ifSelectedYaowu:@"dpl1" isBuchong:NO],
                                                   @"dpl3": [self ifSelectedYaowu:@"dpl3" isBuchong:NO],
                                                   @"bkla": [self ifSelectedYaowu:@"bkla" isBuchong:NO],
                                                   @"fta": [self ifSelectedYaowu:@"fta" isBuchong:NO],
                                                   
                                                   @"cggzbk": globalData.zlfaGZSBikongSelectedIndex == 1 ? YCase : NCase,
                                                   @"fqgzbk": globalData.zlfaGZSBikongSelectedIndex == 2 ? YCase : NCase,
                                                   @"cggzpq": globalData.zlfaGZSPenqiangSelectedIndex == 1 ? YCase : NCase,
                                                   @"fqgzpq": globalData.zlfaGZSPenqiangSelectedIndex == 2 ? YCase : NCase,
                                                   
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
//            globalData.currentStep = Case2Step2;
            [self refreshButtonAndView:5];
        } else {
            NSDictionary *parametersDictionary = @{@"step": @"5",
                                                   @"action": @"result",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber,
                                                   @"solution": [NSString stringWithFormat:@"m%ld", (long)[self countStep1MNumber]],
                                                   @"col1": [NSString stringWithFormat:@"m%ld", (long)GCase3().step1MNumber],
                                                   @"col2": [_hzqk2ViewController linchuangjiancheString2],
                                                   @"col3": [_hzqk2ViewController zhenduanString2],
                                                   @"col4": [_hzqk2ViewController weixianxingpingguString2],
                                                   @"col5": [NSString stringWithFormat:@"T%@N%@M%@", GCase3().zdjgTSelectItem, GCase3().zdjgNSelectItem, GCase3().zdjgMSelectItem],
                                                   @"col6": [_hzqk2ViewController loadZhiLiaoFangAn2],
                                                   @"col7": [_hzqk2ViewController loadButtonString2],
                                                   @"col8": [_hzqk2ViewController isNeededShowBingli] ? @"Y" : @"N",
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
//                                             globalData.currentStep = Case2Step2;
                                             [self refreshButtonAndView:5];
                                             [_zlfa1ViewController rollToTopView];
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
            NSString *cforJXNF = nil;
            NSString *nf1 = nil;
            if (GCase3().step1MNumber == 6) {
                cforJXNF = NCase;
                if (GCase3().zlfa2RightSelectIndex == 1) {
                    nf1 = YCase;
                } else {
                    nf1 = NCase;
                }
            } else {
                nf1 = NCase;
                if (GCase3().zlfa2RightSelectIndex == 1) {
                    cforJXNF = YCase;
                } else {
                    cforJXNF = NCase;
                }
            }
            
            NSDictionary *parametersDictionary = @{@"step": @"9",
                                                   @"action": @"solution",
                                                   @"subject_id": globalData.subjectId,
                                                   @"group_id": globalData.groupNumber,
                                                   @"solution": [NSString stringWithFormat:@"m%lds%ld", (long)GCase3().step1MNumber, (long)[self countStep2SNumber]],
                                                   
                                                   @"exnf": globalData.zlfa2LeftSelectedIndex == 5 ? YCase :NCase,
                                                   @"lcsy": globalData.zlfa2LeftSelectedIndex == 6 ? YCase : NCase,
                                                   @"wfl": globalData.zlfa2LeftSelectedIndex == 3 ? YCase :NCase,
                                                   @"hl": globalData.zlfa2LeftSelectedIndex == 2 ? YCase : NCase,
                                                   @"nf1":nf1,
                                                   
                                                   @"ssqs": globalData.zlfa2NeifenmiSelectedIndex == 1 ? YCase : NCase,
                                                   @"zdzd": globalData.zlfa2NeifenmiSelectedIndex == 2 ? YCase : NCase,
                                                   
                                                   @"abtl" : globalData.zlfa2LinchuangYaowuSelectedIndex == 1 ? YCase : NCase,
                                                   @"ezla" : globalData.zlfa2LinchuangYaowuSelectedIndex == 2 ? YCase : NCase,
                                                   @"ecjs" : globalData.zlfa2ErfenSelectedIndex == 1 ? YCase : NCase,
                                                   @"efta" : globalData.zlfa2ErfenSelectedIndex == 2 ? YCase : NCase,
                                                   @"jxnf": cforJXNF,
                                                   
                                                   @"gsrl": [self ifSelectedYaowu:@"gsrl" isBuchong:YES],
                                                   @"lbrl": [self ifSelectedYaowu:@"lbrl" isBuchong:YES],
                                                   @"dpl1": [self ifSelectedYaowu:@"dpl1" isBuchong:YES],
                                                   @"dpl3": [self ifSelectedYaowu:@"dpl3" isBuchong:YES],
                                                   @"bkla": [self ifSelectedYaowu:@"bkla" isBuchong:YES],
                                                   @"fta": [self ifSelectedYaowu:@"fta" isBuchong:YES],
                                                   
                                                   @"gtzl": globalData.zlfa2GutongSelecteIndex == 4 ? YCase : NCase,
                                                   @"zlfl" : globalData.zlfa2GutongItemSelecteIndex == 1 ? YCase : NCase,
                                                   @"zlhj" : globalData.zlfa2GutongItemSelecteIndex == 2 ? YCase : NCase,
                                                   
                                                   
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
                                             
                                             GCase3().step2SNumber = [self countStep2SNumber];
                                             [self refreshButtonAndView:9];
                                             [_zlfa2ViewController rollToTopView];
                                             [_bcjz2ViewController refreshWithArray:[self countStep2Array]];
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
        NSDictionary *parametersDictionary = @{@"step": @"10",
                                               @"action": @"result",
                                               @"subject_id": globalData.subjectId,
                                               @"group_id": globalData.groupNumber};
        [GInstance() httprequestWithHUD:_bcjz2ViewController.view
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

//        if (globalData.maxIndex > globalData.currentIndex) {
//            globalData.currentStep = Case2Step3;
//            [self refreshButtonAndView:10];
//        } else {
//            NSDictionary *parametersDictionary = @{@"step": @"10",
//                                                   @"action": @"result",
//                                                   @"subject_id": globalData.subjectId,
//                                                   @"group_id": globalData.groupNumber,
//                                                   @"col1": [NSString stringWithFormat:@"m%ld|%@", (long)GCase3().step1MNumber, [_hzqk2ViewController chixujianxieString2]],
//                                                   @"col2": [_hzqk2ViewController linchuangjiancheString2],
//                                                   @"col3": [_hzqk2ViewController zhenduanString2],
//                                                   @"col4": [_hzqk2ViewController weixianxingpingguString2],
//                                                   @"col5": [NSString stringWithFormat:@"T%@N%@M%@", GCase3().zdjgTSelectItem, GCase3().zdjgNSelectItem, GCase3().zdjgMSelectItem],
//                                                   @"col6": [_hzqk2ViewController loadZhiLiaoFangAn2],
//                                                   @"col7": [_hzqk2ViewController loadButtonString2],
//                                                   @"col8": [_hzqk2ViewController isTypeBetween2to7] ? @"Y" : @"N",
//                                                   @"col9": [_hzqk2ViewController loadYaoWuFangAn2],
//                                                   @"col10": [_hzqk2ViewController loadYaoWu2],
//                                                   @"col11": [NSString stringWithFormat:@"m%lds%ld|%@", (long)GCase3().step1MNumber, (long)GCase3().step2SNumber, [_hzqk3ViewController chixujianxieString3]],
//                                                   @"col12": [_hzqk3ViewController linchuangjiancheString3],
//                                                   @"col13": [_hzqk3ViewController zhenduanString3],
//                                                   @"col16": [_hzqk3ViewController loadZhiLiaoFangAn3],
//                                                   @"col17": [_hzqk3ViewController loadButtonString3],
//                                                   @"col18": [_hzqk3ViewController loadYaoWuFangAn3],
//                                                   @"col19": [_hzqk3ViewController loadYaoWu3],
//                                                   @"solution": [NSString stringWithFormat:@"m%lds%ld", (long)GCase3().step1MNumber, (long)GCase3().step2SNumber]
//                                                   };
//            
//            [GInstance() httprequestWithHUD:_bcjz1ViewController.view
//                             withRequestURL:STEPURL
//                             withParameters:parametersDictionary
//                                 completion:^(NSDictionary *jsonDic) {
//                                     NSLog(@"responseJson: %@", jsonDic);
//                                     if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
//                                         if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
//                                             [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
//                                         } else {
//                                             globalData.currentStep = Case2Step3;
//                                             [self refreshButtonAndView:10];
//                                             [_hzqk3ViewController refresh];
//                                             [GInstance() savaData];
//                                         }
//                                     } else {
//                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
//                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
//                                         }
//                                     }
//                                 }];
//        }
    } else if (globalData.currentIndex == 10) {
//#pragma mark 病史回顾访视三
//        if (globalData.maxIndex > globalData.currentIndex) {
//            [self refreshButtonAndView:11];
//        } else {
//            NSDictionary *parametersDictionary = @{@"step": @"11",
//                                                   @"action": @"info",
//                                                   @"subject_id": globalData.subjectId,
//                                                   @"group_id": globalData.groupNumber};
//            [GInstance() httprequestWithHUD:_hzqk3ViewController.view
//                             withRequestURL:STEPURL
//                             withParameters:parametersDictionary
//                                 completion:^(NSDictionary *jsonDic) {
//                                     NSLog(@"responseJson: %@", jsonDic);
//                                     if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
//                                         if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
//                                             [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
//                                         } else {
//                                             [_lcjc3ViewController refresh];
//                                             [self refreshButtonAndView:11];
//                                             [GInstance() savaData];
//                                         }
//                                     } else {
//                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
//                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
//                                         }
//                                     }
//                                 }];
//        }
    } else if (globalData.currentIndex == 11) {
//#pragma mark 临床检查访视三
//        if (globalData.maxIndex > globalData.currentIndex) {
//            [self refreshButtonAndView:12];
//        } else {
//            [[[UIAlertView alloc] initWithTitle:nil
//                                        message:@"请确认已经完成诊断！"
//                               cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{
//                
//            }]
//                               otherButtonItems:[RIButtonItem itemWithLabel:@"确认" action:^{
//                NSDictionary *parametersDictionary = @{@"step": @"12",
//                                                       @"action": @"checkconfirm",
//                                                       @"subject_id": globalData.subjectId,
//                                                       @"group_id": globalData.groupNumber};
//                [GInstance() httprequestWithHUD:_lcjc3ViewController.view
//                                 withRequestURL:STEPURL
//                                 withParameters:parametersDictionary
//                                     completion:^(NSDictionary *jsonDic) {
//                                         NSLog(@"responseJson: %@", jsonDic);
//                                         if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
//                                             if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
//                                                 [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
//                                             } else {
//                                                 _lcjc3ViewController.isLocked = YES;
//                                                 [self refreshButtonAndView:12];
//                                                 [GInstance() savaData];
//                                             }
//                                         } else {
//                                             if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
//                                                 [GInstance() showErrorMessage:@"服务器结果异常!"];
//                                             }
//                                         }
//                                     }];
//            }], nil] show];
//        }
    } else if (globalData.currentIndex == 12) {
//#pragma mark 诊断结果访视三
//        if (globalData.maxIndex > globalData.currentIndex) {
//            [self refreshButtonAndView:13];
//        } else {
//            [[[UIAlertView alloc] initWithTitle:nil
//                                        message:@"请确认已经完成诊断！"
//                               cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{
//                
//            }]
//                               otherButtonItems:[RIButtonItem itemWithLabel:@"确认" action:^{
//                NSMutableDictionary *parametersDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"step": @"13",
//                                                                                                            @"action": @"diagnose",
//                                                                                                            @"subject_id": globalData.subjectId,
//                                                                                                            @"group_id": globalData.groupNumber,
//                                                                                                            @"zd": globalData.zdjg3ZDSelectItem}];
//                [GInstance() httprequestWithHUD:_zdjg3ViewController.view
//                                 withRequestURL:STEPURL
//                                 withParameters:parametersDictionary
//                                     completion:^(NSDictionary *jsonDic) {
//                                         NSLog(@"responseJson: %@", jsonDic);
//                                         if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
//                                             for (UIView *subView in [_zdjg3ViewController.view subviews]) {
//                                                 if (subView.tag != 999) {
//                                                     subView.userInteractionEnabled = NO;
//                                                 }
//                                             }
//                                             if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
//                                                 [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
//                                             } else {
//                                                 [self refreshButtonAndView:13];
//                                                 [_zlfa3ViewController refresh];
//                                                 [GInstance() savaData];
//                                             }
//                                         } else {
//                                             if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
//                                                 [GInstance() showErrorMessage:@"服务器结果异常!"];
//                                             }
//                                         }
//                                     }];
//            }], nil] show];
//        }
    } else if (globalData.currentIndex == 13) {
//#pragma mark 治疗方案访视三
//        if (globalData.maxIndex > globalData.currentIndex) {
//            [self refreshButtonAndView:14];
//        } else {
//            NSDictionary *parametersDictionary = @{@"step": @"14",
//                                                   @"action": @"solution",
//                                                   @"subject_id": globalData.subjectId,
//                                                   @"group_id": globalData.groupNumber,
//                                                   @"solution": [NSString stringWithFormat:@"m%lds%ld", (long)GCase3().step1MNumber, (long)[self countStep2SNumber]],
//                                                   
//                                                   @"gt": globalData.zlfa3GutongSelectedIndex == 1 ? @"Y" :@"N",
//                                                   @"nfm": globalData.zlfa3SegmentSelectedIndex == 4 ? @"Y" :@"N",
//                                                   @"zdkx": globalData.zlfa3SegmentSelectedIndex == 5 ? @"Y" :@"N",
//                                                   @"hl": globalData.zlfa3SegmentSelectedIndex == 7 ? @"Y" :@"N",
//                                                   @"nfm2": globalData.zlfa3SegmentSelectedIndex == 6 ? @"Y" :@"N",
//                                                   @"abtl": globalData.zlfa3SegmentSelectedIndex == 8 ? @"Y" :@"N",
//                                                   
//                                                   @"fz": @"N",
//                                                   @"cx": globalData.zlfa3ChixuJianxieNeifenSelectedIndex == 1 ? @"Y" :@"N",
//                                                   @"jx": globalData.zlfa3ChixuJianxieNeifenSelectedIndex == 2 ? @"Y" :@"N",
//                                                   
//                                                   @"ssqs": globalData.zlfa3ChixuJianxieNeifenDetailSelectedIndex == 4 ? @"Y" :@"N",
//                                                   @"dyqs": globalData.zlfa3ChixuJianxieNeifenDetailSelectedIndex == 1 ? @"Y" :@"N",
//                                                   @"dykx": globalData.zlfa3ChixuJianxieNeifenDetailSelectedIndex == 2 ? @"Y" :@"N",
//                                                   @"zdxd": globalData.zlfa3ChixuJianxieNeifenDetailSelectedIndex == 3 ? @"Y" :@"N",
//                                                   @"gsrl": [self ifSelectedYaowu:@"gsrl" isXinFuZhu:NO],
//                                                   @"lbrl": [self ifSelectedYaowu:@"lbrl" isXinFuZhu:NO],
//                                                   @"dpl1": [self ifSelectedYaowu:@"dpl1" isXinFuZhu:NO],
//                                                   @"dpl3": [self ifSelectedYaowu:@"dpl3" isXinFuZhu:NO],
//                                                   @"bkla": [self ifSelectedYaowu:@"bkla" isXinFuZhu:NO],
//                                                   @"fta": [self ifSelectedYaowu:@"fta" isXinFuZhu:NO],
//                                                   
//                                                   @"cjs": globalData.zlfa3ErfenSelectedIndex == 1 ? @"Y" :@"N",
//                                                   @"fta2": globalData.zlfa3ErfenSelectedIndex == 2 ? @"Y" :@"N"
//                                                   };
//            
//            for (NSString *keyString in parametersDictionary.allKeys) {
//                NSLog(@"%@ : %@", keyString, parametersDictionary[keyString]);
//            }
//            
//            [GInstance() httprequestWithHUD:_zlfa3ViewController.view
//                             withRequestURL:STEPURL
//                             withParameters:parametersDictionary
//                                 completion:^(NSDictionary *jsonDic) {
//                                     NSLog(@"responseJson: %@", jsonDic);
//                                     if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
//                                         for (UIView *subView in [_zlfa3ViewController.view subviews]) {
//                                             if (subView.tag != 999) {
//                                                 subView.userInteractionEnabled = NO;
//                                             }
//                                         }
//                                         if ([(NSString *)jsonDic[@"locked"] isEqualToString:@"true"]) {
//                                             [GInstance() showInfoMessage:@"暂停进入下一阶段！"];
//                                         } else {
//                                             GCase3().step2SNumber = [self countStep2SNumber];
//                                             [self refreshButtonAndView:14];
//                                             [_zlfa3ViewController rollToTopView];
//                                             [_bcjz3ViewController refresh];
//                                             [GInstance() savaData];
//                                         }
//                                     } else {
//                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
//                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
//                                         }
//                                     }
//                                 }];
//        }
    } else if (globalData.currentIndex == 14) {
        // 病程进展 第二轮确定
//        NSDictionary *parametersDictionary = @{@"step": @"15",
//                                               @"action": @"result",
//                                               @"subject_id": globalData.subjectId,
//                                               @"group_id": globalData.groupNumber};
//        [GInstance() httprequestWithHUD:_bcjz3ViewController.view
//                         withRequestURL:STEPURL
//                         withParameters:parametersDictionary
//                             completion:^(NSDictionary *jsonDic) {
//                                 NSLog(@"responseJson: %@", jsonDic);
//                                 if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
//                                     [GInstance() showInfoMessage:@"治疗结束！"];
//                                     [GInstance() savaData];
//                                 } else {
//                                     if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
//                                         [GInstance() showErrorMessage:@"服务器结果异常!"];
//                                     }
//                                 }
//                             }];
    }
}

- (NSUInteger)countStep1MNumber
{
    NSUInteger mNumber = 0;
    if (GCase3().step1MNumber != 0) {
        return GCase3().step1MNumber;
    }

    if (GCase3().zlfaLeftSelectedIndex != 0) {
        
        if (GCase3().zlfaLeftSelectedIndex == 5) {
            if (GCase3().zlfaBuchongRightSelectedIndex != 0) {
                mNumber = 5;
            } else {
                mNumber = 6;
            }
        } else {
            mNumber = GCase3().zlfaLeftSelectedIndex;
        }
    } else {
        mNumber = 1;
    }
    
    GCase3().step1MNumber = mNumber;
    return mNumber;
}

- (NSUInteger)countStep2SNumber
{
    NSArray *array = [self countStep2Array];
    NSInteger index = [array[1] integerValue] ;
//    GCase3().step2SNumber = index;
    return index;
}

- (NSArray *)countStep2Array
{
    Case3Data *globalData = GCase3();
    NSInteger sNumber = 0;
    NSInteger subNumber = 0;
    if (globalData.step1MNumber == 6) {
        if (globalData.zlfa2LeftSelectedIndex == 0) {
            sNumber = 1;
        } else {
            if (globalData.zlfa2LeftSelectedIndex == 2) {
                if (globalData.zlfa2RightSelectIndex == 0) {
                    sNumber = 3;
                } else {
                    sNumber = 4;
                }
            } else if (globalData.zlfa2LeftSelectedIndex == 3) {
                sNumber = 2;
            }
        }
    } else {
        if (globalData.zlfa2LeftSelectedIndex == 5) {
            sNumber = 1;
        } else if (globalData.zlfa2LeftSelectedIndex == 2) {
            if (globalData.zlfa2RightSelectIndex == 0) {
                sNumber = 2;
            } else {
                sNumber = 3;
            }
        } else if (globalData.zlfa2LeftSelectedIndex == 6) {
            if (globalData.zlfa2RightSelectIndex == 0) {
                sNumber = 4;
            } else {
                sNumber = 5;
            }
        }
    }
    subNumber = globalData.zlfa2LinchuangYaowuSelectedIndex;
    
    NSInteger mNumber = globalData.step1MNumber;
    if (mNumber == 4 || mNumber == 5) {
        mNumber = 3;
    }
    
    return @[@(mNumber), @(sNumber), @(subNumber)];
}

/*
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
        NSString *yaowu1 = GCase3().zlfaXinfuzhuYaowuName1;
        NSString *yaowu2 = GCase3().zlfaXinfuzhuYaowuName2;
        NSString *mergeName = [NSString stringWithFormat:@"%@%@", yaowuDic[yaowu1][0], yaowuDic[yaowu2][0]];
        if ([mergeName hasPrefix:yaowuName] || [mergeName hasSuffix:yaowuName]) {
            return @"Y";
        }else {
            return @"N";
        }
    } else {
        NSString *yaowu1;
        NSString *yaowu2;
        if (GCase3().currentStep == Case2Step1) {
            yaowu1 = GCase3().zlfaYaowuName1;
            yaowu2 = GCase3().zlfaYaowuName2;
        } else if (GCase3().currentStep == Case2Step2){
            yaowu1 = GCase3().zlfaNeifenmiYaowuName1;
            yaowu2 = GCase3().zlfaNeifenmiYaowuName2;
        } else {
            yaowu1 = GCase3().zlfa3NeifenmiYaowuName1;
            yaowu2 = GCase3().zlfa3NeifenmiYaowuName2;
        }
        NSString *mergeName = [NSString stringWithFormat:@"%@%@", yaowuDic[yaowu1][1], yaowuDic[yaowu2][1]];
        if ([mergeName hasPrefix:yaowuName] || [mergeName hasSuffix:yaowuName]) {
            return @"Y";
        }else {
            return @"N";
        }
    }
         return YCase;
}
 */

 
 
- (NSString *)ifSelectedYaowu:(NSString *)yaowuName isBuchong:(BOOL)isBuchong
{
    Case3Data *globalData = GCase3();
    NSDictionary *yaowuDic = @{
                               @"dpl3" : @"达菲林 3月剂型",
                               @"dpl1" : @"达菲林 1月剂型",
                               @"gsrl" : @"戈舍瑞林",
                               @"lbrl" : @"亮丙瑞林",
                               @"bkla": @"比卡鲁胺",
                               @"fta" :@"氟他胺"
                               };
    
    NSString *ywName = yaowuDic[yaowuName];
    if (isBuchong) {
        if ([globalData.zlfaNeifenmiYaowuName1 isEqualToString:ywName] || [globalData.zlfaNeifenmiYaowuName2 isEqualToString:ywName]) {
            return YCase;
        }
    } else {
        if ([globalData.zlfaBuchongRightYWName1 isEqualToString:ywName] || [globalData.zlfaBuchongRightYWName2 isEqualToString:ywName] ||
            [globalData.zlfaRightYWName1 isEqualToString:ywName] || [globalData.zlfaRightYWName2 isEqualToString:ywName]) {
            return YCase;
        }
    }
    return NCase;
}




@end
