//
//  BCJZC2ViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 27/7/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "BCJZC3ViewController.h"

@interface BCJZC3ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bcjzContentImageView;

- (IBAction)confirmClick:(UIButton *)sender;

@end

@implementation BCJZC3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmClick:(UIButton *)sender
{
    if ([self.scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
        [self.scrollViewDelegate didClickConfirmButton:sender];
    }
}

- (void)refresh:(NSUInteger)mNumber
{
//    NSUInteger lastNumber = 0;
//    if (mNumber == 3 || mNumber == 5) {
//        lastNumber = GCase3().zlfaFuzhuChixuJianxieSelectedIndex;
//    }
//    if (mNumber == 8 || mNumber == 9) {
//        lastNumber = GCase3().zlfaChixuJianxieSelectedIndex;
//    }
    _bcjzContentImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"c3M%@", @(mNumber)]];
}

- (void)refresh:(NSUInteger)mNumber sNumber:(NSUInteger)sNumber
{
    NSString *mNumberString;
    if (mNumber < 3 || mNumber > 5) {
        mNumberString = [NSString stringWithFormat:@"%ld", (long)mNumber];
    } else {
        mNumberString = @"3-5";
    }
    NSMutableString *imageNameString = [NSMutableString stringWithFormat:@"M%@S%ld", mNumberString, (long)sNumber];
    if (GCase3().zlfaChixuJianxieNeifenSelectedIndex > 0) {
        [imageNameString appendString:[NSString stringWithFormat:@"-%ld", (long)GCase3().zlfaChixuJianxieNeifenSelectedIndex]];
    }
    NSLog(@"%@", imageNameString);
    _bcjzContentImageView.image = [UIImage imageNamed:imageNameString];
}

- (void)refresh
{
//    NSMutableString *imageNameString = [NSMutableString stringWithString:@"c2bcjz3_"];
//    if (GCase3().zlfa3GutongSelectedIndex == 1) {
//        [imageNameString appendString:@"Y"];
//    } else {
//        [imageNameString appendString:@"N"];
//    }
//    [imageNameString appendFormat:@"_%ld", (long)GCase3().zlfa3SegmentSelectedIndex];
//
//    NSLog(@"%@", imageNameString);
//    _bcjzContentImageView.image = [UIImage imageNamed:imageNameString];
}

@end
