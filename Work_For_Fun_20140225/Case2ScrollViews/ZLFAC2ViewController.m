//
//  ZLFAC2ViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 27/7/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "ZLFAC2ViewController.h"

typedef NS_ENUM(NSInteger, CurrentStep) {
    CurrentStepOne,
    CurrentStepTwo,
    CurrentStepThree
};

static NSString * const DoubleSpace = @"  ";

@interface ZLFAC2ViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *sectionAnimationView;
@property (weak, nonatomic) IBOutlet UIView *section1View;
@property (weak, nonatomic) IBOutlet UIView *section2View;
@property (weak, nonatomic) IBOutlet UIImageView *section2BGImageView;

@property (strong, nonatomic) IBOutletCollection(UISegmentedControl) NSArray *zlfaLeftSegmentedCollection;
@property (weak, nonatomic) IBOutlet UISegmentedControl *danyiSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *xinfuzhuSegmentedControl;

@property (assign, nonatomic) CurrentStep currentStep;

- (IBAction)zlfaLeftSegmentedChanged:(UISegmentedControl *)sender;
- (IBAction)zlfaRightSegmentChanged:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UIView *xinfuzhuView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *xinfuzhuButtonCollection;
- (IBAction)xinfuzhuButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *xinfuzhuMask;

//单一内分泌治疗
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *chixujianxieButtonCollection;
- (IBAction)chixujianxieButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *chixuView;
@property (weak, nonatomic) IBOutlet UIView *jianxieView;
@property (weak, nonatomic) IBOutlet UIView *chixujianxieAnimationView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *jianxieButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *chixuButtonCollection;
- (IBAction)danyiButtonClick:(UIButton *)sender;

//联合内分泌治疗
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *chixujianxieLianheButtonCollection;
- (IBAction)chixujianxieLianheButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *chixuLianheView;
@property (weak, nonatomic) IBOutlet UIView *jianxieLianheView;
@property (weak, nonatomic) IBOutlet UIView *chixujianxieLianheAnimationView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *jianxieLianheButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *chixuLianheButtonCollection;
- (IBAction)lianheButtonClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *zlfaRightLianheSegmentedControl;
- (IBAction)zlfaRightLianheSegmentedChanged:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UIView *lianheMaskView;

//辅助内分泌治疗
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *chixujianxieFuzhuButtonCollection;
- (IBAction)chixujianxieFuzhuButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *chixuFuzhuView;
@property (weak, nonatomic) IBOutlet UIView *jianxieFuzhuView;
@property (weak, nonatomic) IBOutlet UIView *chixujianxieFuzhuAnimationView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *jianxieFuzhuButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *chixuFuzhuButtonCollection;
- (IBAction)fuzhuButtonClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *zlfaRightFuzhuSegmentedControl;
- (IBAction)zlfaRightFuzhuSegmentedChanged:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UIView *fuzhuMaskView;

@property (weak, nonatomic) IBOutlet UIView *danyilianheAnimationView;
@property (weak, nonatomic) IBOutlet UIView *danyifuzhuView;
@property (weak, nonatomic) IBOutlet UIView *lianheView;
@property (weak, nonatomic) IBOutlet UIView *fuzhuView;

@property (weak, nonatomic) IBOutlet UIButton *buchongfanganButton;
- (IBAction)buchongfanganButtonClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIPickerView *section2PickerView1;
@property (weak, nonatomic) IBOutlet UIPickerView *section2PickerView2;

- (IBAction)confirmClick:(UIButton *)sender;

@property (assign, nonatomic) BOOL xinfuzhuMaskShowed;
@property (assign, nonatomic) BOOL danyiMaskShowed;
@property (strong, nonatomic) NSDictionary *pickViewSourceDictionary;

@property (assign, nonatomic) NSUInteger pickViewSubIndex;

@property (assign, nonatomic, getter = isBackStep) BOOL backStep;
@property (assign, nonatomic, getter = isXinFuZhu) BOOL xinFuZhu;
@end

@implementation ZLFAC2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleLabel.text = @"选择治疗方案";
    _titleLabel.font = [UIFont miscrosoftYaHeiFontWithSize:24.0f];
    _titleLabel.textColor = [UIColor colorWithRed:0.0f/255 green:109.0f/255 blue:108.0f/255 alpha:1];

    self.pickViewSourceDictionary = @{@"11": @[DoubleSpace, @"戈舍瑞林", @"亮丙瑞林", @"达菲林 1月剂型", @"达菲林 3月剂型"],
                                      @"12": @[DoubleSpace, @"比卡鲁胺", @"氟他胺"],
                                      @"13": @[DoubleSpace, @"戈舍瑞林", @"亮丙瑞林", @"达菲林 1月剂型", @"达菲林 3月剂型"],
                                      @"23": @[DoubleSpace, @"比卡鲁胺", @"氟他胺"]};

    _currentStep = CurrentStepOne;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)zlfaLeftSegmentedChanged:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) { //YES
        if (sender.tag == 1 || sender.tag == 2) { //手术
            //
        }
        if (sender.tag == 3) { //外放疗
            [UIView transitionWithView:_danyilianheAnimationView
                              duration:0.8
                               options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                            animations:^{
                                _lianheView.hidden = NO;
                                _danyifuzhuView.hidden = YES;
                                if (_currentStep == CurrentStepOne) {
                                    _lianheView.hidden = NO;
                                    _danyifuzhuView.hidden = YES;
                                }
                                if (_currentStep == CurrentStepTwo) {
                                    _lianheView.hidden = NO;
                                    _fuzhuView.hidden = YES;
                                }
                            }
                            completion:^(BOOL finished){
                            }];
            if (_currentStep == CurrentStepTwo) {
                _zlfaRightFuzhuSegmentedControl.selectedSegmentIndex = 1;
                _fuzhuMaskView.hidden = NO;
                _chixuFuzhuView.hidden = YES;
                _jianxieFuzhuView.hidden = YES;
                for (UIButton *button in _chixujianxieFuzhuButtonCollection) {
                    button.selected = NO;
                }
                for (UIButton *button in _chixuFuzhuButtonCollection) {
                    button.selected = NO;
                }
                for (UIButton *button in _jianxieFuzhuButtonCollection) {
                    button.selected = NO;
                }
                GCase2().zlfaFuzhuSelectedIndex = 0;
                GCase2().zlfaFuzhuChixuJianxieSelectedIndex = 0;
                GCase2().zlfaFuzhuChixujianxieDetailSelectedIndex = 0;

                GCase2().zlfaWaifangliao = 1;
            }
        } else {
            if (GCase2().zlfaLeftSelectedIndex == 3) {
                [UIView transitionWithView:_danyilianheAnimationView
                                  duration:0.8
                                   options:UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                                animations:^{
                                    _danyifuzhuView.hidden = NO;
                                    _lianheView.hidden = YES;
                                }
                                completion:^(BOOL finished){
                                }];
                _zlfaRightLianheSegmentedControl.selectedSegmentIndex = 1;
                _lianheMaskView.hidden = NO;
                _chixuLianheView.hidden = YES;
                _jianxieLianheView.hidden = YES;
                for (UIButton *button in _chixujianxieLianheButtonCollection) {
                    button.selected = NO;
                }
                for (UIButton *button in _chixuLianheButtonCollection) {
                    button.selected = NO;
                }
                for (UIButton *button in _jianxieLianheButtonCollection) {
                    button.selected = NO;
                }
                GCase2().zlfaLianheSelectedIndex = 0;
                GCase2().zlfaChixuJianxieSelectedIndex = 0;
                GCase2().zlfaChixujianxieDetailSelectedIndex = 0;
            }
        }
        if (sender.tag == 4) { //等待观察
            [GInstance() showInfoMessage:@"根据该患者情况，不适合等待观察。"];
        }
        if (_currentStep == CurrentStepOne) {
            GCase2().zlfaLeftSelectedIndex = sender.tag;
        }
    } else {
        if (GCase2().zlfaLeftSelectedIndex == 3 || GCase2().zlfaWaifangliao == 1) {
            [UIView transitionWithView:_danyilianheAnimationView
                              duration:0.8
                               options:UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                            animations:^{
                                if (_currentStep == CurrentStepOne) {
                                    _danyifuzhuView.hidden = NO;
                                    _lianheView.hidden = YES;
                                }
                                if (_currentStep == CurrentStepTwo) {
                                    _fuzhuView.hidden = NO;
                                    _lianheView.hidden = YES;
                                }
                            }
                            completion:^(BOOL finished){
                            }];
            _zlfaRightLianheSegmentedControl.selectedSegmentIndex = 1;
            _lianheMaskView.hidden = NO;
            _chixuLianheView.hidden = YES;
            _jianxieLianheView.hidden = YES;
            for (UIButton *button in _chixujianxieLianheButtonCollection) {
                button.selected = NO;
            }
            for (UIButton *button in _chixuLianheButtonCollection) {
                button.selected = NO;
            }
            for (UIButton *button in _jianxieLianheButtonCollection) {
                button.selected = NO;
            }
            GCase2().zlfaLianheSelectedIndex = 0;
            GCase2().zlfaChixuJianxieSelectedIndex = 0;
            GCase2().zlfaChixujianxieDetailSelectedIndex = 0;
            if (_currentStep == CurrentStepTwo) {
                GCase2().zlfaWaifangliao = 0;
            }
        }
        if (_currentStep == CurrentStepOne) {
            GCase2().zlfaLeftSelectedIndex = 0;
        }
    }

    if (_currentStep == CurrentStepOne) {
        for (UISegmentedControl *segmentedControl in _zlfaLeftSegmentedCollection) {
            if (sender.selectedSegmentIndex == 0 &&
                segmentedControl.selectedSegmentIndex == 0 &&
                segmentedControl != sender) {
                segmentedControl.selectedSegmentIndex = 1;
            }
        }

        BOOL danyiEnable = YES;
        BOOL xinfuzhuEnable = YES;
        for (UISegmentedControl *segmentedControl in _zlfaLeftSegmentedCollection) {
            if (segmentedControl.selectedSegmentIndex == 0) {
                danyiEnable = NO;
                if (segmentedControl.tag == 3 || segmentedControl.tag == 4) {
                    xinfuzhuEnable = NO;
                }
            }
        }
        _danyiSegmentedControl.enabled = danyiEnable;
        _xinfuzhuSegmentedControl.enabled = xinfuzhuEnable;
    }
}

- (IBAction)zlfaRightSegmentChanged:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        if (sender == _danyiSegmentedControl) {
            for (UISegmentedControl *segmentedControl in _zlfaLeftSegmentedCollection) {
                segmentedControl.enabled = NO;
            }
            _xinfuzhuSegmentedControl.selectedSegmentIndex = 1;
            NSTimeInterval maskDuration = 0;
            if (!_xinfuzhuMaskShowed) {
                maskDuration = 0.5;
                _xinfuzhuMaskShowed = YES;
            }
            _danyiMaskShowed = NO;
            [UIView animateWithDuration:maskDuration animations:^{
                _xinfuzhuMask.frame = CGRectMake(0, 47, 365, 158);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 animations:^{
                    _xinfuzhuView.frame = CGRectMake(20, 376, 365, 390);
                } completion:^(BOOL finished) {
                    for (UIButton *button in _chixujianxieButtonCollection) {
                        button.enabled = YES;
                    }
                }];
            }];

        } else if (sender == _xinfuzhuSegmentedControl) {
            _danyiSegmentedControl.selectedSegmentIndex = 1;
            for (UISegmentedControl *segmentedControl in _zlfaLeftSegmentedCollection) {
                if (segmentedControl.tag == 1 || segmentedControl.tag == 2) {
                    segmentedControl.enabled = YES;
                }
                if (segmentedControl.tag == 3 || segmentedControl.tag == 4) {
                    segmentedControl.enabled = NO;
                }
            }
            NSTimeInterval maskDuration = 0;
            if (!_danyiMaskShowed) {
                maskDuration = 0.5;
                _danyiMaskShowed = YES;
            }
            _xinfuzhuMaskShowed = NO;
            [UIView animateWithDuration:maskDuration animations:^{
                _xinfuzhuView.frame = CGRectMake(20, 76, 365, 390);
            } completion:^(BOOL finished) {
                _chixuView.hidden = YES;
                _jianxieView.hidden = YES;
                [UIView animateWithDuration:0.5 animations:^{
                    _xinfuzhuMask.frame = CGRectMake(0, 47 + 158, 365, 158);
                } completion:^(BOOL finished) {
                    for (UIButton *button in _xinfuzhuButtonCollection) {
                        button.enabled = YES;
                    }
                }];
            }];
        }
        GCase2().zlfaRightSelectedIndex = sender.tag;
    } else {
        if (sender == _danyiSegmentedControl) {
            for (UISegmentedControl *segmentedControl in _zlfaLeftSegmentedCollection) {
                segmentedControl.enabled = YES;
            }
            _danyiMaskShowed = YES;
            [UIView animateWithDuration:0.5 animations:^{
                _xinfuzhuView.frame = CGRectMake(20, 76, 365, 390);
            } completion:^(BOOL finished) {
                _chixuView.hidden = YES;
                _jianxieView.hidden = YES;
            }];
        } else if (sender == _xinfuzhuSegmentedControl) {
            for (UISegmentedControl *segmentedControl in _zlfaLeftSegmentedCollection) {
                if (segmentedControl.tag == 3 || segmentedControl.tag == 4) {
                    segmentedControl.enabled = YES;
                }
            }
            _xinfuzhuMaskShowed = YES;
            [UIView animateWithDuration:0.5 animations:^{
                _xinfuzhuMask.frame = CGRectMake(0, 47, 365, 158);
            } completion:^(BOOL finished) {}];
        }
        GCase2().zlfaRightSelectedIndex = 0;
    }

    GCase2().zlfaChixujianxieDetailSelectedIndex = 0;
    GCase2().zlfaChixuJianxieSelectedIndex = 0;

    for (UIButton *button in _xinfuzhuButtonCollection) {
        button.selected = NO;
        button.enabled = NO;
    }

    for (UIButton *button in _chixujianxieButtonCollection) {
        button.selected = NO;
        button.enabled = NO;
    }

    for (UIButton *button in _chixuButtonCollection) {
        button.selected = NO;
        button.enabled = NO;
    }

    for (UIButton *button in _jianxieButtonCollection) {
        button.selected = NO;
        button.enabled = NO;
    }
}

- (IBAction)xinfuzhuButtonClick:(UIButton *)sender
{
    sender.selected = YES;
    for (UIButton *button in _xinfuzhuButtonCollection) {
        if (button != sender && button.selected == YES) {
            button.selected = NO;
        }
    }
    GCase2().zlfaChixujianxieDetailSelectedIndex = sender.tag;
}

- (IBAction)chixujianxieButtonClick:(UIButton *)sender
{
    sender.selected = YES;
    for (UIButton *button in _chixujianxieButtonCollection) {
        if (button != sender && button.selected == YES) {
            button.selected = NO;
        }
    }
    for (UIButton *button in _chixuButtonCollection) {
        button.enabled = YES;
    }
    for (UIButton *button in _jianxieButtonCollection) {
        button.enabled = YES;
    }

    GCase2().zlfaChixuJianxieSelectedIndex = sender.tag;
    GCase2().zlfaChixujianxieDetailSelectedIndex = 0;

    UIViewAnimationOptions option;
    UIView *showedView;
    UIView *hiddenView;
    if (sender.tag == 1) {
        option = UIViewAnimationOptionTransitionFlipFromLeft;
        showedView = _chixuView;
        hiddenView = _jianxieView;
    } else {
        option = UIViewAnimationOptionTransitionFlipFromRight;
        showedView = _jianxieView;
        hiddenView = _chixuView;
    }

    [UIView transitionWithView:_chixujianxieAnimationView
                      duration:0.8
                       options:option | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                    animations:^{
                        showedView.hidden = NO;
                        hiddenView.hidden = YES;
                    }
                    completion:^(BOOL finished){

                    }];
}

- (IBAction)danyiButtonClick:(UIButton *)sender
{
    sender.selected = YES;
    for (UIButton *button in _chixuButtonCollection) {
        if (button != sender && button.selected == YES) {
            button.selected = NO;
        }
    }
    for (UIButton *button in _jianxieButtonCollection) {
        if (button != sender && button.selected == YES) {
            button.selected = NO;
        }
    }
    GCase2().zlfaChixujianxieDetailSelectedIndex = sender.tag;
}

#pragma mark - 联合内分泌治疗
- (IBAction)chixujianxieLianheButtonClick:(UIButton *)sender
{
    sender.selected = YES;
    for (UIButton *button in _chixujianxieLianheButtonCollection) {
        if (button != sender && button.selected == YES) {
            button.selected = NO;
        }
    }

    GCase2().zlfaChixuJianxieSelectedIndex = sender.tag;
    GCase2().zlfaChixujianxieDetailSelectedIndex = 0;

    UIViewAnimationOptions option;
    UIView *showedView;
    UIView *hiddenView;
    if (sender.tag == 1) {
        option = UIViewAnimationOptionTransitionFlipFromLeft;
        showedView = _chixuLianheView;
        hiddenView = _jianxieLianheView;
    } else {
        option = UIViewAnimationOptionTransitionFlipFromRight;
        showedView = _jianxieLianheView;
        hiddenView = _chixuLianheView;
    }

    [UIView transitionWithView:_chixujianxieLianheAnimationView
                      duration:0.8
                       options:option | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                    animations:^{
                        showedView.hidden = NO;
                        hiddenView.hidden = YES;
                    }
                    completion:^(BOOL finished){

                    }];
}

- (IBAction)lianheButtonClick:(UIButton *)sender
{
    sender.selected = YES;
    for (UIButton *button in _chixuLianheButtonCollection) {
        if (button != sender && button.selected == YES) {
            button.selected = NO;
        }
    }
    for (UIButton *button in _jianxieLianheButtonCollection) {
        if (button != sender && button.selected == YES) {
            button.selected = NO;
        }
    }
    GCase2().zlfaChixujianxieDetailSelectedIndex = sender.tag;
}

- (IBAction)zlfaRightLianheSegmentedChanged:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        GCase2().zlfaLianheSelectedIndex = 1;
        _lianheMaskView.hidden = YES;
    } else {
        _lianheMaskView.hidden = NO;
        _chixuLianheView.hidden = YES;
        _jianxieLianheView.hidden = YES;

        for (UIButton *button in _chixujianxieLianheButtonCollection) {
            button.selected = NO;
        }

        for (UIButton *button in _chixuLianheButtonCollection) {
            button.selected = NO;
        }

        for (UIButton *button in _jianxieLianheButtonCollection) {
            button.selected = NO;
        }
        GCase2().zlfaLianheSelectedIndex = 0;
        GCase2().zlfaChixuJianxieSelectedIndex = 0;
        GCase2().zlfaChixujianxieDetailSelectedIndex = 0;
    }
}

#pragma mark - 辅助内分泌治疗
- (IBAction)chixujianxieFuzhuButtonClick:(UIButton *)sender
{
    sender.selected = YES;
    for (UIButton *button in _chixujianxieFuzhuButtonCollection) {
        if (button != sender && button.selected == YES) {
            button.selected = NO;
        }
    }

    GCase2().zlfaFuzhuChixuJianxieSelectedIndex = sender.tag;
    GCase2().zlfaFuzhuChixujianxieDetailSelectedIndex = 0;

    UIViewAnimationOptions option;
    UIView *showedView;
    UIView *hiddenView;
    if (sender.tag == 1) {
        option = UIViewAnimationOptionTransitionFlipFromLeft;
        showedView = _chixuFuzhuView;
        hiddenView = _jianxieFuzhuView;
    } else {
        option = UIViewAnimationOptionTransitionFlipFromRight;
        showedView = _jianxieFuzhuView;
        hiddenView = _chixuFuzhuView;
    }

    [UIView transitionWithView:_chixujianxieFuzhuAnimationView
                      duration:0.8
                       options:option | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                    animations:^{
                        showedView.hidden = NO;
                        hiddenView.hidden = YES;
                    }
                    completion:^(BOOL finished){

                    }];
}

- (IBAction)fuzhuButtonClick:(UIButton *)sender
{
    sender.selected = YES;
    for (UIButton *button in _chixuFuzhuButtonCollection) {
        if (button != sender && button.selected == YES) {
            button.selected = NO;
        }
    }
    for (UIButton *button in _jianxieFuzhuButtonCollection) {
        if (button != sender && button.selected == YES) {
            button.selected = NO;
        }
    }
    GCase2().zlfaFuzhuChixujianxieDetailSelectedIndex = sender.tag;
}

- (IBAction)zlfaRightFuzhuSegmentedChanged:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        GCase2().zlfaFuzhuSelectedIndex = 1;
        _fuzhuMaskView.hidden = YES;
    } else {
        _fuzhuMaskView.hidden = NO;
        _chixuFuzhuView.hidden = YES;
        _jianxieFuzhuView.hidden = YES;

        for (UIButton *button in _chixujianxieFuzhuButtonCollection) {
            button.selected = NO;
        }

        for (UIButton *button in _chixuFuzhuButtonCollection) {
            button.selected = NO;
        }

        for (UIButton *button in _jianxieFuzhuButtonCollection) {
            button.selected = NO;
        }
        GCase2().zlfaFuzhuSelectedIndex = 0;
        GCase2().zlfaFuzhuChixuJianxieSelectedIndex = 0;
        GCase2().zlfaFuzhuChixujianxieDetailSelectedIndex = 0;
    }
}

#pragma mark - 补充方案
- (IBAction)buchongfanganButtonClick:(UIButton *)sender
{
    _titleLabel.text = @"选择具体治疗方法";

    _danyifuzhuView.hidden = YES;
    _fuzhuView.hidden = NO;

    for (UISegmentedControl *segmentedControl in _zlfaLeftSegmentedCollection) {
        if (segmentedControl.tag == 3 && GCase2().zlfaRightSelectedIndex != 2) {
            segmentedControl.enabled = YES;
        } else {
            segmentedControl.enabled = NO;
        }
    }

    [UIView transitionWithView:_sectionAnimationView
                      duration:0.8
                       options:UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                    animations:^{
                        _section1View.hidden = NO;
                        _section2View.hidden = YES;
                    }
                    completion:^(BOOL finished){

                    }];

}

#pragma mark - UIPickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *pickViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld%ld", (long)pickerView.tag, (long)_pickViewSubIndex]];
    return [pickViewSource count];
}

#pragma mark UIPickerView Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *pickViewSource = [self.pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld%ld", (long)pickerView.tag, (long)_pickViewSubIndex]];
    return pickViewSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    Case2Data *globalData = GCase2();
    NSArray *pickerViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld%ld", (long)pickerView.tag, (long)_pickViewSubIndex]];
    NSString *selectedString = pickerViewSource[row];
    selectedString = [selectedString isEqualToString:DoubleSpace]? nil : selectedString;
    if (pickerView.tag == 1) {
        if ((globalData.zlfaLeftSelectedIndex == 1 || globalData.zlfaLeftSelectedIndex == 2) && globalData.zlfaFuzhuSelectedIndex == 0 && globalData.zlfaLianheSelectedIndex == 0) {
            globalData.zlfaXinfuzhuYaowuName1 = selectedString;
        } else {
            globalData.zlfaYaowuName1 = selectedString;
        }
    }
    if (pickerView.tag == 2) {
        if ((globalData.zlfaLeftSelectedIndex == 1 || globalData.zlfaLeftSelectedIndex == 2) && globalData.zlfaFuzhuSelectedIndex == 0 && globalData.zlfaLianheSelectedIndex == 0) {
            globalData.zlfaXinfuzhuYaowuName2 = selectedString;
        } else {
            globalData.zlfaYaowuName2 = selectedString;
        }
    }
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
        _section2PickerView1.hidden = YES;
        _section2PickerView2.hidden = YES;
        [self taskList:sender];
    }], nil] show];
}

- (void)taskList:(UIButton *)sender
{
    if (_currentStep == CurrentStepOne) {
        _currentStep = CurrentStepTwo;
        if (GCase2().zlfaRightSelectedIndex == 1 || (GCase2().zlfaRightSelectedIndex == 2 && !_backStep)) {
            [self taskList:nil];
        } else {
            _titleLabel.text = @"治疗方案记录";
            UIImage *section2BGImage;
            if (GCase2().zlfaWaifangliao != 1) {
                if (GCase2().zlfaLeftSelectedIndex == 1) {
                    section2BGImage = [UIImage imageNamed:@"c2chiguhou"];
                    _buchongfanganButton.hidden = NO;
                } else if (GCase2().zlfaLeftSelectedIndex == 2) {
                    section2BGImage = [UIImage imageNamed:@"c2fuqiangjing"];
                    _buchongfanganButton.hidden = NO;
                } else if (GCase2().zlfaLeftSelectedIndex == 3) {
                    section2BGImage = [UIImage imageNamed:@"c2waifangliao"];
                    _buchongfanganButton.hidden = YES;
                }
            } else {
                section2BGImage = [UIImage imageNamed:@"c2waifangliao"];
                _buchongfanganButton.hidden = YES;
            }
            _section2BGImageView.image = section2BGImage;
            [UIView transitionWithView:_sectionAnimationView
                              duration:0.8
                               options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                            animations:^{
                                _section1View.hidden = YES;
                                _section2View.hidden = NO;
                            }
                            completion:^(BOOL finished){

                            }];
        }
    } else if (_currentStep == CurrentStepTwo) {
        _currentStep = CurrentStepThree;

        if (GCase2().zlfaLianheSelectedIndex == 1 ||
            GCase2().zlfaFuzhuSelectedIndex == 1 ||
            GCase2().zlfaRightSelectedIndex == 1 ||
            (GCase2().zlfaRightSelectedIndex == 2 && !_backStep)) {
            UIImage *section2BGImage;
            NSUInteger detailSelectedIndex;

            if (GCase2().zlfaFuzhuSelectedIndex == 1) {
                detailSelectedIndex = GCase2().zlfaFuzhuChixujianxieDetailSelectedIndex;
            } else {
                detailSelectedIndex = GCase2().zlfaChixujianxieDetailSelectedIndex;
            }
            _buchongfanganButton.hidden = YES;
            if (GCase2().zlfaLeftSelectedIndex == 1 || GCase2().zlfaLeftSelectedIndex == 2) {
                if (GCase2().zlfaFuzhuSelectedIndex == 1 || GCase2().zlfaLianheSelectedIndex == 1) {
                    GCase2().zlfaYaowuName1 = nil;
                    GCase2().zlfaYaowuName2 = nil;
                    section2BGImage = [UIImage imageNamed:[NSString stringWithFormat:@"c2chixujianxie_%ld", (long)detailSelectedIndex]];
                } else {
                    GCase2().zlfaXinfuzhuYaowuName1 = nil;
                    GCase2().zlfaXinfuzhuYaowuName2 = nil;
                    section2BGImage = [UIImage imageNamed:[NSString stringWithFormat:@"c2xinfuzhu_%ld", (long)detailSelectedIndex]];
                }
            } else {
                GCase2().zlfaYaowuName1 = nil;
                GCase2().zlfaYaowuName2 = nil;
                section2BGImage = [UIImage imageNamed:[NSString stringWithFormat:@"c2chixujianxie_%ld", (long)detailSelectedIndex]];
            }
            _pickViewSubIndex = detailSelectedIndex;
            if (detailSelectedIndex == 1) {
                _section2PickerView1.hidden = NO;
                _section2PickerView2.hidden = YES;
                _section2PickerView1.frame = CGRectMake(302.0f, 209.0f, 220.0f, 216.0f);
                [_section2PickerView1 selectRow:0 inComponent:0 animated:NO];
                [_section2PickerView1 reloadAllComponents];
            } else if (detailSelectedIndex == 2) {
                _section2PickerView1.hidden = NO;
                _section2PickerView2.hidden = YES;
                _section2PickerView1.frame = CGRectMake(312.0f, 209.0f, 220.0f, 216.0f);
                [_section2PickerView1 selectRow:0 inComponent:0 animated:NO];
                [_section2PickerView1 reloadAllComponents];
            } else if (detailSelectedIndex == 3) {
                _section2PickerView1.hidden = NO;
                _section2PickerView2.hidden = NO;
                _section2PickerView1.frame = CGRectMake(142.0f, 209.0f, 220.0f, 216.0f);
                [_section2PickerView1 selectRow:0 inComponent:0 animated:NO];
                [_section2PickerView1 reloadAllComponents];
                _section2PickerView2.frame = CGRectMake(448.0f, 209.0f, 220.0f, 216.0f);
                [_section2PickerView2 selectRow:0 inComponent:0 animated:NO];
                [_section2PickerView2 reloadAllComponents];
            } else if (detailSelectedIndex == 4) {
                _section2PickerView1.hidden = YES;
                _section2PickerView2.hidden = YES;
            }
            _section2BGImageView.image = section2BGImage;
            [UIView transitionWithView:_sectionAnimationView
                              duration:0.8
                               options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                            animations:^{
                                _section1View.hidden = YES;
                                _section2View.hidden = NO;
                            }
                            completion:^(BOOL finished){

                            }];
        } else {
            if (GCase2().zlfaWaifangliao == 1 && !_backStep) {
                _currentStep = CurrentStepOne;
                _backStep = YES;
            }
            [self taskList:nil];
        }
    } else if (_currentStep == CurrentStepThree) {
        if (GCase2().zlfaRightSelectedIndex == 2 && !_backStep) {
            _currentStep = CurrentStepOne;
            _backStep = YES;
            [self taskList:nil];
        } else {
            if ([self.scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
                [self.scrollViewDelegate didClickConfirmButton:sender];
            }
        }
    }
}

- (BOOL)checkValues
{
    Case2Data *globalData = GCase2();
    if (_currentStep == CurrentStepOne) {
        if (globalData.zlfaLeftSelectedIndex == 4) {
            [GInstance() showInfoMessage:@"根据该患者情况，不适合等待观察。"];
            return NO;
        }
        if (globalData.zlfaLeftSelectedIndex == 0 && globalData.zlfaRightSelectedIndex == 0) {
            [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
            return NO;
        }
        if (globalData.zlfaLeftSelectedIndex == 3) {
            if (globalData.zlfaLianheSelectedIndex == 1) {
                if (globalData.zlfaChixuJianxieSelectedIndex == 0) {
                    [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                    return NO;
                } else {
                    if (globalData.zlfaChixujianxieDetailSelectedIndex == 0) {
                        [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                        return NO;
                    }
                }
            } else {
                [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                return NO;
            }
        }
        if (globalData.zlfaRightSelectedIndex == 1) {
            if (globalData.zlfaChixuJianxieSelectedIndex == 0) {
                [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                return NO;
            } else {
                if (globalData.zlfaChixujianxieDetailSelectedIndex == 0) {
                    [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                    return NO;
                }
            }
        }
        if (globalData.zlfaRightSelectedIndex == 2) {
            if (globalData.zlfaChixujianxieDetailSelectedIndex == 0 ||
                globalData.zlfaLeftSelectedIndex == 0) {
                [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                return NO;
            }
        }
    }
    if (_currentStep == CurrentStepTwo) {
        if (globalData.zlfaWaifangliao == 0 && globalData.zlfaFuzhuSelectedIndex == 1) {
            if (globalData.zlfaFuzhuChixuJianxieSelectedIndex == 0) {
                [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                return NO;
            } else {
                if (globalData.zlfaFuzhuChixujianxieDetailSelectedIndex == 0) {
                    [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                    return NO;
                }
            }
        }
        if (globalData.zlfaWaifangliao == 1 && globalData.zlfaLianheSelectedIndex == 1) {
            if (globalData.zlfaChixuJianxieSelectedIndex == 0) {
                [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                return NO;
            } else {
                if (globalData.zlfaChixujianxieDetailSelectedIndex == 0) {
                    [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                    return NO;
                }
            }
        }
    }
    if (_currentStep == CurrentStepThree) {
        if (globalData.zlfaLeftSelectedIndex == 3) {
            if (globalData.zlfaChixujianxieDetailSelectedIndex == 1 || globalData.zlfaChixujianxieDetailSelectedIndex == 2) {
                if (!globalData.zlfaYaowuName1) {
                    [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                    return NO;
                }
            } else if (globalData.zlfaChixujianxieDetailSelectedIndex == 3) {
                if (!globalData.zlfaYaowuName1 || !globalData.zlfaYaowuName2) {
                    [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                    return NO;
                }
            }
        }

        if ((globalData.zlfaLeftSelectedIndex == 1 || globalData.zlfaLeftSelectedIndex == 2) && globalData.zlfaRightSelectedIndex == 2) {
            if (globalData.zlfaChixujianxieDetailSelectedIndex == 1 || globalData.zlfaChixujianxieDetailSelectedIndex == 2) {
                if (!globalData.zlfaXinfuzhuYaowuName1) {
                    [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                    return NO;
                }
            } else if (globalData.zlfaChixujianxieDetailSelectedIndex == 3) {
                if (!globalData.zlfaXinfuzhuYaowuName1 || !globalData.zlfaXinfuzhuYaowuName2) {
                    [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                    return NO;
                }
            }
        }

        NSUInteger selectedIndex = 0;
        if (globalData.zlfaWaifangliao == 1 && globalData.zlfaLianheSelectedIndex == 1) {
            selectedIndex = globalData.zlfaChixujianxieDetailSelectedIndex;
        }

        if (globalData.zlfaWaifangliao == 0 && globalData.zlfaFuzhuSelectedIndex == 1) {
            selectedIndex = globalData.zlfaFuzhuChixujianxieDetailSelectedIndex;
        }

        if (globalData.zlfaRightSelectedIndex == 1) {
            selectedIndex = globalData.zlfaChixujianxieDetailSelectedIndex;
        }

        if (selectedIndex == 1 || selectedIndex == 2) {
            if (!globalData.zlfaYaowuName1) {
                [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                return NO;
            }
        } else if (selectedIndex == 3) {
            if (!globalData.zlfaYaowuName1 || !globalData.zlfaYaowuName2) {
                [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                return NO;
            }
        }
    }

    return YES;
}

- (void)rollToTopView
{
    [self.view bringSubviewToFront:_section1View];
    _section2View.hidden = YES;
    _section1View.hidden = NO;
    _titleLabel.text = @"选择治疗方案";
//    _fuzhuView.hidden = YES;
//    _lianheView.hidden = YES;

}

@end
