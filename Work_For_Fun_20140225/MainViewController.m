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
    HZQKButton = 10,
    LCJCButton = 11,
    ZDJGButton = 12,
    ZLFAButton = 13,
    LCJJButton = 14
};

typedef NS_ENUM(NSUInteger, ScrollSubViewTag)
{
    HZQKView = 110,
    LCJCView = 111,
    ZDJGView = 112,
    ZLFAView = 113,
    LCJJView = 114
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
                            [NSNumber numberWithInt:HZQKButton],
                            [NSNumber numberWithInt:LCJCButton],
                            [NSNumber numberWithInt:ZDJGButton],
                            [NSNumber numberWithInt:ZLFAButton],
                            [NSNumber numberWithInt:LCJJButton]
                            ];
    self.detailTagArray = @[
                            [NSNumber numberWithInt:HZQKView],
                            [NSNumber numberWithInt:LCJCView],
                            [NSNumber numberWithInt:ZDJGView],
                            [NSNumber numberWithInt:ZLFAView],
                            [NSNumber numberWithInt:LCJJView]
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
        if (scrollSubButton.tag == 10) {
            scrollSubButton.highlighted = YES;
        }
        if (scrollSubButton.tag != 11) {
            scrollSubButton.enabled = NO;
        }
    }

    for (LLUIView *scrollSubView in _detailViewArray) {
        NSLog(@"scrollSubView.tag: %d", scrollSubView.tag);
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

- (void)refreshButtonAndView:(int)toIndex
{
    NSLog(@"toIndex: %d", toIndex);
    UIButton *fromButton = (UIButton *)[_masterScrollView viewWithTag:toIndex + 9];
    fromButton.highlighted = NO;
    UIButton *toButton = (UIButton *)[_masterScrollView viewWithTag:toIndex + 10];
    toButton.highlighted = YES;
    toButton.enabled = NO;
    UIButton *nextButton = (UIButton *)[_masterScrollView viewWithTag:toIndex + 11];
    nextButton.enabled = YES;

    [_detailScrollVIew scrollRectToVisible:CGRectMake(0.0f, DETAILVIEWHEIGHT*toIndex, DETAILVIEWIDTH, DETAILVIEWHEIGHT) animated:YES];
}

@end
