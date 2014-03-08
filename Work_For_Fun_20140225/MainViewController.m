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

@interface MainViewController ()<LLUIViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *masterScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *detailScrollVIew;

@property (weak, nonatomic) IBOutlet UITableView *tableviewLCJC;

@property (strong, nonatomic) NSMutableArray *masterButtonArray;
@property (strong, nonatomic) NSMutableArray *detailViewArray;

@property (strong, nonatomic) NSArray *masterTagArray;
@property (strong, nonatomic) NSArray *detailTagArray;

@property (strong, nonatomic) NSArray *lcjcTableViewLabelTextArray;

- (IBAction)clickNext:(LLUIButton *)sender;

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

    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        if ([familyName hasPrefix:@"Micro"]) {
            NSLog(@"%@", familyName);
        }
//        printf( "Family: %s \n", [familyName UTF8String] );
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//        for( NSString *fontName in fontNames ){
//            printf( "\tFont: %s \n", [fontName UTF8String] );
//        }
    }

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

    self.lcjcTableViewLabelTextArray = @[@"血常规", @"尿常规", @"血生化", @"凝血筛查", @"直肠指诊", @"心电图", @"超声心动", @"胸片", @"B超",
                                         @"前列腺特异抗原PSA", @"睾酮", @"放射性核素骨扫描", @"盆腔核磁共振MR", @"ECOG评分", @"穿刺活检", @"CT检查"];
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
#pragma mark TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 16;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedString = GInstance().globalData.lcjcSelectedArrayString;
    BOOL isSelected = [[selectedString componentsSeparatedByString:@","] containsObject:[NSString stringWithFormat:@"%ld", indexPath.row]];
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

    if (![selectedArray containsObject:[NSString stringWithFormat:@"%ld", indexPath.row]]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIImageView *rightImageView = (UIImageView *)[cell viewWithTag:1];
        rightImageView.image = [UIImage imageNamed:@"lcjcCellRightButtonSelected.png"];
        selectedString = [selectedString stringByAppendingFormat:@", %ld", indexPath.row];
    }
}

@end
