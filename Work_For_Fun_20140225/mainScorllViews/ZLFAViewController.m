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
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *rightView1;
@property (weak, nonatomic) IBOutlet UIView *rightView2;
@property (weak, nonatomic) IBOutlet UIView *rightViw2SubView;
@property (weak, nonatomic) IBOutlet UIImageView *rightView2SubImageView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *fuzhuButtonCollection;
@property (weak, nonatomic) IBOutlet UISegmentedControl *right2FuzhuSegmentControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *right2ChixuJianxieSegmentControl;


@property (assign, nonatomic) BOOL shouldShowLeft;
@property (assign, nonatomic) BOOL shouldToNext;
@property (assign, nonatomic) BOOL showFuzhu;
@property (assign, nonatomic) BOOL section2FirtLanuch;
@property (assign, nonatomic) BOOL showFuzhuDetail;

- (IBAction)zlfaLeftSegmentedChanged:(UISegmentedControl *)sender;
- (IBAction)zlfaRightSegmentChanged:(UISegmentedControl *)sender;
- (IBAction)fhuSubClickButton:(UIButton *)sender;
- (IBAction)confirmClick:(UIButton *)sender;
- (IBAction)clickAddFuzhuButton:(UIButton *)sender;
- (IBAction)clickRightView2Button:(UIButton *)sender;
- (IBAction)rightView2SegmentControlerValueChange:(UISegmentedControl *)sender;

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
    _showFuzhuDetail = NO;

    _rightView1.hidden = NO;
    _rightView2.hidden = YES;

    self.pickViewSourceDictionary = @{
                                      @"1011": @[@"", @"达菲林 3月剂型", @"达菲林 1月剂型", @"戈舍瑞林", @"亮丙瑞林"],
                                      @"1012": @[@"", @"比卡鲁胺", @"氟他胺"],
                                      @"1013": @[@"", @"达菲林 3月剂型", @"达菲林 1月剂型", @"戈舍瑞林", @"亮丙瑞林"],
                                      @"1023": @[@"", @"比卡鲁胺", @"氟他胺"],
                                      //辅助
                                      @"101_2": @[@"", @"即刻", @"生化复发"],
                                      @"102_2": @[@"", @"达菲林 3月剂型", @"达菲林 1月剂型", @"戈舍瑞林", @"亮丙瑞林"],
                                      @"101_3": @[@"", @"即刻", @"生化复发"],
                                      @"102_3": @[@"", @"比卡鲁胺", @"氟他胺"],
                                      @"101_4": @[@"", @"即刻", @"生化复发"],
                                      @"102_4": @[@"", @"达菲林 3月剂型", @"达菲林 1月剂型", @"戈舍瑞林", @"亮丙瑞林"],
                                      @"103_4": @[@"", @"比卡鲁胺", @"氟他胺"]
                                      };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)zlfaLeftSegmentedChanged:(UISegmentedControl *)sender
{
    if (_showFuzhu) {
        BOOL fuzhuEnable = sender.selectedSegmentIndex == 0 ? NO : YES;
        if (sender.tag == 3) {
            _right2FuzhuSegmentControl.enabled = fuzhuEnable;
            GInstance().globalData.zlfaFuzhuOrZhaoShe = fuzhuEnable ? @"" : @"W";
        }
    } else {
        if (sender.selectedSegmentIndex == 0) {
            for (UISegmentedControl *segmentedControl in _zlfaLeftSegmentedCollection) {
                if (segmentedControl.selectedSegmentIndex == 0 && segmentedControl != sender) {
                    segmentedControl.selectedSegmentIndex = 1;
                }
            }
            if (sender.tag == 3 || sender.tag == 4 || sender.tag == 5) {
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

- (IBAction)zlfaRightSegmentChanged:(UISegmentedControl *)sender
{
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
            if (segmentedControl.tag == 3 || segmentedControl.tag == 4 || segmentedControl.tag == 5) {
                segmentedControl.enabled = segEnabled;
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
    if (![self checkValues]) {
        return;
    }

    [[[UIAlertView alloc] initWithTitle:nil
                                message:@"治疗方案确认后不能修改!"
                       cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{

    }]
                       otherButtonItems:[RIButtonItem itemWithLabel:@"确认" action:^{
        if (GInstance().globalData.zlfaLeftSelectedIndex == 5) {
            if ([_scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
                [_scrollViewDelegate didClickConfirmButton:sender];
            }
        } else {
            if (_shouldToNext) {
                if ([_scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
                    [_scrollViewDelegate didClickConfirmButton:sender];
                }
            } else {
                if (_showFuzhu) {
                    [self transitionToSectionThree];
                } else {
                    [self transitionToSectionTwo];
                }
            }
        }
    }], nil] show];
}

- (IBAction)clickAddFuzhuButton:(UIButton *)sender
{
    _showFuzhu = YES;
    _shouldToNext = NO;
    _rightView2.hidden = NO;
    _rightView1.hidden = YES;

    for (UISegmentedControl *segmentedControl in _zlfaLeftSegmentedCollection) {
        segmentedControl.enabled = NO;
        if (segmentedControl.selectedSegmentIndex != 0 && segmentedControl.tag == 3) {
            segmentedControl.enabled = YES;
            for (UISegmentedControl *segmentedControl2 in _zlfaLeftSegmentedCollection) {
                if (segmentedControl2.selectedSegmentIndex == 0 && segmentedControl2.tag == 4) {
                    segmentedControl.enabled = NO;
                    break;
                }
            }
            if (segmentedControl.enabled && GInstance().globalData.zlfaRightSelectedIndex > 0) {
                segmentedControl.enabled = NO;
            }
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

- (IBAction)clickRightView2Button:(UIButton *)sender
{
    for (UIButton *button in _fuzhuButtonCollection) {
        if (sender == button) {
            sender.selected = YES;
        } else {
            button.selected = NO;
        }
    }
    GInstance().globalData.zlfaFuzhuSelectedIndex = sender.tag - 200;
}

- (IBAction)rightView2SegmentControlerValueChange:(UISegmentedControl *)sender
{
    if (sender == _right2FuzhuSegmentControl) {
        if (sender.selectedSegmentIndex == 0) {
            _right2ChixuJianxieSegmentControl.hidden = NO;
            for (UISegmentedControl *segmentControl in _zlfaLeftSegmentedCollection) {
                if (segmentControl.tag == 3) {
                    segmentControl.enabled = NO;
                }
            }
            GInstance().globalData.zlfaFuzhuOrZhaoShe = @"F";
        } else {
            _right2ChixuJianxieSegmentControl.hidden = YES;
            _rightViw2SubView.hidden = YES;
            _right2ChixuJianxieSegmentControl.selectedSegmentIndex = -1;
            for (UIButton *button in _fuzhuButtonCollection) {
                button.selected = NO;
            }

            if ((GInstance().globalData.zlfaLeftSelectedIndex == 1 ||
                 GInstance().globalData.zlfaLeftSelectedIndex == 2) &&
                GInstance().globalData.zlfaRightSelectedIndex == 0) {
                for (UISegmentedControl *segmentControl in _zlfaLeftSegmentedCollection) {
                    if (segmentControl.tag == 3) {
                        segmentControl.enabled = YES;
                    }
                }
            }
            GInstance().globalData.zlfaFuzhuOrZhaoShe = @"";
            GInstance().globalData.zlfaFuzhuType = @"";
            GInstance().globalData.zlfaFuzhuSelectedIndex = 0;
            
        }
    } else if (sender == _right2ChixuJianxieSegmentControl) {
        _rightViw2SubView.hidden = NO;
        UIViewAnimationOptions option;
        if (sender.selectedSegmentIndex == 0) {
            _rightView2SubImageView.image = [UIImage imageNamed:@"zlfaBG2Right2.png"];
            for (UIButton *button in _fuzhuButtonCollection) {
                if (button.tag == 204) {
                    button.hidden = NO;
                }
                button.selected = NO;
            }
            option = UIViewAnimationOptionTransitionFlipFromLeft;
            GInstance().globalData.zlfaFuzhuType = @"C";
        } else {
            _rightView2SubImageView.image = [UIImage imageNamed:@"zlfaBG2Right3.png"];
            for (UIButton *button in _fuzhuButtonCollection) {
                if (button.tag == 204) {
                    button.hidden = YES;
                }
                button.selected = NO;
            }
            option = UIViewAnimationOptionTransitionFlipFromRight;
            GInstance().globalData.zlfaFuzhuType = @"J";
        }
        [UIView transitionWithView:_rightViw2SubView
                          duration:0.8
                           options:option | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                        animations:^{
                            _fuzhuSubView.hidden = NO;
                        }
                        completion:^(BOOL finished){
                        }];
    }
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

    if (_showFuzhu) {
        BOOL isWaiZhaoSheSelected = NO;
        BOOL isFuZhuSelected = NO;
        for (UISegmentedControl *segmentControl in _zlfaLeftSegmentedCollection) {
            if (segmentControl.selectedSegmentIndex == 0 && segmentControl.tag == 3) {
                isWaiZhaoSheSelected = YES;
                break;
            }
        }
        isFuZhuSelected = _right2FuzhuSegmentControl.selectedSegmentIndex == 0 ? YES : NO;

        if (isFuZhuSelected) {
            BOOL buttonSelected = NO;
            for (UIButton *button in _fuzhuButtonCollection) {
                if (button.isSelected) {
                    buttonSelected = YES;
                    break;
                }
            }
            if (!buttonSelected) {
                [GInstance() showInfoMessage:@"请完成治疗方案"];
                return NO;
            }
        }
    }

    if (_showFuzhuDetail) {
        NSUInteger keyInt;
        BOOL checkResult =  YES;
        if ([GInstance().globalData.zlfaFuzhuType isEqualToString:@"C"]) {
            keyInt = GInstance().globalData.zlfaFuzhuSelectedIndex;
        } else {
            keyInt = GInstance().globalData.zlfaFuzhuSelectedIndex + 1;
        }
        if (keyInt == 2 || keyInt == 3) {
            checkResult = (GInstance().globalData.zlfaFuzhuYaoWuSeg1.length > 0) &&
                          (GInstance().globalData.zlfaFuzhuYaoWuSeg2.length > 0);
        } else if (keyInt == 4){
            checkResult = (GInstance().globalData.zlfaFuzhuYaoWuSeg1.length > 0) &&
                          (GInstance().globalData.zlfaFuzhuYaoWuSeg2.length > 0) &&
                          (GInstance().globalData.zlfaFuzhuYaoWuSeg3.length > 0);
        }
        if (!checkResult) {
            [GInstance() showInfoMessage:@"请完成治疗方案"];
            return NO;
        }
    }

    if (GInstance().globalData.zlfaRightSelectedIndex > 0 && _section2FirtLanuch) {
        NSUInteger keyInt;
        BOOL checkResult = YES;
        keyInt = GInstance().globalData.zlfaRightSelectedIndex;
        if (keyInt == 1 || keyInt == 2) {
            checkResult = GInstance().globalData.zlfaXinFuZhuYaoWuSeg1.length > 0 ? YES : NO;
        } else {
            checkResult = (GInstance().globalData.zlfaXinFuZhuYaoWuSeg1.length > 0) &&
            (GInstance().globalData.zlfaXinFuZhuYaoWuSeg2.length > 0);
        }
        if (!checkResult) {
            [GInstance() showInfoMessage:@"请完成治疗方案"];
            return NO;
        }
    }

    return YES;
}

- (void)transitionToSectionTwo
{
    NSString *imageName = nil;
    _section2FirtLanuch = NO;
    if (GInstance().globalData.zlfaRightSelectedIndex > 0) {
        if (_shouldShowLeft) {
            if (GInstance().globalData.zlfaLeftSelectedIndex > 0 && GInstance().globalData.zlfaLeftSelectedIndex < 5) {
                _section2Picker1.hidden = YES;
                _section2Picker2.hidden = YES;
                _section2Picker3.hidden = YES;
                imageName = [NSString stringWithFormat:@"zlfaSection2LeftBG_%ld.png", GInstance().globalData.zlfaLeftSelectedIndex];
            }
            _shouldToNext = YES;
        } else {
            if (GInstance().globalData.zlfaRightSelectedIndex == 1 || GInstance().globalData.zlfaRightSelectedIndex == 2) {
                _section2Picker1.hidden = NO;
                _section2Picker1.frame = CGRectMake(327.0f, 149.0f, 200.0f, 216.0f);
                [_section2Picker1 selectRow:0 inComponent:0 animated:NO];
                [_section2Picker1 reloadAllComponents];
                _section2Picker2.hidden = YES;
                _section2Picker3.hidden = YES;

                imageName = [NSString stringWithFormat:@"zlfaSection2BG_%ld.png", GInstance().globalData.zlfaRightSelectedIndex];
            } else if (GInstance().globalData.zlfaRightSelectedIndex == 3) {
                _section2Picker1.hidden = NO;
                _section2Picker1.frame = CGRectMake(157.0f, 149.0f, 200.0f, 216.0f);
                [_section2Picker1 selectRow:0 inComponent:0 animated:NO];
                [_section2Picker1 reloadAllComponents];
                _section2Picker2.hidden = NO;
                _section2Picker2.frame = CGRectMake(457.0f, 149.0f, 200.0f, 216.0f);
                [_section2Picker2 selectRow:0 inComponent:0 animated:NO];
                [_section2Picker2 reloadAllComponents];
                _section2Picker3.hidden = YES;

                imageName = [NSString stringWithFormat:@"zlfaSection2BG_%ld.png", GInstance().globalData.zlfaRightSelectedIndex];
            }
            _section2FirtLanuch = YES;
            _shouldShowLeft = YES;
        }
    } else {
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
                       options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionShowHideTransitionViews
                    completion:^(BOOL finished) {
                        _section1View.hidden = YES;

                        if (GInstance().globalData.zlfaRightSelectedIndex > 0) {
                            if (_shouldShowLeft && !_section2FirtLanuch) {
                                _titleLabel.text = @"治疗方案记录";
                                _addFuzhuButton.hidden = NO;
                            } else {
                                _titleLabel.text = @"选择具体治疗方法";
                            }
                        } else {
                            _titleLabel.text = @"治疗方案记录";
                            _addFuzhuButton.hidden = NO;
                        }
                    }];
}

- (void)transitionToSectionThree
{
    _showFuzhuDetail = YES;
    _shouldToNext = YES;

    NSString *imageName;
    NSString *titleString;
    if ([GInstance().globalData.zlfaFuzhuOrZhaoShe isEqualToString:@"F"]) {
        NSUInteger iamgeIndex;
        if ([GInstance().globalData.zlfaFuzhuType isEqualToString:@"C"]) {
            iamgeIndex = GInstance().globalData.zlfaFuzhuSelectedIndex;
        } else {
            iamgeIndex = GInstance().globalData.zlfaFuzhuSelectedIndex + 1;
        }
        if (iamgeIndex == 2) {
            _section2Picker1.hidden = NO;
            _section2Picker1.frame = CGRectMake(265.0f, -10.0f, 120.0f, 216.0f);
            [_section2Picker1 selectRow:0 inComponent:0 animated:NO];
            [_section2Picker1 reloadAllComponents];
            _section2Picker2.hidden = NO;
            _section2Picker2.frame = CGRectMake(327.0f, 179.0f, 200.0f, 216.0f);
            [_section2Picker2 selectRow:0 inComponent:0 animated:NO];
            [_section2Picker2 reloadAllComponents];
            _section2Picker3.hidden = YES;
        } else if (iamgeIndex == 3) {
            _section2Picker1.hidden = NO;
            _section2Picker1.frame = CGRectMake(265.0f, -10.0f, 120.0f, 216.0f);
            [_section2Picker1 selectRow:0 inComponent:0 animated:NO];
            [_section2Picker1 reloadAllComponents];
            _section2Picker2.hidden = NO;
            _section2Picker2.frame = CGRectMake(327.0f, 179.0f, 200.0f, 216.0f);
            [_section2Picker2 selectRow:0 inComponent:0 animated:NO];
            [_section2Picker2 reloadAllComponents];
            _section2Picker3.hidden = YES;
        } else if (iamgeIndex == 4) {
            _section2Picker1.hidden = NO;
            _section2Picker1.frame = CGRectMake(265.0f, -10.0f, 120.0f, 216.0f);
            [_section2Picker1 selectRow:0 inComponent:0 animated:NO];
            [_section2Picker1 reloadAllComponents];
            _section2Picker2.hidden = NO;
            _section2Picker2.frame = CGRectMake(157.0f, 179.0f, 200.0f, 216.0f);
            [_section2Picker2 selectRow:0 inComponent:0 animated:NO];
            [_section2Picker2 reloadAllComponents];
            _section2Picker3.hidden = NO;
            _section2Picker3.frame = CGRectMake(457.0, 179.0f, 200.0f, 216.0f);
            [_section2Picker3 selectRow:0 inComponent:0 animated:NO];
            [_section2Picker3 reloadAllComponents];

        } else {
            _section2Picker1.hidden = YES;
            _section2Picker2.hidden = YES;
            _section2Picker3.hidden = YES;
        }
        titleString = @"选择具体治疗方法";
        imageName = [NSString stringWithFormat:@"zlfaFuzhuDetail_%lu.png", iamgeIndex];
    } else {
        imageName = @"zlfaSection2LeftBG_3.png";
        titleString = @"";
    }



    _section2ImageBG.image = [UIImage imageNamed:imageName];
    [UIView transitionFromView:_section1View
                        toView:_section2View
                      duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionShowHideTransitionViews
                    completion:^(BOOL finished) {
                        _titleLabel.text = titleString;
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
    NSArray *pickViewSource = [self.pickViewSourceDictionary objectForKey:[self dicKeyString:pickerView]];
    return pickViewSource.count;
}

#pragma mark -
#pragma mark UIPickerView Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *pickViewSource = [self.pickViewSourceDictionary objectForKey:[self dicKeyString:pickerView]];
    return pickViewSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *dicKeyString = [self dicKeyString:pickerView];
    NSString *selectedString = [self.pickViewSourceDictionary objectForKey:dicKeyString][row];

    if ([dicKeyString isEqualToString:@"1011"] ||
        [dicKeyString isEqualToString:@"1012"] ||
        [dicKeyString isEqualToString:@"1013"]) {
        GInstance().globalData.zlfaXinFuZhuYaoWuSeg1 = selectedString;
    } else if ([dicKeyString isEqualToString:@"1023"]) {
        GInstance().globalData.zlfaXinFuZhuYaoWuSeg2 = selectedString;
    } else if ([dicKeyString isEqualToString:@"101_2"] ||
               [dicKeyString isEqualToString:@"101_3"] ||
               [dicKeyString isEqualToString:@"101_4"]) {
        GInstance().globalData.zlfaFuzhuYaoWuSeg1 = selectedString;
    } else if ([dicKeyString isEqualToString:@"102_2"] ||
               [dicKeyString isEqualToString:@"102_3"] ||
               [dicKeyString isEqualToString:@"102_4"]) {
        GInstance().globalData.zlfaFuzhuYaoWuSeg2 = selectedString;
    } else if ([dicKeyString isEqualToString:@"103_4"]) {
        GInstance().globalData.zlfaFuzhuYaoWuSeg3 = selectedString;
    }
}

- (NSString *)dicKeyString:(UIPickerView *)pickerView
{
    NSString *dicKeyString;
    if (_showFuzhuDetail) {
        NSUInteger keyInt;
        if ([GInstance().globalData.zlfaFuzhuType isEqualToString:@"C"]) {
            keyInt = GInstance().globalData.zlfaFuzhuSelectedIndex;
        } else {
            keyInt = GInstance().globalData.zlfaFuzhuSelectedIndex + 1;
        }
        dicKeyString = [NSString stringWithFormat:@"%ld_%lu",(long)pickerView.tag, keyInt];
    } else {
        dicKeyString = [NSString stringWithFormat:@"%ld%lu",(long)pickerView.tag, (unsigned long)GInstance().globalData.zlfaRightSelectedIndex];
    }
    return dicKeyString;
}

#pragma mark - Reload Data
- (void)reloadViewDataForR2
{

}
@end
