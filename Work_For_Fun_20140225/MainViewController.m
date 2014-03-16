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

@property (strong, nonatomic) HZQKViewController *hzqkViewController;
@property (strong, nonatomic) LCJCViewController *lcjcViewController;
@property (strong, nonatomic) ZDJGViewController *zdjgViewController;
@property (strong, nonatomic) ZLFAViewController *zlfaViewController;
@property (strong, nonatomic) BCJZViewController *bcjzViewController;

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

#warning JUST For TEST
    [GInstance() loadData];

    self.masterTagArray = @[
                            [NSNumber numberWithInt:HZQKButton1],
                            [NSNumber numberWithInt:LCJCButton1],
                            [NSNumber numberWithInt:ZDJGButton1],
                            [NSNumber numberWithInt:ZLFAButton1],
                            [NSNumber numberWithInt:LCJJButton1]

//                            [NSNumber numberWithInt:BSHGButton2],
//                            [NSNumber numberWithInt:LCJCButton2],
//                            [NSNumber numberWithInt:ZDJGButton2],
//                            [NSNumber numberWithInt:ZLFAButton2],
//                            [NSNumber numberWithInt:LCJJButton2]
                            ];

    self.masterButtonArray = [NSMutableArray array];

    self.hzqkViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"hzqkVC"];
    self.lcjcViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"lcjcVC"];
    self.zdjgViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zdjgVC"];
    self.zlfaViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"zlfaVC"];
    self.bcjzViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bcjzVC"];

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

    for (NSNumber *buttonTag in _masterTagArray) {
        UIButton *button = (UIButton *)[_masterScrollView viewWithTag:buttonTag.integerValue];
        if (button) {
            [_masterButtonArray addObject:button];
        } else {
//            NSLog(@"ButtonTag: %d", buttonTag.integerValue);
//            NSAssert(NO, @"Button not found!");
        }
    }

    self.detailViewArray = @[_hzqkViewController.view, _lcjcViewController.view,
                             _zdjgViewController.view, _zlfaViewController.view,
                             _bcjzViewController.view];

    for (int i = 0; i < _detailViewArray.count; i++) {
        [_detailScrollView addSubview:((UIView *)_detailViewArray[i])];
        ((UIView *)_detailViewArray[i]).frame = CGRectMake(0.0f, DETAILVIEWHEIGHT * i, DETAILVIEWIDTH, DETAILVIEWHEIGHT);
    }
    
    _detailScrollView.scrollEnabled = NO;
    _detailScrollView.contentSize = CGSizeMake(DETAILVIEWIDTH, DETAILVIEWHEIGHT*_detailViewArray.count);
    /* xxxxxx */
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
#warning TODO: 加载旧数据并赋值
    GInstance().globalData.currentIndex = 4;
    [self refreshButtonAndView:GInstance().globalData.currentIndex];

//    _checkButtonGroup.selectedItemTag = 207;
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
}

#pragma mark - ScrollViewController Delegate
- (void)didClickConfirmButton:(UIButton *)sender
{
    if (GInstance().globalData.currentIndex == 0) {
        [self refreshButtonAndView:1];
    } else if (GInstance().globalData.currentIndex == 1) {
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"请确认已经完成全部检查！"
                           cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{

        }]
                           otherButtonItems:[RIButtonItem itemWithLabel:@"确认" action:^{
            //TODO 需要发送请求
            sender.hidden = YES;
            [self refreshButtonAndView:2];
        }], nil] show];
    } else if (GInstance().globalData.currentIndex == 2) {
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"请确认已经完成诊断！"
                           cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{

        }]
                           otherButtonItems:[RIButtonItem itemWithLabel:@"确认" action:^{
            //TODO 需要发送请求
            ((UIView *)_detailViewArray[2]).userInteractionEnabled = NO;
//            sender.hidden = YES;
            [self refreshButtonAndView:3];
        }], nil] show];
    } else if (GInstance().globalData.currentIndex == 3) {
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"治疗方案确认后不能修改!"
                           cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{

        }]
                           otherButtonItems:[RIButtonItem itemWithLabel:@"确认" action:^{
            //TODO 需要发送请求
            ((UIView *)_detailViewArray[3]).userInteractionEnabled = NO;
//            sender.hidden = YES;
            [self refreshButtonAndView:4];
        }], nil] show];
    }
}

@end
