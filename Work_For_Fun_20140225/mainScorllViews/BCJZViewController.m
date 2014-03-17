//
//  BCJZViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 15/3/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "BCJZViewController.h"

static NSString *originDateString = @"2000/1/18 星期五";
static NSString *oneYearLater            = @"2001/1/18 星期四"; //case 1
static NSString *twoYearLater            = @"2002/1/18 星期五"; //case 2
static NSString *twoYearNineMonthLater    = @"2002/10/18 星期五";//case 3
static NSString *twoYearSixMonthLater    = @"2002/7/18 星期四"; //case 4
static NSString *twoYearsThreeMonthLater = @"2002/4/18 星期四"; //case 5
static NSString *sixMonthCase1           = @"2001/7/18 星期三"; //one Year later
static NSString *sixMonthCase2           = @"2002/7/18 星期四"; // two year later
static NSString *sixMonthCase3           = @"2003/4/18 星期五"; //twoyear nine month later
static NSString *sixMonthCase4           = @"2003/1/18 星期六"; //twoyear six month later
static NSString *sixMonthCase5           = @"2002/10/18 星期五";//twoyear three monthlater




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
    switch (result) {
        case ZDJC:      //主动监测 case 1
        {
            _datetimeLabel.text = oneYearLater;
        }
            break;
        case GZS:       //M2 根治术
        case GZSFL:     //M6 根治术+放疗
        case FL:        //M7 放疗 case 2
        {
            _datetimeLabel.text = twoYearLater;
        }
            break;
        case GZSFZNFMCX: //M3 根治术+辅助 持续
        case GZSFZNFMJX: //M3 根治术+辅助 间歇
        case XFZNFMGZSFZNFMCX: //M5 新辅助+根治术+辅助 持续
        case XFZNFMGZSFZNFMJX: //M5 新辅助+根治术+辅助 间歇 case 3
        {
            _datetimeLabel.text = twoYearNineMonthLater;
        }
            break;
        case XFZNFMGZS: //M4 新辅助+根治术 case 4
        {
            _datetimeLabel.text = twoYearSixMonthLater;
        }
            break;
        case FLFZNFMCX: //M8 放疗+辅助 持续
        case FLFZNFMJX: //M8 放疗+辅助 间歇 case 5
        {
            _datetimeLabel.text = twoYearsThreeMonthLater;
        }
            break;
        default:
            break;
    }
}

//step 10
- (void)changedLabelTextInM2:(BCJZResult)result
{
    _datetimeLabel.hidden = NO;
    switch (result) {
        case ZDJC:      //主动监测 case 1 one year
        {
            _datetimeLabel.text = sixMonthCase1;
        }
            break;
        case GZS:       //M2 根治术
        case GZSFL:     //M6 根治术+放疗
        case FL:        //M7 放疗 // case 2 two year
        {
            _datetimeLabel.text = sixMonthCase2;
        }
            break;
        case GZSFZNFMCX: //M3 根治术+辅助 持续
        case GZSFZNFMJX: //M3 根治术+辅助 间歇
        case XFZNFMGZSFZNFMCX: //M5 新辅助+根治术+辅助 持续
        case XFZNFMGZSFZNFMJX: //M5 新辅助+根治术+辅助 间歇 // case 3 twoYearNinMonthLater
        {
            _datetimeLabel.text = sixMonthCase3;
        }
            break;
        case XFZNFMGZS: //M4 新辅助+根治术 // case 4 twoYearSixMonthLater
        {
            _datetimeLabel.text = sixMonthCase4;
        }
            break;
        case FLFZNFMCX: //M8 放疗+辅助 持续
        case FLFZNFMJX: //M8 放疗+辅助 间歇 // case 5 twoYearthreeMonthLater
        {
            _datetimeLabel.text = sixMonthCase5;
        }
            break;
        default:
            _datetimeLabel.hidden = YES;
            break;
    }
}

+ (BCJZMResult)mResultFromResult:(BCJZResult)result
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

@end
