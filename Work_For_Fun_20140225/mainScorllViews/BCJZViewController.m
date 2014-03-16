//
//  BCJZViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 15/3/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "BCJZViewController.h"

static NSString *originDateString = @"2000/1/18 星期五";
static NSString *oneYearLater            = @"2001/1/18 星期四";
static NSString *twoYearLater            = @"2002/1/18 星期五";
static NSString *twoYearNinMonthLater    = @"2002/10/18 星期五";
static NSString *twoYearSixMonthLater    = @"2002/7/18 星期四";
static NSString *twoYearsThreeMonthLater = @"2002/4/18 星期四";
static NSString *sixMonthCase1           = @"2001/7/18 星期三";
static NSString *sixMonthCase2           = @"2002/7/18 星期四";
static NSString *sixMonthCase3           = @"2003/4/18 星期五";
static NSString *sixMonthCase4           = @"2003/1/18 星期六";
static NSString *sixMonthCase5           = @"2002/10/18 星期五";


typedef NS_ENUM(NSInteger, BCJZResult) {
    ZDJC             = 1, //M1 主动监测
    GZS              = 2, //M2 根治术
    GZSFZNFMCX       = 3, //M3 根治术+辅助 持续
    GZSFZNFMJX       = 4, //M3 根治术+辅助 间歇
    XFZNFMGZS        = 5, //M4 新辅助+根治术
    XFZNFMGZSFZNFMCX = 6, //M5 新辅助+根治术+辅助 持续
    XFZNFMGZSFZNFMJX = 7, //M5 新辅助+根治术+辅助 间歇
    GZSFL            = 8, //M6 根治术+放疗
    FL               = 9, //M7 放疗
    FLFZNFMCX        = 10,//M8 放疗+辅助 持续
    FLFZNFMJX        = 11,//M8 放疗+辅助 间歇
};

@interface BCJZViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bcjzImage;
@property (assign, nonatomic) BCJZResult bcjzResult;
@property (weak, nonatomic) IBOutlet UILabel *datatimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *datetimeLabel;
@property (strong, nonatomic) NSDate *bcjzDate;

@end

@implementation BCJZViewController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    _bcjzResult = ZDJC;
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self changeLabelText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //1 结束
    //2 时间
    //3 更改时间
    //4 时间表
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmClick:(UIButton *)sender
{
    _bcjzResult ++;
    if (_bcjzResult > 11) {
        _bcjzResult = 1;
    }
    
    
    NSString *imageName = [NSString stringWithFormat:@"bcjz%ld@2x.png",_bcjzResult];
    _bcjzImage.image = [UIImage imageNamed:imageName];
    [self changeLabelText];
}

- (void)changeLabelText
{
    switch (_bcjzResult) {
        case ZDJC:      //主动监测
        {
            _datetimeLabel.text = oneYearLater;
        }
            break;
        case GZS:       //M2 根治术
        case GZSFL:     //M6 根治术+放疗
        case FL:        //M7 放疗
        {
            _datetimeLabel.text = twoYearLater;
        }
            break;
        case GZSFZNFMCX: //M3 根治术+辅助 持续
        case GZSFZNFMJX: //M3 根治术+辅助 间歇
        case XFZNFMGZSFZNFMCX: //M5 新辅助+根治术+辅助 持续
        case XFZNFMGZSFZNFMJX: //M5 新辅助+根治术+辅助 间歇
        {
            _datetimeLabel.text = twoYearNinMonthLater;
        }
            break;
        case XFZNFMGZS: //M4 新辅助+根治术
        {
            _datetimeLabel.text = twoYearSixMonthLater;
        }
            break;
        case FLFZNFMCX: //M8 放疗+辅助 持续
        case FLFZNFMJX: //M8 放疗+辅助 间歇
        {
            _datetimeLabel.text = twoYearsThreeMonthLater;
        }
            break;
        default:
            break;
    }
}

@end
