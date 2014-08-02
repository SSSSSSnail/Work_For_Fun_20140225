//
//  ZLFAViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 15/3/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "ZLFAViewController.h"
#import "Case1Data.h"

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
@property (weak, nonatomic) IBOutlet UIView *rightViewR2;
@property (weak, nonatomic) IBOutlet UIImageView *rightView2SubImageView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *fuzhuButtonCollection;
@property (weak, nonatomic) IBOutlet UISegmentedControl *right2FuzhuSegmentControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *right2ChixuJianxieSegmentControl;


@property (assign, nonatomic) BOOL shouldShowLeft;
@property (assign, nonatomic) BOOL shouldToNext;
@property (assign, nonatomic) BOOL showFuzhu;
@property (assign, nonatomic) BOOL section2FirtLanuch;
@property (assign, nonatomic) BOOL showFuzhuDetail;
@property (assign, nonatomic) BOOL clickAddFuzhu;

//R2
@property (strong, nonatomic) IBOutletCollection(UISegmentedControl) NSArray *r2RightSegCollection;
@property (weak, nonatomic) IBOutlet UISegmentedControl *r2RightYaoWuSeg;
@property (assign, nonatomic) BOOL showR2Fuzhu;
@property (assign, nonatomic) BOOL showR2FuzhuDetail;

- (IBAction)zlfaLeftSegmentedChanged:(UISegmentedControl *)sender;
- (IBAction)zlfaRightSegmentChanged:(UISegmentedControl *)sender;
- (IBAction)fhuSubClickButton:(UIButton *)sender;
- (IBAction)confirmClick:(UIButton *)sender;
- (IBAction)clickAddFuzhuButton:(UIButton *)sender;
- (IBAction)clickRightView2Button:(UIButton *)sender;
- (IBAction)rightView2SegmentControlerValueChange:(UISegmentedControl *)sender;

//R2
- (IBAction)r2RightSegChangeValue:(UISegmentedControl *)sender;

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
    _showR2Fuzhu = NO;
    _showR2FuzhuDetail = NO;

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
                                      @"103_4": @[@"", @"比卡鲁胺", @"氟他胺"],
                                      //R2辅助
                                      @"101,2": @[@"", @"达菲林 3月剂型", @"达菲林 1月剂型", @"戈舍瑞林", @"亮丙瑞林"],
                                      @"101,3": @[@"", @"比卡鲁胺", @"氟他胺"],
                                      @"101,4": @[@"", @"达菲林 3月剂型", @"达菲林 1月剂型", @"戈舍瑞林", @"亮丙瑞林"],
                                      @"102,4": @[@"", @"比卡鲁胺", @"氟他胺"]
                                      };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)zlfaLeftSegmentedChanged:(UISegmentedControl *)sender
{
    if (_clickAddFuzhu && !((Case1Data *)GCase1()).fsStep2) {
        BOOL fuzhuEnable = sender.selectedSegmentIndex == 0 ? NO : YES;
        if (sender.tag == 3) {
            _right2FuzhuSegmentControl.enabled = fuzhuEnable;
            ((Case1Data *)GCase1()).zlfaFuzhuOrZhaoShe = fuzhuEnable ? @"" : @"W";
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
            GCase1().zlfaLeftSelectedIndex = sender.tag;
            if (GCase1().zlfaR2RightSelectedIndex != 0) {
                GCase1().zlfaR2RightSelectedIndex = 0;
                [self transitionR2AndRight];
            }
        } else {
            if (_fuzhuSegmented.selectedSegmentIndex == 1) {
                _danyiSegmented.enabled = YES;
            }
            _fuzhuSegmented.enabled = YES;
            GCase1().zlfaLeftSelectedIndex = 0;
        }
    }
    if (GCase1().fsStep2) {
        if (sender.selectedSegmentIndex == 0) {
            for (UISegmentedControl *segmentControl in _r2RightSegCollection) {
                segmentControl.selectedSegmentIndex = 1;
                _r2RightYaoWuSeg.hidden = YES;
                _r2RightYaoWuSeg.selectedSegmentIndex = -1;
            }
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
#ifndef SKIPREQUEST
            NSDictionary *parametersDictionary = @{@"step": @"4",
                                                   @"action": @"checknfm2",
                                                   @"subject_id": GCase1().subjectId,
                                                   @"group_id": GCase1().groupNumber};
            [GInstance() httprequestWithHUD:self.view
                             withRequestURL:STEPURL
                             withParameters:parametersDictionary
                                 completion:^(NSDictionary *jsonDic) {
                                     NSLog(@"responseJson: %@", jsonDic);
                                     if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){

                                     } else {
                                         if ([(NSString *)jsonDic[@"errcode"] isEqualToString:E1]) {
                                             [GInstance() showErrorMessage:@"服务器结果异常!"];
                                         }
                                     }
                                 }];
#endif
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
            GCase1().zlfaRightSelectedIndex = 0;
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
    GCase1().zlfaRightSelectedIndex = sender.tag - 20;
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
        if (GCase1().zlfaLeftSelectedIndex == 5) {
            if ([_scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
                [_scrollViewDelegate didClickConfirmButton:sender];
            }
        } else {
            if (_shouldToNext) {
                if ([_scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
                    [_scrollViewDelegate didClickConfirmButton:sender];
                }
            } else {
                if (_showFuzhu || _showR2Fuzhu) {
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
    _showFuzhu = NO;
    _shouldToNext = YES;
    _rightView2.hidden = NO;
    _rightView1.hidden = YES;
    _clickAddFuzhu = YES;

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
            if (segmentedControl.enabled && GCase1().zlfaRightSelectedIndex > 0) {
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
    GCase1().zlfaFuzhuSelectedIndex = sender.tag - 200;
}

- (IBAction)rightView2SegmentControlerValueChange:(UISegmentedControl *)sender
{
    if (sender == _right2FuzhuSegmentControl) {
        if (sender.selectedSegmentIndex == 0) {
            _right2ChixuJianxieSegmentControl.hidden = NO;
            if (!GCase1().isFSSetp2) {
                for (UISegmentedControl *segmentControl in _zlfaLeftSegmentedCollection) {
                    if (segmentControl.tag == 3) {
                        segmentControl.enabled = NO;
                    }
                }
                GCase1().zlfaFuzhuOrZhaoShe = @"F";
                _showFuzhu = YES;
                _shouldToNext = NO;
            }
        } else {
            _right2ChixuJianxieSegmentControl.hidden = YES;
            _rightViw2SubView.hidden = YES;
            _right2ChixuJianxieSegmentControl.selectedSegmentIndex = -1;
            for (UIButton *button in _fuzhuButtonCollection) {
                button.selected = NO;
            }

            if ((GCase1().zlfaLeftSelectedIndex == 1 ||
                 GCase1().zlfaLeftSelectedIndex == 2) &&
                GCase1().zlfaRightSelectedIndex == 0) {
                for (UISegmentedControl *segmentControl in _zlfaLeftSegmentedCollection) {
                    if (segmentControl.tag == 3) {
                        segmentControl.enabled = YES;
                    }
                }
            }
            if (!GCase1().isFSSetp2) {
                GCase1().zlfaFuzhuOrZhaoShe = @"";
                GCase1().zlfaFuzhuType = @"";
                GCase1().zlfaFuzhuSelectedIndex = 0;
                _showFuzhu = NO;
                _shouldToNext = YES;
            } else {
                GCase1().zlfaR2RightSelectedIndex = 0;
                [self transitionR2AndRight];
            }
        }
    } else if (sender == _right2ChixuJianxieSegmentControl) {
        _rightViw2SubView.hidden = NO;
        UIViewAnimationOptions option;
        GCase1().zlfaFuzhuSelectedIndex = 0;
        if (sender.selectedSegmentIndex == 0) {
            _rightView2SubImageView.image = [UIImage imageNamed:@"zlfaBG2Right2.png"];
            for (UIButton *button in _fuzhuButtonCollection) {
                if (button.tag == 204) {
                    button.hidden = NO;
                }
                button.selected = NO;
            }
            option = UIViewAnimationOptionTransitionFlipFromLeft;
            GCase1().zlfaFuzhuType = @"C";
        } else {
            _rightView2SubImageView.image = [UIImage imageNamed:@"zlfaBG2Right3.png"];
            for (UIButton *button in _fuzhuButtonCollection) {
                if (button.tag == 204) {
                    button.hidden = YES;
                }
                button.selected = NO;
            }
            option = UIViewAnimationOptionTransitionFlipFromRight;
            GCase1().zlfaFuzhuType = @"J";
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
    if (GCase1().isFSSetp2) {
        if (GCase1().r2Type == M1) {
            if (_showR2FuzhuDetail) {
                NSUInteger keyInt;
                BOOL checkResult =  YES;
                if ([GCase1().zlfaFuzhuType isEqualToString:@"C"]) {
                    keyInt = GCase1().zlfaFuzhuSelectedIndex;
                } else {
                    keyInt = GCase1().zlfaFuzhuSelectedIndex + 1;
                }
                if (keyInt == 2 || keyInt == 3) {
                    checkResult = GCase1().zlfaR2FuzhuYaoWuSeg1.length > 0 ? YES : NO;
                } else if (keyInt == 4){
                    checkResult = (GCase1().zlfaR2FuzhuYaoWuSeg1.length > 0) &&
                    (GCase1().zlfaR2FuzhuYaoWuSeg2.length > 0);
                }
                if (!checkResult) {
                    [GInstance() showInfoMessage:@"请完成治疗方案"];
                    return NO;
                }
            } else {
                BOOL selectedLeft = NO;
                for (UISegmentedControl *segmentControl in _zlfaLeftSegmentedCollection) {
                    if (segmentControl.selectedSegmentIndex == 0) {
                        selectedLeft = YES;
                        break;
                    }
                }
                if (!selectedLeft) {
                    if (GCase1().zlfaFuzhuSelectedIndex == 0) {
                        [GInstance() showInfoMessage:@"请完成治疗方案"];
                        return NO;
                    }
                }
            }
        } else if (GCase1().r2Type == M2) {
            if (_showR2FuzhuDetail) {
                NSUInteger keyInt;
                BOOL checkResult =  YES;
                if ([GCase1().zlfaFuzhuType isEqualToString:@"C"]) {
                    keyInt = GCase1().zlfaFuzhuSelectedIndex;
                } else {
                    keyInt = GCase1().zlfaFuzhuSelectedIndex + 1;
                }
                if (keyInt == 2 || keyInt == 3) {
                    checkResult = GCase1().zlfaR2FuzhuYaoWuSeg1.length > 0 ? YES : NO;
                } else if (keyInt == 4){
                    checkResult = (GCase1().zlfaR2FuzhuYaoWuSeg1.length > 0) &&
                    (GCase1().zlfaR2FuzhuYaoWuSeg2.length > 0);
                }
                if (!checkResult) {
                    [GInstance() showInfoMessage:@"请完成治疗方案"];
                    return NO;
                }
            } else {
                BOOL selectedLeft = NO;
                for (UISegmentedControl *segmentControl in _zlfaLeftSegmentedCollection) {
                    if ((segmentControl.selectedSegmentIndex == 0 && segmentControl.tag == 3) ||
                        (segmentControl.selectedSegmentIndex == 0 && segmentControl.tag == 4)) {
                        selectedLeft = YES;
                        break;
                    }
                }
                if (!selectedLeft) {
                    if (GCase1().zlfaFuzhuSelectedIndex == 0) {
                        [GInstance() showInfoMessage:@"请完成治疗方案"];
                        return NO;
                    }
                }
            }
        } else if (GCase1().r2Type == M3 ||
                   GCase1().r2Type == M4 ||
                   GCase1().r2Type == M5 ||
                   GCase1().r2Type == M8) {
            if (GCase1().zlfaR2RightSelectedIndex < 2 ||
                GCase1().zlfaR2RightSelectedIndex > 4){
                [GInstance() showInfoMessage:@"请完成治疗方案"];
                return NO;
            }
            if (GCase1().zlfaR2RightSelectedIndex == 4 &&
                GCase1().zlfaR2RightYaowuSelected.length == 0) {
                [GInstance() showInfoMessage:@"请完成治疗方案"];
                return NO;
            }
        } else if (GCase1().r2Type == M6) {
            if (GCase1().zlfaFuzhuSelectedIndex == 0) {
                [GInstance() showInfoMessage:@"请完成治疗方案"];
                return NO;
            }
            if (_showR2FuzhuDetail) {
                NSUInteger keyInt;
                BOOL checkResult =  YES;
                if ([GCase1().zlfaFuzhuType isEqualToString:@"C"]) {
                    keyInt = GCase1().zlfaFuzhuSelectedIndex;
                } else {
                    keyInt = GCase1().zlfaFuzhuSelectedIndex + 1;
                }
                if (keyInt == 2 || keyInt == 3) {
                    checkResult = GCase1().zlfaR2FuzhuYaoWuSeg1.length > 0 ? YES : NO;
                } else if (keyInt == 4){
                    checkResult = (GCase1().zlfaR2FuzhuYaoWuSeg1.length > 0) &&
                    (GCase1().zlfaR2FuzhuYaoWuSeg2.length > 0);
                }
                if (!checkResult) {
                    [GInstance() showInfoMessage:@"请完成治疗方案"];
                    return NO;
                }
            }
        } else if (GCase1().r2Type == M7) {
            if (_showR2FuzhuDetail) {
                NSUInteger keyInt;
                BOOL checkResult =  YES;
                if ([GCase1().zlfaFuzhuType isEqualToString:@"C"]) {
                    keyInt = GCase1().zlfaFuzhuSelectedIndex;
                } else {
                    keyInt = GCase1().zlfaFuzhuSelectedIndex + 1;
                }
                if (keyInt == 2 || keyInt == 3) {
                    checkResult = GCase1().zlfaR2FuzhuYaoWuSeg1.length > 0 ? YES : NO;
                } else if (keyInt == 4){
                    checkResult = (GCase1().zlfaR2FuzhuYaoWuSeg1.length > 0) &&
                    (GCase1().zlfaR2FuzhuYaoWuSeg2.length > 0);
                }
                if (!checkResult) {
                    [GInstance() showInfoMessage:@"请完成治疗方案"];
                    return NO;
                }
            } else {
                BOOL selectedLeft = NO;
                for (UISegmentedControl *segmentControl in _zlfaLeftSegmentedCollection) {
                    if ((segmentControl.selectedSegmentIndex == 0 && segmentControl.tag == 1) ||
                        (segmentControl.selectedSegmentIndex == 0 && segmentControl.tag == 2) ||
                        (segmentControl.selectedSegmentIndex == 0 && segmentControl.tag == 5)) {
                        selectedLeft = YES;
                        break;
                    }
                }
                if (!selectedLeft) {
                    if (GCase1().zlfaFuzhuSelectedIndex == 0) {
                        [GInstance() showInfoMessage:@"请完成治疗方案"];
                        return NO;
                    }
                }
            }
        }
    } else {
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
            if ([GCase1().zlfaFuzhuType isEqualToString:@"C"]) {
                keyInt = GCase1().zlfaFuzhuSelectedIndex;
            } else {
                keyInt = GCase1().zlfaFuzhuSelectedIndex + 1;
            }
            if (keyInt == 2 || keyInt == 3) {
                checkResult = (GCase1().zlfaFuzhuYaoWuSeg1.length > 0) &&
                (GCase1().zlfaFuzhuYaoWuSeg2.length > 0);
            } else if (keyInt == 4){
                checkResult = (GCase1().zlfaFuzhuYaoWuSeg1.length > 0) &&
                (GCase1().zlfaFuzhuYaoWuSeg2.length > 0) &&
                (GCase1().zlfaFuzhuYaoWuSeg3.length > 0);
            }
            if (!checkResult) {
                [GInstance() showInfoMessage:@"请完成治疗方案"];
                return NO;
            }
        }

        if (GCase1().zlfaRightSelectedIndex > 0 && _section2FirtLanuch) {
            NSUInteger keyInt;
            BOOL checkResult = YES;
            keyInt = GCase1().zlfaRightSelectedIndex;
            if (keyInt == 1 || keyInt == 2) {
                checkResult = GCase1().zlfaXinFuZhuYaoWuSeg1.length > 0 ? YES : NO;
            } else {
                checkResult = (GCase1().zlfaXinFuZhuYaoWuSeg1.length > 0) &&
                (GCase1().zlfaXinFuZhuYaoWuSeg2.length > 0);
            }
            if (!checkResult) {
                [GInstance() showInfoMessage:@"请完成治疗方案"];
                return NO;
            }
        }
    }


    return YES;
}

- (void)transitionToSectionTwo
{
    NSString *imageName = nil;
    _section2FirtLanuch = NO;
    if (GCase1().zlfaRightSelectedIndex > 0) {
        if (_shouldShowLeft) {
            if (GCase1().zlfaLeftSelectedIndex > 0 && GCase1().zlfaLeftSelectedIndex < 5) {
                _section2Picker1.hidden = YES;
                _section2Picker2.hidden = YES;
                _section2Picker3.hidden = YES;
                imageName = [NSString stringWithFormat:@"zlfaSection2LeftBG_%ld.png", (unsigned long)GCase1().zlfaLeftSelectedIndex];
            }
            _shouldToNext = YES;
        } else {
            if (GCase1().zlfaRightSelectedIndex == 1 || GCase1().zlfaRightSelectedIndex == 2) {
                _section2Picker1.hidden = NO;
                _section2Picker1.frame = CGRectMake(327.0f, 149.0f, 200.0f, 216.0f);
                [_section2Picker1 selectRow:0 inComponent:0 animated:NO];
                [_section2Picker1 reloadAllComponents];
                _section2Picker2.hidden = YES;
                _section2Picker3.hidden = YES;

                imageName = [NSString stringWithFormat:@"zlfaSection2BG_%ld.png", (unsigned long)GCase1().zlfaRightSelectedIndex];
            } else if (GCase1().zlfaRightSelectedIndex == 3) {
                _section2Picker1.hidden = NO;
                _section2Picker1.frame = CGRectMake(157.0f, 149.0f, 200.0f, 216.0f);
                [_section2Picker1 selectRow:0 inComponent:0 animated:NO];
                [_section2Picker1 reloadAllComponents];
                _section2Picker2.hidden = NO;
                _section2Picker2.frame = CGRectMake(457.0f, 149.0f, 200.0f, 216.0f);
                [_section2Picker2 selectRow:0 inComponent:0 animated:NO];
                [_section2Picker2 reloadAllComponents];
                _section2Picker3.hidden = YES;

                imageName = [NSString stringWithFormat:@"zlfaSection2BG_%ld.png", (unsigned long)GCase1().zlfaRightSelectedIndex];
            }
            _section2FirtLanuch = YES;
            _shouldShowLeft = YES;
        }
    } else {
        if (GCase1().zlfaLeftSelectedIndex > 0 && GCase1().zlfaLeftSelectedIndex < 5) {
            _section2Picker1.hidden = YES;
            _section2Picker2.hidden = YES;
            _section2Picker3.hidden = YES;
            imageName = [NSString stringWithFormat:@"zlfaSection2LeftBG_%ld.png", (unsigned long)GCase1().zlfaLeftSelectedIndex];
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

                        if (GCase1().zlfaRightSelectedIndex > 0) {
                            if (_shouldShowLeft && !_section2FirtLanuch) {
                                _titleLabel.text = @"治疗方案记录";
                                _addFuzhuButton.hidden = NO;
                            } else {
                                _titleLabel.text = @"选择具体治疗方法";
                            }
                        } else {
                            _titleLabel.text = @"治疗方案记录";
                            if (!GCase1().isFSSetp2) {
                                _addFuzhuButton.hidden = NO;
                            }
                        }
                    }];
}

- (void)transitionToSectionThree
{
    if (!GCase1().isFSSetp2) {
        _showFuzhuDetail = YES;
    } else {
        _showR2FuzhuDetail = YES;
    }
    _shouldToNext = YES;

    NSString *imageName;
    NSString *titleString;
    if ([GCase1().zlfaFuzhuOrZhaoShe isEqualToString:@"F"]) {
        NSUInteger iamgeIndex;
        if ([GCase1().zlfaFuzhuType isEqualToString:@"C"]) {
            iamgeIndex = GCase1().zlfaFuzhuSelectedIndex;
        } else {
            iamgeIndex = GCase1().zlfaFuzhuSelectedIndex + 1;
        }
        if (GCase1().isFSSetp2) {
            if (iamgeIndex == 2) {
                _section2Picker1.hidden = NO;
                _section2Picker1.frame = CGRectMake(327.0f, 179.0f, 200.0f, 216.0f);
                [_section2Picker1 selectRow:0 inComponent:0 animated:NO];
                [_section2Picker1 reloadAllComponents];
                _section2Picker2.hidden = YES;
                _section2Picker3.hidden = YES;
            } else if (iamgeIndex == 3) {
                _section2Picker1.hidden = NO;
                _section2Picker1.frame = CGRectMake(327.0f, 179.0f, 200.0f, 216.0f);
                [_section2Picker1 selectRow:0 inComponent:0 animated:NO];
                [_section2Picker1 reloadAllComponents];
                _section2Picker2.hidden = YES;
                _section2Picker3.hidden = YES;
            } else if (iamgeIndex == 4) {
                _section2Picker1.hidden = NO;
                _section2Picker1.frame = CGRectMake(157.0f, 179.0f, 200.0f, 216.0f);
                [_section2Picker1 selectRow:0 inComponent:0 animated:NO];
                [_section2Picker1 reloadAllComponents];
                _section2Picker2.hidden = NO;
                _section2Picker2.frame = CGRectMake(457.0, 179.0f, 200.0f, 216.0f);
                [_section2Picker2 selectRow:0 inComponent:0 animated:NO];
                [_section2Picker2 reloadAllComponents];
                _section2Picker3.hidden = YES;
            } else {
                _section2Picker1.hidden = YES;
                _section2Picker2.hidden = YES;
                _section2Picker3.hidden = YES;
            }
            titleString = @"选择具体治疗方法";
            imageName = [NSString stringWithFormat:@"zlfaR2FuzhuDetail_%lu.png", (unsigned long)iamgeIndex];

        } else {
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
            imageName = [NSString stringWithFormat:@"zlfaFuzhuDetail_%lu.png", (unsigned long)iamgeIndex];
        }
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

- (void)transitionR2AndRight
{
    if (GCase1().zlfaR2RightSelectedIndex == 1) {
        GCase1().zlfaFuzhuOrZhaoShe = @"F";
        _showR2Fuzhu = YES;
        _right2FuzhuSegmentControl.selectedSegmentIndex = 0;
        _right2ChixuJianxieSegmentControl.hidden = NO;
        _rightViw2SubView.hidden = YES;
        _right2ChixuJianxieSegmentControl.selectedSegmentIndex = -1;
        [UIView transitionFromView:_rightViewR2
                            toView:_rightView2
                          duration:1.0
                           options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionShowHideTransitionViews
                        completion:^(BOOL finished) {

                        }];
    } else {
        _showR2Fuzhu = NO;
        for (UISegmentedControl *segmentedControl in _r2RightSegCollection) {
            if (segmentedControl.tag == 301) {
                segmentedControl.selectedSegmentIndex = 1;
            }
        }
        _right2ChixuJianxieSegmentControl.hidden = NO;
        _rightViw2SubView.hidden = YES;
        _right2ChixuJianxieSegmentControl.selectedSegmentIndex = -1;
        [UIView transitionFromView:_rightView2
                            toView:_rightViewR2
                          duration:1.0
                           options:UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionShowHideTransitionViews
                        completion:^(BOOL finished) {

                        }];
    }
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
        GCase1().zlfaXinFuZhuYaoWuSeg1 = selectedString;
    } else if ([dicKeyString isEqualToString:@"1023"]) {
        GCase1().zlfaXinFuZhuYaoWuSeg2 = selectedString;
    } else if ([dicKeyString isEqualToString:@"101_2"] ||
               [dicKeyString isEqualToString:@"101_3"] ||
               [dicKeyString isEqualToString:@"101_4"]) {
        GCase1().zlfaFuzhuYaoWuSeg1 = selectedString;
    } else if ([dicKeyString isEqualToString:@"102_2"] ||
               [dicKeyString isEqualToString:@"102_3"] ||
               [dicKeyString isEqualToString:@"102_4"]) {
        GCase1().zlfaFuzhuYaoWuSeg2 = selectedString;
    } else if ([dicKeyString isEqualToString:@"103_4"]) {
        GCase1().zlfaFuzhuYaoWuSeg3 = selectedString;
    } else if ([dicKeyString isEqualToString:@"101,2"] ||
               [dicKeyString isEqualToString:@"101,3"] ||
               [dicKeyString isEqualToString:@"101,4"]) {
        GCase1().zlfaR2FuzhuYaoWuSeg1 = selectedString;
    } else if ([dicKeyString isEqualToString:@"102,4"]) {
        GCase1().zlfaR2FuzhuYaoWuSeg2 = selectedString;
    }
}

- (NSString *)dicKeyString:(UIPickerView *)pickerView
{
    NSString *dicKeyString;
    if (_showFuzhuDetail) {
        NSUInteger keyInt;
        if ([GCase1().zlfaFuzhuType isEqualToString:@"C"]) {
            keyInt = GCase1().zlfaFuzhuSelectedIndex;
        } else {
            keyInt = GCase1().zlfaFuzhuSelectedIndex + 1;
        }
        dicKeyString = [NSString stringWithFormat:@"%ld_%lu",(long)pickerView.tag, (unsigned long)keyInt];
    } else if (_showR2FuzhuDetail) {
        NSUInteger keyInt;
        if ([GCase1().zlfaFuzhuType isEqualToString:@"C"]) {
            keyInt = GCase1().zlfaFuzhuSelectedIndex;
        } else {
            keyInt = GCase1().zlfaFuzhuSelectedIndex + 1;
        }
        dicKeyString = [NSString stringWithFormat:@"%ld,%lu",(long)pickerView.tag, (unsigned long)keyInt];
    } else {
        dicKeyString = [NSString stringWithFormat:@"%ld%lu",(long)pickerView.tag, (unsigned long)GCase1().zlfaRightSelectedIndex];
    }
    return dicKeyString;
}

#pragma mark - Reload Data
- (void)reloadViewDataForR2
{
    _titleLabel.text = @"选择您认为最合理的治疗方案组合";
    _dateTimeLabel.text = GCase1().dateTimeOneMonth;
    _rightView2.hidden = YES;
    _rightViewR2.hidden = NO;

    GCase1().zlfaFuzhuType = @"";
    GCase1().zlfaFuzhuSelectedIndex = 0;

    if (GCase1().r2Type == M1) {
        for (UISegmentedControl *segmentControl in _r2RightSegCollection) {
            if (segmentControl.tag != 301) {
                segmentControl.enabled = NO;
            }
        }
    } else if (GCase1().r2Type == M2) {
        for (UISegmentedControl *segmentControl in _zlfaLeftSegmentedCollection) {
            if (segmentControl.tag != 3) {
                segmentControl.enabled = NO;
            }
        }
        for (UISegmentedControl *segmentControl in _r2RightSegCollection) {
            if (segmentControl.tag != 301) {
                segmentControl.enabled = NO;
            }
        }
    } else if (GCase1().r2Type == M3 ||
               GCase1().r2Type == M4 ||
               GCase1().r2Type == M5 ||
               GCase1().r2Type == M8) {
        for (UISegmentedControl *segmentControl in _zlfaLeftSegmentedCollection) {
            segmentControl.enabled = NO;
        }
        for (UISegmentedControl *segmentControl in _r2RightSegCollection) {
            if (segmentControl.tag == 301) {
                segmentControl.enabled = NO;
            }
        }
    } else if (GCase1().r2Type == M6) {
        for (UISegmentedControl *segmentControl in _zlfaLeftSegmentedCollection) {
            segmentControl.enabled = NO;
        }
        for (UISegmentedControl *segmentControl in _r2RightSegCollection) {
            if (segmentControl.tag != 301) {
                segmentControl.enabled = NO;
            }
        }
    } else if (GCase1().r2Type == M7) {
        for (UISegmentedControl *segmentControl in _zlfaLeftSegmentedCollection) {
            if (segmentControl.tag == 3 || segmentControl.tag == 4) {
                segmentControl.enabled = NO;
            }
        }
        for (UISegmentedControl *segmentControl in _r2RightSegCollection) {
            if (segmentControl.tag != 301) {
                segmentControl.enabled = NO;
            }
        }
    }
}

#pragma mark - R2Seg Change Value
- (IBAction)r2RightSegChangeValue:(UISegmentedControl *)sender
{
    if (sender == _r2RightYaoWuSeg) {
        if (sender.selectedSegmentIndex == 0) {
            GCase1().zlfaR2RightYaowuSelected = @"C";
        } else {
            GCase1().zlfaR2RightYaowuSelected = @"F";
        }
    } else {
        if (sender.selectedSegmentIndex == 0) {
            GCase1().zlfaR2RightSelectedIndex = sender.tag - 300;
            GCase1().zlfaLeftSelectedIndex = 0;
        } else {
            GCase1().zlfaR2RightSelectedIndex = 0;
        }
        if (sender.tag == 301) {
            [self transitionR2AndRight];
        }
        for (UISegmentedControl *segmentControl in _r2RightSegCollection) {
            if (sender.selectedSegmentIndex == 0 && sender != segmentControl) {
                segmentControl.selectedSegmentIndex = 1;
            }
        }

        for (UISegmentedControl *segmentControl in _zlfaLeftSegmentedCollection) {
            segmentControl.selectedSegmentIndex = 1;
        }

        if (sender.tag == 304 && sender.selectedSegmentIndex == 0) {
            _r2RightYaoWuSeg.hidden = NO;
        } else {
            _r2RightYaoWuSeg.hidden = YES;
            _r2RightYaoWuSeg.selectedSegmentIndex = -1;
            GCase1().zlfaR2RightYaowuSelected = @"";
        }
        if (GCase1().zlfaR2RightSelectedIndex > 1) {
            _shouldToNext = YES;
        } else {
            _shouldToNext = NO;
        }
    }
}

- (void)rollToTopView
{
    if (!GCase1().isFSSetp2) {
        [self.view bringSubviewToFront:_section1View];
        _section2View.hidden = YES;
        _section1View.hidden = NO;
        _addFuzhuButton.hidden = YES;
        _titleLabel.text = @"选择治疗方案";
        _rightView1.hidden = NO;
        _rightView2.hidden = YES;
    } else {
        [self.view bringSubviewToFront:_section1View];
        _section2View.hidden = YES;
        _section1View.hidden = NO;
        _addFuzhuButton.hidden = YES;
        _titleLabel.text = @"选择治疗方案";
        _rightView2.hidden = YES;
        _rightViewR2.hidden = NO;
    }
}
@end
