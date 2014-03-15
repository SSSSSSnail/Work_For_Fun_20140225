//
//  ZLFAViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 15/3/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "ZLFAViewController.h"

@interface ZLFAViewController ()

@property (strong, nonatomic) IBOutletCollection(UISegmentedControl) NSArray *zlfaLeftSegmentedCollection;
- (IBAction)zlfaLeftSegmentedChanged:(UISegmentedControl *)sender;
- (IBAction)zlfaRightSegmentChanged:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *danyiSegmented;
@property (weak, nonatomic) IBOutlet UISegmentedControl *fuzhuSegmented;
@property (weak, nonatomic) IBOutlet UIView *fuzhuSubView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *fuzhuSubCollection;
- (IBAction)fhuSubClickButton:(UIButton *)sender;

@end

@implementation ZLFAViewController

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

- (IBAction)zlfaLeftSegmentedChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        for (UISegmentedControl *segmentedControl in _zlfaLeftSegmentedCollection) {
            if (segmentedControl.selectedSegmentIndex == 0 && segmentedControl != sender) {
                segmentedControl.selectedSegmentIndex = 1;
            }
        }
        if (sender.tag == 5) {

            _fuzhuSegmented.enabled = NO;
        } else {
            _fuzhuSegmented.enabled = YES;
        }
        _danyiSegmented.enabled = NO;
    } else {
        if (_fuzhuSegmented.selectedSegmentIndex == 1) {
            _danyiSegmented.enabled = YES;
        }
        _fuzhuSegmented.enabled = YES;
    }
}

- (IBAction)zlfaRightSegmentChanged:(UISegmentedControl *)sender {
    if (sender.tag == 11) {
        BOOL segEnabled = sender.selectedSegmentIndex == 0 ? NO : YES;
        for (UISegmentedControl *segmentedControl in _zlfaLeftSegmentedCollection) {
            segmentedControl.enabled = segEnabled;
        }
        _fuzhuSegmented.enabled = segEnabled;
        if (!segEnabled) {
            [GInstance() showInfoMessage:@"根据患者情况，不适合单一内分泌治疗"];
        }
    }

    if (sender.tag == 12) {
        BOOL segEnabled = sender.selectedSegmentIndex == 0 ? NO : YES;
        ((UISegmentedControl *)_zlfaLeftSegmentedCollection[4]).enabled = segEnabled;

        if (segEnabled) {
            BOOL isLeftSelected = NO;
            for (UISegmentedControl *segmentedControl in _zlfaLeftSegmentedCollection) {
                if (segmentedControl.selectedSegmentIndex == 0) {
                    isLeftSelected = YES;
                    break;
                }
            }
            _danyiSegmented.enabled = isLeftSelected;
        }

        if (!segEnabled) {
            [UIView transitionWithView:_fuzhuSubView
                              duration:0.8
                               options:UIViewAnimationOptionTransitionFlipFromTop | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                            animations:^{
                                _fuzhuSubView.hidden = NO;
                            }
                            completion:^(BOOL finished){
                            }];
        } else {
            [UIView transitionWithView:_fuzhuSubView
                              duration:0.8
                               options:UIViewAnimationOptionTransitionFlipFromBottom | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                            animations:^{
                                _fuzhuSubView.hidden = YES;
                            }
                            completion:^(BOOL finished){
                            }];
        }
    }
}

- (IBAction)fhuSubClickButton:(UIButton *)sender {
    for (UIButton *button in _fuzhuSubCollection) {
        if (button == sender) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
    }
}
@end
