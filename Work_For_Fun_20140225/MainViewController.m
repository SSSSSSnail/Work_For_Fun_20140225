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

typedef NS_ENUM(NSInteger, ComponentsTag)
{
    UIPickViewZDJG1Evalute = 200,
    UIPickViewZDJG1T = 201,
    UIPickViewZDJG1N = 202,
    UIPickViewZDJG1M = 203,
    UIButtonQLZS = 204,
    UIButtonJXX = 205,
    UIButtonJBWQ = 206,
    UIButtonZYX = 207,
    UIPickViewZLFATYQS = 210,
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

@property (weak, nonatomic) IBOutlet UILabel *qgRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *bmRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *jnRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lbjRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *pgjgLabel;
@property (weak, nonatomic) IBOutlet UILabel *lcfqLabel;

@property (weak, nonatomic) IBOutlet LLUIPickView *zdjglcfqTPickView;
@property (weak, nonatomic) IBOutlet LLUIPickView *zdjglcfqNPickView;
@property (weak, nonatomic) IBOutlet LLUIPickView *zdjglcfqMPickView;
@property (weak, nonatomic) IBOutlet LLUIPickView *zdjgEvaluatePickView;

@property (strong, nonatomic) NSMutableArray *masterButtonArray;
@property (strong, nonatomic) NSArray *detailViewArray;

@property (strong, nonatomic) NSArray *masterTagArray;

@property (strong, nonatomic) NSDictionary *pickViewSourceDictionary;
@property (strong, nonatomic) LLCheckButtonGroup *checkButtonGroup;

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


    /* 诊断结果初始化 */
    self.pickViewSourceDictionary = @{@"200": @[doubleSpace, @"高危", @"中危", @"低危"],
                                      @"201": @[doubleSpace, @"1a", @"1b", @"1c", @"2a", @"2b", @"2c", @"3a", @"3b", @"4"],
                                      @"202": @[doubleSpace, @"0", @"1", @"2"],
                                      @"203": @[doubleSpace, @"0", @"1"]};
    self.checkButtonGroup = [[LLCheckButtonGroup alloc] init];
    [_zdjglcfqMPickView resizeFrameMinHeight];
    [_zdjglcfqTPickView resizeFrameMinHeight];
    [_zdjglcfqNPickView resizeFrameMinHeight];
    [_zdjgEvaluatePickView resizeFrameMinHeight];

    _lcfqLabel.text = @"T  N  M  ";
    UIFont *zdjgFont = [UIFont miscrosoftYaHeiFont];
    
//    NSArray *zdjgSubViews = [[_detailScrollView viewWithTag:ZDJGView1] subviews];
//    for (UIView *subView in zdjgSubViews) {
//        if ([subView isKindOfClass:[UILabel class]]) {
//            ((UILabel *)subView).font = zdjgFont;
//            continue;
//        }
//        if ([subView isKindOfClass:[LLCheckButton class]]) {
//            [_checkButtonGroup addObject:subView];
//        }
//    }
    /* xxxxxx */
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
#warning TODO: 加载旧数据并赋值
    GInstance().globalData.currentIndex = 3;
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


#pragma mark -
#pragma mark UIPickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *pickViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld", (long)pickerView.tag]];
    return [pickViewSource count];}

#pragma mark -
#pragma mark UIPickerView Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *pickViewSource = [self.pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)pickerView.tag]];
    return pickViewSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //选择内容之后进行存储的操作
    switch (pickerView.tag) {
        case UIPickViewZDJG1T: // 诊断结果 T
        {
            NSArray *pickerViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)pickerView.tag]];
            NSString *selectedString = pickerViewSource[row];
            ((LLUIPickView *)pickerView).selectedOjbect = selectedString;
            _qgRateLabel.hidden = NO;
            _bmRateLabel.hidden = NO;
            _jnRateLabel.hidden = NO;
            _lbjRateLabel.hidden = NO;
            if ([selectedString isEqualToString:@"1c"]) {
                _qgRateLabel.text = @"器官局限性癌概率：80%";
                _bmRateLabel.text = @"包膜侵犯概率：18%";
                _jnRateLabel.text = @"精囊侵犯概率：1%";
                _lbjRateLabel.text = @"淋巴结转移概率：0";
            } else if ([selectedString isEqualToString:@"2a"]) {
                _qgRateLabel.text = @"器官局限性癌概率：73%";
                _bmRateLabel.text = @"包膜侵犯概率：26%";
                _jnRateLabel.text = @"精囊侵犯概率：1%";
                _lbjRateLabel.text = @"淋巴结转移概率：0";
            } else if ([selectedString isEqualToString:@"2b"] || [_zdjglcfqTPickView.selectedOjbect isEqualToString:@"2c"]){
                _qgRateLabel.text = @"器官局限性癌概率：58%";
                _bmRateLabel.text = @"包膜侵犯概率：38%";
                _jnRateLabel.text = @"精囊侵犯概率：4%";
                _lbjRateLabel.text = @"淋巴结转移概率：1%";
            } else {
                _qgRateLabel.hidden = YES;
                _bmRateLabel.hidden = YES;
                _jnRateLabel.hidden = YES;
                _lbjRateLabel.hidden = YES;
            }
            // 添加label
            _lcfqLabel.text = [NSString stringWithFormat:@"T%@N%@M%@",_zdjglcfqTPickView.selectedOjbect,_zdjglcfqNPickView.selectedOjbect,_zdjglcfqMPickView.selectedOjbect];
            
        }
            break;
        case UIPickViewZDJG1M: // 诊断结果 M
        case UIPickViewZDJG1N: // 诊断结果 N
        {
            NSArray *pickerViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)pickerView.tag]];
            ((LLUIPickView *)pickerView).selectedOjbect = pickerViewSource[row];
            // 添加label
            _lcfqLabel.text = [NSString stringWithFormat:@"T%@N%@M%@",_zdjglcfqTPickView.selectedOjbect,_zdjglcfqNPickView.selectedOjbect,_zdjglcfqMPickView.selectedOjbect];
        }
            break;
        case UIPickViewZDJG1Evalute: //患者危险评估
        {
            NSArray *pickerViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)pickerView.tag]];
            ((LLUIPickView *)pickerView).selectedOjbect = pickerViewSource[row];
            _pgjgLabel.text = pickerViewSource[row];
        }
            break;
        default:
            break;
    }
}


- (BOOL)hasCompletedPickViewSelctionZDJGPage
{
    if ([_zdjglcfqTPickView.selectedOjbect isEqualToString:doubleSpace] ||
        [_zdjglcfqMPickView.selectedOjbect isEqualToString:doubleSpace] ||
        [_zdjglcfqNPickView.selectedOjbect isEqualToString:doubleSpace] ||
        [_zdjgEvaluatePickView.selectedOjbect isEqualToString:doubleSpace]) {
        return NO;
    }
    return YES;
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
