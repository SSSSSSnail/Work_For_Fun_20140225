//
//  HZQKViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 14/3/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "HZQKViewController.h"

@interface HZQKViewController ()

- (IBAction)confirmClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;

@end

@implementation HZQKViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
}

#pragma mark - Reload Data
- (void)reloadViewDataForR2
{

}

- (IBAction)confirmClick:(UIButton *)sender {
    if ([_scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
        [_scrollViewDelegate didClickConfirmButton:sender];
    }
}
@end
