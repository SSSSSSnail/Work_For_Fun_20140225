//
//  CoverViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 26/2/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "CoverViewController.h"

@interface CoverViewController ()

@end

@implementation CoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeup:)];
    swipeGes.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeGes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)swipeup:(UISwipeGestureRecognizer *)recognizer
{
    [self performSegueWithIdentifier:@"modalToSelectCase" sender:self];
}

@end
