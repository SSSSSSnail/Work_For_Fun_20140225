//
//  BCJZViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 15/3/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "BCJZViewController.h"

typedef NS_ENUM(NSInteger, BCJZResult) {
    ZDJC             = 1,
    GZS              = 2,
    GZSFZNFMCX       = 3,
    GZSFZNFMJX       = 4,
    XFZNFMGZS        = 5,
    XFZNFMGZSFZNFMCX = 6,
    XFZNFMGZSFZNFMJX = 7,
    GZSFL            = 8,
    FL               = 9,
    FLFZNFMCX        = 10,
    FLFZNFMJX        = 11
};

@interface BCJZViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bcjzImage;
@property (assign, nonatomic) BCJZResult bcjzResult;
@property (weak, nonatomic) IBOutlet UILabel *datatimeLabel;

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
    NSDate *date = [NSDate date];
    
    NSString *imageName = [NSString stringWithFormat:@"bcjz%ld@2x.png",_bcjzResult];
    _bcjzImage.image = [UIImage imageNamed:imageName];
}

@end
