//
//  ZLFAViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 15/3/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "ZLFAViewController.h"

@interface ZLFAViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutletCollection(UISegmentedControl) NSArray *zlfaLeftSegmentedCollection;
@property (weak, nonatomic) IBOutlet UISegmentedControl *danyiSegmented;
@property (weak, nonatomic) IBOutlet UISegmentedControl *fuzhuSegmented;
@property (weak, nonatomic) IBOutlet UIView *fuzhuSubView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *fuzhuSubCollection;
@property (weak, nonatomic) IBOutlet UIButton *addFuzhuButton;

@property (weak, nonatomic) IBOutlet UIView *section1View;
@property (weak, nonatomic) IBOutlet UIView *section2View;
@property (weak, nonatomic) IBOutlet UIImageView *section2ImageBG;
@property (weak, nonatomic) IBOutlet UIPickerView *section2Picker1;
@property (weak, nonatomic) IBOutlet UIPickerView *section2Picker2;
@property (weak, nonatomic) IBOutlet UIPickerView *section2Picker3;

@property (assign, nonatomic) BOOL shouldShowLeft;
@property (assign, nonatomic) BOOL shouldToNext;
@property (assign, nonatomic) BOOL showFuzhu;

- (IBAction)zlfaLeftSegmentedChanged:(UISegmentedControl *)sender;
- (IBAction)zlfaRightSegmentChanged:(UISegmentedControl *)sender;
- (IBAction)fhuSubClickButton:(UIButton *)sender;
- (IBAction)confirmClick:(UIButton *)sender;
- (IBAction)clickAddFuzhuButton:(UIButton *)sender;

@property (strong, nonatomic) NSDictionary *pickViewSourceDictionary;

@end

@implementation ZLFAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _titleLabel.text = @"选择治疗方案";
    _titleLabel.font = [UIFont miscrosoftYaHeiFontWithSize:24.0f];
    _titleLabel.textColor = [UIColor colorWithRed:0.0f/255 green:109.0f/255 blue:108.0f/255 alpha:1];

    _shouldShowLeft = NO;
    _shouldToNext = NO;
    _showFuzhu = NO;

    self.pickViewSourceDictionary = @{
                                      @"1011": @[@"", @"比卡鲁胺", @"氟他胺"],
                                      @"1012": @[@"", @"达菲林 3月剂型", @"达菲林 1月剂型", @"戈舍瑞林", @"亮丙瑞林"],
                                      @"1013": @[@"", @"比卡鲁胺", @"氟他胺"],
                                      @"1023": @[@"", @"达菲林 3月剂型", @"达菲林 1月剂型", @"戈舍瑞林", @"亮丙瑞林"],
                                      };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)zlfaLeftSegmentedChanged:(UISegmentedControl *)sender {
    if (_showFuzhu) {

    } else {
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
            GInstance().globalData.zlfaLeftSelectedIndex = sender.tag;
        } else {
            if (_fuzhuSegmented.selectedSegmentIndex == 1) {
                _danyiSegmented.enabled = YES;
            }
            _fuzhuSegmented.enabled = YES;
            GInstance().globalData.zlfaLeftSelectedIndex = 0;
        }
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
        for (UISegmentedControl *segmentedControl in _zlfaLeftSegmentedCollection) {
            if (segmentedControl.tag == 5) {
                segmentedControl.enabled = segEnabled;
                break;
            }
        }

        if (segEnabled) {
            for (UISegmentedControl *segmentedControl in _zlfaLeftSegmentedCollection) {
                if (segmentedControl.selectedSegmentIndex == 0) {
                    segEnabled = NO;
                    break;
                }
            }
        }
        _danyiSegmented.enabled = segEnabled;

        if (sender.selectedSegmentIndex == 0) {
            [UIView transitionWithView:_fuzhuSubView
                              duration:0.8
                               options:UIViewAnimationOptionTransitionFlipFromTop | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                            animations:^{
                                _fuzhuSubView.hidden = NO;
                            }
                            completion:^(BOOL finished){
                            }];
        } else {
            GInstance().globalData.zlfaRightSelectedIndex = 0;
            for (UIButton *button in _fuzhuSubCollection) {
                if (button.isSelected) {
                    button.selected = NO;
                    break;
                }
            }
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

- (IBAction)fhuSubClickButton:(UIButton *)sender
{
    for (UIButton *button in _fuzhuSubCollection) {
        if (button == sender) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
    }
    GInstance().globalData.zlfaRightSelectedIndex = sender.tag - 20;
}

- (IBAction)confirmClick:(UIButton *)sender
{
//    if (![self checkValues]) {
//        return;
//    }
//
//    [[[UIAlertView alloc] initWithTitle:nil
//                                message:@"治疗方案确认后不能修改!"
//                       cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{
//
//    }]
//                       otherButtonItems:[RIButtonItem itemWithLabel:@"确认" action:^{
//        if (GInstance().globalData.zlfaLeftSelectedIndex == 5) {
//            NSLog(@"NEXT");
//        } else {
//            if (_shouldToNext) {
//                NSLog(@"NEXT");
//            } else {
//                [self transitionToSectionTwo];
//            }
//        }
//    }], nil] show];
    [_scrollViewDelegate didClickConfirmButton:sender];
}

- (IBAction)clickAddFuzhuButton:(UIButton *)sender
{
    _showFuzhu = YES;

    for (UISegmentedControl *segmentedControl in _zlfaLeftSegmentedCollection) {
        segmentedControl.enabled = NO;
        if (segmentedControl.selectedSegmentIndex !=0 && segmentedControl.tag == 3) {
            segmentedControl.enabled = YES;
        }
    }
    [UIView transitionFromView:_section2View
                        toView:_section1View
                      duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionShowHideTransitionViews
                    completion:^(BOOL finished) {
                        _section2View.hidden = YES;
                        _addFuzhuButton.hidden = YES;
                        _titleLabel.text = @"选择治疗方案";
                    }];
}

- (BOOL)checkValues
{
    if (_danyiSegmented.selectedSegmentIndex == 0) {
        [GInstance() showInfoMessage:@"根据患者情况，不适合单一内分泌治疗"];
        return NO;
    }

    BOOL isLeftSelected = NO;
    for (UISegmentedControl *segmentControl in _zlfaLeftSegmentedCollection) {
        if (segmentControl.selectedSegmentIndex == 0) {
            isLeftSelected = YES;
            break;
        }
    }
    if (!isLeftSelected) {
        [GInstance() showInfoMessage:@"请完成治疗方案"];
        return NO;
    }

    if (_fuzhuSegmented.selectedSegmentIndex == 0) {
        BOOL isButtonSelected = NO;
        for (UIButton *button in _fuzhuSubCollection) {
            if (button.isSelected) {
                isButtonSelected = YES;
                break;
            }
        }
        if (!isButtonSelected) {
            [GInstance() showInfoMessage:@"请完成治疗方案"];
            return NO;
        }
    }

    return YES;
}

- (void)transitionToSectionTwo
{
    NSString *imageName = nil;
    if (GInstance().globalData.zlfaRightSelectedIndex > 0) {
        if (_shouldShowLeft) {
            _titleLabel.text = @"治疗方案记录";
            _addFuzhuButton.hidden = NO;
            if (GInstance().globalData.zlfaLeftSelectedIndex > 0 && GInstance().globalData.zlfaLeftSelectedIndex < 5) {
                _section2Picker1.hidden = YES;
                _section2Picker2.hidden = YES;
                _section2Picker3.hidden = YES;
                imageName = [NSString stringWithFormat:@"zlfaSection2LeftBG_%ld.png", GInstance().globalData.zlfaLeftSelectedIndex];
            }
            _shouldToNext = YES;
        } else {
            _titleLabel.text = @"选择具体治疗方法";
            if (GInstance().globalData.zlfaRightSelectedIndex == 1 || GInstance().globalData.zlfaRightSelectedIndex == 2) {
                _section2Picker1.hidden = NO;
                _section2Picker1.frame = CGRectMake(327.0f, 149.0f, 200.0f, 216.0f);
                [_section2Picker1 reloadAllComponents];
                _section2Picker2.hidden = YES;
                _section2Picker3.hidden = YES;

                imageName = [NSString stringWithFormat:@"zlfaSection2BG_%ld.png", GInstance().globalData.zlfaRightSelectedIndex];
            } else if (GInstance().globalData.zlfaRightSelectedIndex == 3) {
                _section2Picker1.hidden = NO;
                _section2Picker1.frame = CGRectMake(157.0f, 149.0f, 200.0f, 216.0f);
                [_section2Picker1 reloadAllComponents];
                _section2Picker2.hidden = NO;
                _section2Picker2.frame = CGRectMake(457.0f, 149.0f, 200.0f, 216.0f);
                [_section2Picker2 reloadAllComponents];
                _section2Picker3.hidden = YES;

                imageName = [NSString stringWithFormat:@"zlfaSection2BG_%ld.png", GInstance().globalData.zlfaRightSelectedIndex];
            }
            _shouldShowLeft = YES;
        }
    } else {
        _titleLabel.text = @"治疗方案记录";
        _addFuzhuButton.hidden = NO;
        if (GInstance().globalData.zlfaLeftSelectedIndex > 0 && GInstance().globalData.zlfaLeftSelectedIndex < 5) {
            _section2Picker1.hidden = YES;
            _section2Picker2.hidden = YES;
            _section2Picker3.hidden = YES;
            imageName = [NSString stringWithFormat:@"zlfaSection2LeftBG_%ld.png", GInstance().globalData.zlfaLeftSelectedIndex];
        }
        _shouldToNext = YES;
    }

    _section2ImageBG.image = [UIImage imageNamed:imageName];
    [UIView transitionFromView:_section1View
                        toView:_section2View
                      duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionShowHideTransitionViews
                    completion:^(BOOL finished) {
                        _section1View.hidden = YES;
                    }];
}

#pragma mark -
#pragma mark UIPickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSLog(@"%@", [NSString stringWithFormat:@"%ld%lu", (long)pickerView.tag, (unsigned long)GInstance().globalData.zlfaRightSelectedIndex]);
    return ((NSArray *)_pickViewSourceDictionary[[NSString stringWithFormat:@"%ld%lu", (long)pickerView.tag, (unsigned long)GInstance().globalData.zlfaRightSelectedIndex]]).count;
}

#pragma mark -
#pragma mark UIPickerView Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *pickViewSource = [self.pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld%lu",(long)pickerView.tag, (unsigned long)GInstance().globalData.zlfaRightSelectedIndex]];
    return pickViewSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

}

@end
