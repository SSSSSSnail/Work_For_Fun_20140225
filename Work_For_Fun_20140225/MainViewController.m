//
//  MainViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 27/2/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "MainViewController.h"
#import "LLUIView.h"
#import "LLUIButton.h"

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

typedef NS_ENUM(NSUInteger, ScrollSubViewTag)
{
    HZQKView1 = 110, //患者情况
    LCJCView1 = 111, //临床检查
    ZDJGView1 = 112, //诊断结果
    ZLFAView1 = 113, //治疗方案
    LCJJView1 = 114, //临床结局

    BSHGView2 = 115, //病史回顾
    LCJCView2 = 116, //临床检查
    ZDJGView2 = 117, //诊断结果
    ZLFAView2 = 118, //治疗方案
    LCJJView2 = 119  //临床结局

};

static float const DETAILVIEWHEIGHT = 768.0f;
static float const DETAILVIEWIDTH = 877.0f;

@interface MainViewController ()<LLUIViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *masterScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *detailScrollVIew;

@property (strong, nonatomic) NSMutableArray *masterButtonArray;
@property (strong, nonatomic) NSMutableArray *detailViewArray;

@property (strong, nonatomic) NSArray *masterTagArray;
@property (strong, nonatomic) NSArray *detailTagArray;

- (IBAction)clickNext:(LLUIButton *)sender;

@end

@implementation MainViewController

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

    self.detailTagArray = @[
                            [NSNumber numberWithInt:HZQKView1],
                            [NSNumber numberWithInt:LCJCView1],
                            [NSNumber numberWithInt:ZDJGView1],
                            [NSNumber numberWithInt:ZLFAView1],
                            [NSNumber numberWithInt:LCJJView1],

                            [NSNumber numberWithInt:BSHGView2],
                            [NSNumber numberWithInt:LCJCView2],
                            [NSNumber numberWithInt:ZDJGView2],
                            [NSNumber numberWithInt:ZLFAView2],
                            [NSNumber numberWithInt:LCJJView2]
                            ];

    self.masterButtonArray = [NSMutableArray array];
    self.detailViewArray = [NSMutableArray array];

    for (NSNumber *buttonTag in _masterTagArray) {
        UIButton *button = (UIButton *)[_masterScrollView viewWithTag:buttonTag.integerValue];
        if (button) {
            [_masterButtonArray addObject:button];
        } else {
//            NSLog(@"ButtonTag: %d", buttonTag.integerValue);
//            NSAssert(NO, @"Button not found!");
        }
    }

    for (NSNumber *viewTag in _detailTagArray) {
        UIView *view = [_detailScrollVIew viewWithTag:viewTag.integerValue];
        if (view) {
            [_detailViewArray addObject:view];
        } else {
//            NSLog(@"ViewTag: %d", viewTag.integerValue);
//            NSAssert(NO, @"View not found!");
        }
    }




    for (UIButton *scrollSubButton in _masterButtonArray) {
//        if (scrollSubButton.tag == 10) {
//            scrollSubButton.highlighted = YES;
//        }
//        if (scrollSubButton.tag != 11) {
//            scrollSubButton.enabled = NO;
//        }
    }

    for (LLUIView *scrollSubView in _detailViewArray) {
        NSLog(@"scrollSubView.tag: %ld", scrollSubView.tag);
        scrollSubView.frame = CGRectMake(0.0f, DETAILVIEWHEIGHT*(scrollSubView.tag - 110), DETAILVIEWIDTH, DETAILVIEWHEIGHT);
        scrollSubView.LLDelegate = self;
    }
    
    _detailScrollVIew.scrollEnabled = NO;
    _detailScrollVIew.contentSize = CGSizeMake(DETAILVIEWIDTH, DETAILVIEWHEIGHT*_detailViewArray.count);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)swipeup:(UIView *)sender
{
    [self refreshButtonAndView:sender.tag - 109];
}

- (IBAction)clickNext:(LLUIButton *)sender
{
    [self refreshButtonAndView:sender.tag - 10];
}

- (void)refreshButtonAndView:(long)toIndex
{
//    NSLog(@"toIndex: %ld", toIndex);
//    UIButton *fromButton = (UIButton *)[_masterScrollView viewWithTag:toIndex + 9];
//    fromButton.highlighted = NO;
//    UIButton *toButton = (UIButton *)[_masterScrollView viewWithTag:toIndex + 10];
//    toButton.highlighted = YES;
//    toButton.enabled = NO;
//    UIButton *nextButton = (UIButton *)[_masterScrollView viewWithTag:toIndex + 11];
//    nextButton.enabled = YES;

    [_detailScrollVIew scrollRectToVisible:CGRectMake(0.0f, DETAILVIEWHEIGHT*toIndex, DETAILVIEWIDTH, DETAILVIEWHEIGHT) animated:YES];
}

@end
