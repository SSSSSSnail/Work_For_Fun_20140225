//
//  Cover2ViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 1/3/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "Cover2ViewController.h"

@interface Cover2ViewController ()

@end

@implementation Cover2ViewController

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
	UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeup:)];
    swipeGes.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeGes];

    [self performSelector:@selector(swipeup:) withObject:nil afterDelay:3.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)swipeup:(UISwipeGestureRecognizer *)recognizer
{
    [self modeToSelectCase];
}

- (void)modeToSelectCase
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(swipeup:) object:nil];
    [self performSegueWithIdentifier:@"modalToSelectCase" sender:self];
}


@end
