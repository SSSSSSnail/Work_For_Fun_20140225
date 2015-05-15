//
//  HZQKC2ViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 27/7/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "HZQKC3ViewController.h"

@interface HZQKC3ViewController ()

- (IBAction)confirmClick:(UIButton *)sender;

@end

@implementation HZQKC3ViewController

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

- (void)loadFromGData
{

}

@end
