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
#import "LLUIPickView.h"

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

typedef NS_ENUM(NSInteger, SUBVIEWTAG)
{
    UIPICKVIEWZDJG1EVALUTE = 200,
    UIPICKVIEWZDJG1T = 201,
    UIPICKVIEWZDJG1N = 202,
    UIPICKVIEWZDJG1M = 203,
    UIPICKVIEWZLFATYQS = 204,
};

static float const DETAILVIEWHEIGHT = 768.0f;
static float const DETAILVIEWIDTH = 877.0f;

@interface MainViewController ()<LLUIViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *masterScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *detailScrollVIew;

@property (weak, nonatomic) IBOutlet UILabel *ZDJGFQ;
@property (weak, nonatomic) IBOutlet UILabel *qgRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *bmRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *jnRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lbjRateLabel;

@property (weak, nonatomic) IBOutlet LLUIPickView *zdjglcfqTPickView;
@property (weak, nonatomic) IBOutlet LLUIPickView *zdjglcfqNPickView;
@property (weak, nonatomic) IBOutlet LLUIPickView *zdjglcfqMPickView;
@property (weak, nonatomic) IBOutlet LLUIPickView *zdjgEvaluatePickView;

@property (weak, nonatomic) IBOutlet UIButton *qzButton;


@property (strong, nonatomic) NSMutableArray *masterButtonArray;
@property (strong, nonatomic) NSMutableArray *detailViewArray;

@property (strong, nonatomic) NSArray *masterTagArray;
@property (strong, nonatomic) NSArray *detailTagArray;

@property (strong, nonatomic) NSDictionary *pickViewSourceDictionary;

- (IBAction)clickNext:(LLUIButton *)sender;
- (void)fillDictionary;

@end

@implementation MainViewController

#pragma mark -
#pragma mark Controller Life Cycle
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
                            [NSNumber numberWithInt:LCJJButton1]

//                            [NSNumber numberWithInt:BSHGButton2],
//                            [NSNumber numberWithInt:LCJCButton2],
//                            [NSNumber numberWithInt:ZDJGButton2],
//                            [NSNumber numberWithInt:ZLFAButton2],
//                            [NSNumber numberWithInt:LCJJButton2]
                            ];

    self.detailTagArray = @[
                            [NSNumber numberWithInt:HZQKView1],
                            [NSNumber numberWithInt:LCJCView1],
                            [NSNumber numberWithInt:ZDJGView1],
                            [NSNumber numberWithInt:ZLFAView1],
                            [NSNumber numberWithInt:LCJJView1]

//                            [NSNumber numberWithInt:BSHGView2],
//                            [NSNumber numberWithInt:LCJCView2],
//                            [NSNumber numberWithInt:ZDJGView2],
//                            [NSNumber numberWithInt:ZLFAView2],
//                            [NSNumber numberWithInt:LCJJView2]
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

    for (LLUIView *scrollSubView in _detailViewArray) {
        scrollSubView.frame = CGRectMake(0.0f, DETAILVIEWHEIGHT*(scrollSubView.tag - 110), DETAILVIEWIDTH, DETAILVIEWHEIGHT);
        scrollSubView.LLDelegate = self;
    }
    
    _detailScrollVIew.scrollEnabled = NO;
    _detailScrollVIew.contentSize = CGSizeMake(DETAILVIEWIDTH, DETAILVIEWHEIGHT*_detailViewArray.count);
    [self fillDictionary];
    [self resizingPickView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
#warning TODO: 加载旧数据并赋值
    [self refreshButtonAndView:GInstance().globalData.currentIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 页面切换按钮刷新事件处理

- (void)swipeup:(UIView *)sender
{
    [self refreshButtonAndView:sender.tag - 109];
}

- (IBAction)clickNext:(LLUIButton *)sender
{
    if (sender.tag - 10 >=  GInstance().globalData.currentIndex) {
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
    [_detailScrollVIew scrollRectToVisible:CGRectMake(0.0f, DETAILVIEWHEIGHT*toIndex, DETAILVIEWIDTH, DETAILVIEWHEIGHT) animated:YES];
}

#pragma mark -
#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (YES) {
       return [self pickerViewInZDJGPage:pickerView];
    }
}

#pragma mark -
#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (YES) {
        return [self pickerViewInZDJGPage:pickerView titleForRow:row];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //选择内容之后进行存储的操作
    if (YES) {
        [self pickerViewInZDJGPage:pickerView didSelectRow:row];
    }
}

#pragma mark -
#pragma mark - private

#pragma mark - ZDJGPage

- (void)resizingPickView
{
    [self.zdjglcfqMPickView resizeFrameMinHeight];
    [self.zdjglcfqTPickView resizeFrameMinHeight];
    [self.zdjglcfqNPickView resizeFrameMinHeight];
}

//将Source 确定
- (void)fillDictionary
{
    NSArray *resultArray = @[ @"",@"高危", @"中危", @"低危"];
    NSArray *tArray = @[ @"", @"1a", @"1b", @"1c", @"2a", @"2b", @"2c", @"3a", @"3b", @"4"];
    NSArray *nArray = @[ @"", @"0", @"1", @"2"];
    NSArray *mArray = @[ @"", @"0", @"1"];
    self.pickViewSourceDictionary = [NSMutableDictionary dictionaryWithDictionary:@{ @"200": resultArray, @"201": tArray, @"202": nArray, @"203":mArray}];
}

- (void)showPickViewSelectedResult
{
#warning mark calc the Rate and show
    
}

- (BOOL)hasCompletedPickViewSelctionZDJGPage
{
    if ([self.zdjglcfqTPickView.selectedOjbect isEqualToString:@""] ||
        [self.zdjglcfqMPickView.selectedOjbect isEqualToString:@""] ||
        [self.zdjglcfqNPickView.selectedOjbect isEqualToString:@""] ||
        [self.zdjgEvaluatePickView.selectedOjbect isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (BOOL)hasCompletedButtonSelectionZDJGPage
{
#warning mark ButtonGroup has selected One Object
    return YES;
}

- (void)confirmQZButtonEable
{
    self.qzButton.enabled = [self hasCompletedButtonSelectionZDJGPage] && [self hasCompletedPickViewSelctionZDJGPage];
}

#pragma mark - 诊断结果 PickView UIPickerViewDelegate

- (NSInteger)pickerViewInZDJGPage:(UIPickerView *)pickerView
{
    NSArray *pickViewSource = [self.pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)pickerView.tag]];
    return [pickViewSource count];
}

- (void)pickerViewInZDJGPage:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
{
    switch (pickerView.tag) {
        case UIPICKVIEWZDJG1T:
        case UIPICKVIEWZDJG1M:
        case UIPICKVIEWZDJG1N:
        {
            NSArray *pickViewSource = [self.pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)pickerView.tag]];
            ((LLUIPickView *)pickerView).selectedOjbect = [pickViewSource objectAtIndex:row];
            [self showPickViewSelectedResult];
        }
            break;
        case UIPICKVIEWZDJG1EVALUTE:
        {
            NSArray *pickViewSource = [self.pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)pickerView.tag]];
            ((LLUIPickView *)pickerView).selectedOjbect = [pickViewSource objectAtIndex:row];
        }
            break;
        default:
            break;
    }
    [self confirmQZButtonEable];
}

#pragma mark - 诊断结果 UIPickerViewDataSource
- (NSString *)pickerViewInZDJGPage:(UIPickerView *)pickerView titleForRow:(NSInteger)row
{
    NSArray *pickViewSource = [self.pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)pickerView.tag]];
    return pickViewSource[row];
}

@end
