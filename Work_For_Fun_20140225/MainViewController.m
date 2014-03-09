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

typedef NS_ENUM(NSInteger, ComponentsTag)
{
    UITableViewLCJC = 199,

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
static float const DETAILVIEWIDTH = 877.0f;

@interface MainViewController ()<LLUIViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *masterScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *detailScrollVIew;

@property (weak, nonatomic) IBOutlet UITableView *tableviewLCJC;
@property (weak, nonatomic) IBOutlet UIImageView *lcjcResultImageView;
@property (weak, nonatomic) IBOutlet UIButton *lcjcOkButton;

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
@property (strong, nonatomic) NSMutableArray *detailViewArray;

@property (strong, nonatomic) NSArray *masterTagArray;
@property (strong, nonatomic) NSArray *detailTagArray;

@property (strong, nonatomic) NSArray *lcjcTableViewLabelTextArray;
@property (strong, nonatomic) NSArray *lcjcTableToImageNameArray;
@property (assign, nonatomic) BOOL isLcjcDeatilView;

@property (strong, nonatomic) NSDictionary *pickViewSourceDictionary;
@property (strong, nonatomic) LLCheckButtonGroup *checkButtonGroup;

- (IBAction)clickNext:(LLUIButton *)sender;
- (IBAction)detailViewConfirm:(UIButton *)sender;
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

#warning For TEST
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

    /* 临床检查初始化 */
    self.lcjcTableViewLabelTextArray = @[@"血常规", @"尿常规", @"血生化", @"凝血筛查", @"直肠指诊", @"心电图", @"超声心动", @"胸片", @"B超",
                                         @"前列腺特异抗原PSA", @"睾酮", @"放射性核素骨扫描", @"盆腔核磁共振MR", @"ECOG评分", @"穿刺活检", @"CT检查"];
    self.lcjcTableToImageNameArray = @[@"xuechanggui.png", @"niaochanggui.png", @"xueshenghua.png", @"ningxueshaicha.png",
                                       @"zhichangzhizhen.png", @"xindiantu.png", @"chaoshengxindong.png", @"xiongpian.png",
                                       @"BChao.png", @"qianliexianteyikangyuan.png", @"gaotong.png", @"fangshexinghesugusaomiao.png",
                                       @"penqianghecigongzhen.png", @"ECOGpingfen.png", @"chuancihuojian.png", @"CTjiancha.png"];

    UILabel *lcjcHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
    lcjcHeaderLabel.textAlignment = NSTextAlignmentCenter;
    lcjcHeaderLabel.text = @"选择相关检查项目";
    lcjcHeaderLabel.font = [UIFont miscrosoftYaHeiFontWithSize:22.0f];
    lcjcHeaderLabel.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    _tableviewLCJC.tableHeaderView = lcjcHeaderLabel;

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
    
    NSArray *zdjgSubViews = [[_detailScrollVIew viewWithTag:ZDJGView1] subviews];
    for (UIView *subView in zdjgSubViews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            ((UILabel *)subView).font = zdjgFont;
            continue;
        }
        if ([subView isKindOfClass:[LLCheckButton class]]) {
            [_checkButtonGroup addObject:subView];
        }
    }
    /* xxxxxx */
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
#warning TODO: 加载旧数据并赋值
    [self refreshButtonAndView:GInstance().globalData.currentIndex];

//    _checkButtonGroup.selectedItemTag = 207;
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
    if (sender.tag == 110) {
        [self refreshButtonAndView:sender.tag - 109];
    }
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

- (IBAction)detailViewConfirm:(UIButton *)sender
{
    NSLog(@"%ld",(long)self.checkButtonGroup.selectedItemTag);

    NSLog(@"%ld", sender.tag);

    /* 临床检查 */
    if (_isLcjcDeatilView) {
        _isLcjcDeatilView = NO;
        [UIView transitionFromView:_lcjcResultImageView
                            toView:_tableviewLCJC
                          duration:1.0
                           options:UIViewAnimationOptionTransitionCurlDown | UIViewAnimationOptionShowHideTransitionViews
                        completion:^(BOOL finished) {
                            [_lcjcOkButton setImage:[UIImage imageNamed:@"okButton.png"] forState:UIControlStateNormal];
                        }];
    }
}

#pragma mark -
#pragma mark TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 16;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedString = GInstance().globalData.lcjcSelectedArrayString;
    BOOL isSelected = [[selectedString componentsSeparatedByString:@","] containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    NSString *rightImageName = isSelected?@"lcjcCellRightButtonSelected.png":@"lcjcCellRightButtonUnselected.png";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lcjcTableviewCell"];
    cell.textLabel.font = [UIFont miscrosoftYaHeiFontWithSize:22.0f];
    cell.textLabel.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    UIImageView *rightImageView = (UIImageView *)[cell viewWithTag:1];
    rightImageView.image = [UIImage imageNamed:rightImageName];
	cell.textLabel.text = _lcjcTableViewLabelTextArray[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedString = GInstance().globalData.lcjcSelectedArrayString;
    NSArray *selectedArray = [selectedString componentsSeparatedByString:@","];

    if (![selectedArray containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIImageView *rightImageView = (UIImageView *)[cell viewWithTag:1];
        rightImageView.image = [UIImage imageNamed:@"lcjcCellRightButtonSelected.png"];
        selectedString = [selectedString stringByAppendingFormat:@", %ld", (long)indexPath.row];
    }
    dispatch_semaphore_t t = dispatch_semaphore_create(0);
    if (indexPath.row == 12) {
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"您在临床检查中核磁检查的时机选择？"
                           cancelButtonItem:[RIButtonItem itemWithLabel:@"穿刺活检前" action:^{
            dispatch_semaphore_signal(t);

        }]
                           otherButtonItems:[RIButtonItem itemWithLabel:@"穿刺活检后" action:^{
            dispatch_semaphore_signal(t);
        }], nil] show];
    } else {
        dispatch_semaphore_signal(t);
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(t, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            _lcjcResultImageView.image = [UIImage imageNamed:_lcjcTableToImageNameArray[indexPath.row]];
            _isLcjcDeatilView = YES;
            [UIView transitionFromView:_tableviewLCJC
                                toView:_lcjcResultImageView
                              duration:1.0
                               options:UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionShowHideTransitionViews
                            completion:^(BOOL finished) {
                                [_lcjcOkButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
                            }];
        });
    });


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

@end
