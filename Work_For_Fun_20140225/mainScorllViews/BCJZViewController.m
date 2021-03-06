//
//  BCJZViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 15/3/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "BCJZViewController.h"
#import "Case1Data.h"

static NSString *originDateString        = @"2000/1/18 星期五";
static NSString *oneYearLater            = @"2001/2/18 星期日"; //case 1 13月
static NSString *twoYearLater            = @"2002/2/18 星期一"; //case 2 25月
static NSString *twoYearNineMonthLater   = @"2002/11/18 星期一";//case 3 34月
static NSString *twoYearSixMonthLater    = @"2002/8/18 星期日"; //case 4 31月
static NSString *twoYearsThreeMonthLater = @"2002/5/18 星期六"; //case 5 28月

static NSString *oneMonthCase1           = @"2001/3/18 星期日"; //one Year later
static NSString *oneMonthCase2           = @"2002/3/18 星期一"; // two year later
static NSString *oneMonthCase3           = @"2002/12/18 星期三"; //twoyear nine month later
static NSString *oneMonthCase4           = @"2002/9/18 星期三"; //twoyear six month later
static NSString *oneMonthCase5           = @"2002/6/18 星期二";//twoyear three monthlater


static NSString *sixMonthCase1           = @"2001/9/18 星期二"; //one Year later
static NSString *sixMonthCase2           = @"2002/9/18 星期三"; // two year later
static NSString *sixMonthCase3           = @"2003/6/18 星期三"; //twoyear nine month later
static NSString *sixMonthCase4           = @"2003/3/18 星期二"; //twoyear six month later
static NSString *sixMonthCase5           = @"2002/12/18 星期一";//twoyear three monthlater




@interface BCJZViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bcjzImage;
@property (weak, nonatomic) IBOutlet UILabel *datetimeLabel;
@property (strong, nonatomic) NSDate *bcjzDate;

@end

@implementation BCJZViewController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)confirmClick:(UIButton *)sender
{
    if ([_scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
        [_scrollViewDelegate didClickConfirmButton:sender];
    }
}

- (void)changeLabelText:(BCJZResult)result
{
    //切换图片
    GCase1().r1Result = result;
    _bcjzImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"bcjz%ld.png", (long)result]];
    GCase1().r2Type = [self mResultFromResult:result];
    //切换Label
    switch (result) {
        case ZDJC:      //主动监测 case 1
        {
            _datetimeLabel.text = oneYearLater;
            GCase1().dateTimeOneMonth = oneMonthCase1;
            GCase1().dateTimeSixMonth = sixMonthCase1;
        }
            break;
        case GZS:       //M2 根治术
        case GZSFL:     //M6 根治术+放疗
        case FL:        //M7 放疗 case 2
        {
            _datetimeLabel.text = twoYearLater;
            GCase1().dateTimeOneMonth = oneMonthCase2;
            GCase1().dateTimeSixMonth = sixMonthCase2;
        }
            break;
        case GZSFZNFMCX: //M3 根治术+辅助 持续
        case GZSFZNFMJX: //M3 根治术+辅助 间歇
        case XFZNFMGZSFZNFMCX: //M5 新辅助+根治术+辅助 持续
        case XFZNFMGZSFZNFMJX: //M5 新辅助+根治术+辅助 间歇 case 3
        {
            _datetimeLabel.text = twoYearNineMonthLater;
            GCase1().dateTimeOneMonth = oneMonthCase3;
            GCase1().dateTimeSixMonth = sixMonthCase3;
        }
            break;
        case XFZNFMGZS: //M4 新辅助+根治术 case 4
        {
            _datetimeLabel.text = twoYearSixMonthLater;
            GCase1().dateTimeOneMonth = oneMonthCase4;
            GCase1().dateTimeSixMonth = sixMonthCase4;
        }
            break;
        case FLFZNFMCX: //M8 放疗+辅助 持续
        case FLFZNFMJX: //M8 放疗+辅助 间歇 case 5
        {
            _datetimeLabel.text = twoYearsThreeMonthLater;
            GCase1().dateTimeOneMonth = oneMonthCase5;
            GCase1().dateTimeSixMonth = sixMonthCase5;
        }
            break;
        default:
            break;
    }
}

//step 10
- (void)changedLabelTextInM2:(BCJZResult)result
{
    _datetimeLabel.text = GCase1().dateTimeSixMonth;
//    _datetimeLabel.hidden = NO;
//    switch (result) {
//        case ZDJC:      //主动监测 case 1 one year
//        {
//            _datetimeLabel.text = sixMonthCase1;
//        }
//            break;
//        case GZS:       //M2 根治术
//        case GZSFL:     //M6 根治术+放疗
//        case FL:        //M7 放疗 // case 2 two year
//        {
//            _datetimeLabel.text = sixMonthCase2;
//        }
//            break;
//        case GZSFZNFMCX: //M3 根治术+辅助 持续
//        case GZSFZNFMJX: //M3 根治术+辅助 间歇
//        case XFZNFMGZSFZNFMCX: //M5 新辅助+根治术+辅助 持续
//        case XFZNFMGZSFZNFMJX: //M5 新辅助+根治术+辅助 间歇 // case 3 twoYearNinMonthLater
//        {
//            _datetimeLabel.text = sixMonthCase3;
//        }
//            break;
//        case XFZNFMGZS: //M4 新辅助+根治术 // case 4 twoYearSixMonthLater
//        {
//            _datetimeLabel.text = sixMonthCase4;
//        }
//            break;
//        case FLFZNFMCX: //M8 放疗+辅助 持续
//        case FLFZNFMJX: //M8 放疗+辅助 间歇 // case 5 twoYearthreeMonthLater
//        {
//            _datetimeLabel.text = sixMonthCase5;
//        }
//            break;
//        default:
//            _datetimeLabel.hidden = YES;
//            break;
//    }
}

- (BCJZMResult)mResultFromResult:(BCJZResult)result
{
    BCJZMResult mResult;
    switch (result) {
        case ZDJC:      //主动监测 case 1 one year
        {
            mResult = M1;
        }
            break;
        case GZS:       //M2 根治术
        {
            mResult = M2;
        }
            break;
        case GZSFZNFMCX: //M3 根治术+辅助 持续
        case GZSFZNFMJX: //M3 根治术+辅助 间歇
        {
            mResult = M3;
        }
            break;
        case XFZNFMGZS: //M4 新辅助+根治术 // case 4 twoYearSixMonthLater
        {
            mResult = M4;
        }
            break;
        case XFZNFMGZSFZNFMCX: //M5 新辅助+根治术+辅助 持续
        case XFZNFMGZSFZNFMJX: //M5 新辅助+根治术+辅助 间歇 // case 3 twoYearNinMonthLater
        {
            mResult = M5;
        }
            break;
        case GZSFL:     //M6 根治术+放疗
        {
            mResult = M6;
        }
            break;
        case FL:        //M7 放疗 // case 2 two year
        {
            mResult = M7;
        }
            break;
        case FLFZNFMCX: //M8 放疗+辅助 持续
        case FLFZNFMJX: //M8 放疗+辅助 间歇 // case 5 twoYearthreeMonthLater
        {
            mResult = M8;
        }
            break;
        default:
            mResult = M1;
            break;
    }
    return mResult;
}

#pragma mark - Reload Data
- (void)reloadViewDataForR2
{
    _datetimeLabel.text = GCase1().dateTimeSixMonth;

    _bcjzImage.frame = CGRectMake(0, 0, 872.0f, 768.0f);
    NSString *imageName;
    if (GCase1().zlfaLeftSelectedIndex == 1 ||
        GCase1().zlfaLeftSelectedIndex == 2) {
        imageName = @"bcjzR2_Shoushu.png"; //手术
    } else if (GCase1().zlfaLeftSelectedIndex == 3 ||
               GCase1().zlfaLeftSelectedIndex == 4) {
        imageName = @"bcjzR2_Fangliao.png"; //放疗
    } else if (GCase1().zlfaLeftSelectedIndex == 5) {
        imageName = @"bcjzR2_Zhudong.png"; //主动监测
    }

    if (GCase1().zlfaR2RightSelectedIndex == 1) {
        imageName = @"bcjzR2_Fuzhu.png"; //辅助内分泌
    } else if (GCase1().zlfaR2RightSelectedIndex == 2) {
        imageName = @"bcjzR2_Hualiao.png"; //化疗
    } else if (GCase1().zlfaR2RightSelectedIndex == 3) {
        imageName = @"bcjzR2_Kangxiong.png"; //中断抗雄治疗
    } else if (GCase1().zlfaR2RightSelectedIndex == 4) {
        imageName = @"bcjzR2_Neifenmi.png"; //二线内分泌
    }

    _bcjzImage.image = [UIImage imageNamed:imageName];
}
@end
