//
//  ZLFAS2C2ViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 2/8/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "ZLFAS2C2ViewController.h"

typedef NS_ENUM(NSInteger, CurrentStep) {
    CurrentStepOne,
    CurrentStepTwo
};

static NSString * const DoubleSpace = @"  ";

@interface ZLFAS2C2ViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *sectionAnimationView;
@property (weak, nonatomic) IBOutlet UIView *section1View;
@property (weak, nonatomic) IBOutlet UIView *section2View;
@property (weak, nonatomic) IBOutlet UIImageView *section2BGImageView;

@property (strong, nonatomic) IBOutletCollection(UISegmentedControl) NSArray *zlfa2SegmentedCollection;
- (IBAction)zlfa2SegmentedChanged:(UISegmentedControl *)sender;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *erxianButtonCollection;
- (IBAction)erxianButtonClick:(UIButton *)sender;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *chixujianxieButtonCollection;
- (IBAction)chixujianxieButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *chixuView;
@property (weak, nonatomic) IBOutlet UIView *jianxieView;
@property (weak, nonatomic) IBOutlet UIView *chixujianxieAnimationView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *jianxieButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *chixuButtonCollection;
- (IBAction)danyiButtonClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *right1View;
@property (weak, nonatomic) IBOutlet UIView *neifenmiView;
@property (weak, nonatomic) IBOutlet UIView *rightNeifenmiAnimationView;

@property (weak, nonatomic) IBOutlet UIPickerView *section2PickerView1;
@property (weak, nonatomic) IBOutlet UIPickerView *section2PickerView2;

- (IBAction)confirmClick:(UIButton *)sender;

@property (assign, nonatomic) CurrentStep currentStep;
@property (strong, nonatomic) NSDictionary *pickViewSourceDictionary;

@end

@implementation ZLFAS2C2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleLabel.text = @"选择您认为最合理的治疗方案组合";
    _titleLabel.font = [UIFont miscrosoftYaHeiFontWithSize:24.0f];
    _titleLabel.textColor = [UIColor colorWithRed:0.0f/255 green:109.0f/255 blue:108.0f/255 alpha:1];

    self.pickViewSourceDictionary = @{@"11": @[DoubleSpace, @"戈舍瑞林", @"亮丙瑞林", @"达菲林 1月剂型", @"达菲林 3月剂型"],
                                      @"12": @[DoubleSpace, @"比卡鲁胺", @"氟他胺"],
                                      @"13": @[DoubleSpace, @"戈舍瑞林", @"亮丙瑞林", @"达菲林 1月剂型", @"达菲林 3月剂型"],
                                      @"23": @[DoubleSpace, @"比卡鲁胺", @"氟他胺"]};
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh
{
    switch (GCase2().step1MNumber) {
        case 2:
        {
            for (UISegmentedControl *segmentedControl in _zlfa2SegmentedCollection) {
                if (segmentedControl.tag == 3 || segmentedControl.tag == 4) {
                    segmentedControl.enabled = YES;
                } else {
                    segmentedControl.enabled = NO;
                }
            }
        }
            break;
        case 3:
        case 4:
        case 5:
        {
            for (UISegmentedControl *segmentedControl in _zlfa2SegmentedCollection) {
                if (segmentedControl.tag == 3 ||
                    segmentedControl.tag == 5 ||
                    segmentedControl.tag == 6 ||
                    segmentedControl.tag == 7) {
                    segmentedControl.enabled = YES;
                } else {
                    segmentedControl.enabled = NO;
                }
            }
        }
            break;
        case 6:
        {
            for (UISegmentedControl *segmentedControl in _zlfa2SegmentedCollection) {
                if (segmentedControl.tag == 4) {
                    segmentedControl.enabled = YES;
                } else {
                    segmentedControl.enabled = NO;
                }
            }
        }
            break;
        case 7:
        case 8:
        {
            for (UISegmentedControl *segmentedControl in _zlfa2SegmentedCollection) {
                if (segmentedControl.tag >= 5) {
                    segmentedControl.enabled = YES;
                } else {
                    segmentedControl.enabled = NO;
                }
            }
        }
            break;
        case 9:
        {
            for (UISegmentedControl *segmentedControl in _zlfa2SegmentedCollection) {
                if (segmentedControl.tag == 4 || segmentedControl.tag == 5) {
                    segmentedControl.enabled = NO;
                } else {
                    segmentedControl.enabled = YES;
                }
            }
        }
            break;
        default:
            break;

    }
}

- (IBAction)zlfa2SegmentedChanged:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        if (sender.tag == 4) {
            [UIView transitionWithView:_rightNeifenmiAnimationView
                              duration:0.8
                               options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                            animations:^{
                                _right1View.hidden = YES;
                                _neifenmiView.hidden = NO;
                            }
                            completion:^(BOOL finished){
                            }];
        }
        if (sender.tag == 3 && GCase2().zlfa2SegmentSelectedIndex == 4) {
            for (UIButton *button in _chixujianxieButtonCollection) {
                button.selected = NO;
            }
            for (UIButton *button in _chixuButtonCollection) {
                button.selected = NO;
            }
            for (UIButton *button in _jianxieButtonCollection) {
                button.selected = NO;
            }
            GCase2().zlfaChixuJianxieNeifenSelectedIndex = 0;
            GCase2().zlfaChixuJianxieNeifenDetailSelectedIndex = 0;
            _jianxieView.hidden = YES;
            _chixuView.hidden = YES;

            [UIView transitionWithView:_rightNeifenmiAnimationView
                              duration:0.8
                               options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                            animations:^{
                                _right1View.hidden = NO;
                                _neifenmiView.hidden = YES;
                            }
                            completion:^(BOOL finished){
                            }];
        }

        GCase2().zlfa2SegmentSelectedIndex = sender.tag;
    } else {
        GCase2().zlfa2SegmentSelectedIndex = 0;

        if (sender.tag == 4) {
            for (UIButton *button in _chixujianxieButtonCollection) {
                button.selected = NO;
            }
            for (UIButton *button in _chixuButtonCollection) {
                button.selected = NO;
            }
            for (UIButton *button in _jianxieButtonCollection) {
                button.selected = NO;
            }
            GCase2().zlfaChixuJianxieNeifenSelectedIndex = 0;
            GCase2().zlfaChixuJianxieNeifenDetailSelectedIndex = 0;
            _jianxieView.hidden = YES;
            _chixuView.hidden = YES;

            [UIView transitionWithView:_rightNeifenmiAnimationView
                              duration:0.8
                               options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                            animations:^{
                                _right1View.hidden = NO;
                                _neifenmiView.hidden = YES;
                            }
                            completion:^(BOOL finished){
                            }];
        }
    }

    BOOL buttonEnable = NO;
    for (UISegmentedControl *segmentedControl in _zlfa2SegmentedCollection) {
        if (sender.selectedSegmentIndex == 0 &&
            segmentedControl.selectedSegmentIndex == 0 &&
            segmentedControl != sender) {
            segmentedControl.selectedSegmentIndex = 1;
        }
        if (segmentedControl.tag == 6 && segmentedControl.selectedSegmentIndex == 0) {
            buttonEnable = YES;
        }
    }

    for (UIButton *button in _erxianButtonCollection) {
        button.enabled = buttonEnable;
        if (!buttonEnable) {
            button.selected = NO;
        }
    }
    if (!buttonEnable) {
        GCase2().zlfa2ErfenSelectedIndex = 0;
    }
}

- (IBAction)erxianButtonClick:(UIButton *)sender
{
    GCase2().zlfa2ErfenSelectedIndex = sender.tag;

    sender.selected = YES;
    for (UIButton *button in _erxianButtonCollection) {
        if (button != sender && button.selected == YES) {
            button.selected = NO;
        }
    }
}

#pragma mark - 内分泌
- (IBAction)chixujianxieButtonClick:(UIButton *)sender
{
    sender.selected = YES;
    for (UIButton *button in _chixujianxieButtonCollection) {
        if (button != sender && button.selected == YES) {
            button.selected = NO;
        }
    }
    for (UIButton *button in _chixuButtonCollection) {
        button.selected = NO;
    }
    for (UIButton *button in _jianxieButtonCollection) {
        button.selected = NO;
    }

    GCase2().zlfaChixuJianxieNeifenSelectedIndex = sender.tag;
    GCase2().zlfaChixuJianxieNeifenDetailSelectedIndex = 0;

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
    GCase2().zlfaChixuJianxieNeifenDetailSelectedIndex = sender.tag;
}

- (BOOL)checkValues
{
    if (GCase2().zlfa2SegmentSelectedIndex == 0) {
        [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
        return NO;
    }
    if (GCase2().zlfa2SegmentSelectedIndex == 6 && GCase2().zlfa2ErfenSelectedIndex == 0) {
        [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
        return NO;
    }
    if (GCase2().zlfa2SegmentSelectedIndex == 4) {
        if (GCase2().zlfaChixuJianxieNeifenSelectedIndex == 0) {
            [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
            return NO;
        } else {
            if (GCase2().zlfaChixuJianxieNeifenDetailSelectedIndex == 0) {
                [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                return NO;
            } else {
                if (_currentStep == CurrentStepTwo) {
                    if (GCase2().zlfaChixuJianxieNeifenDetailSelectedIndex == 1 ||
                        GCase2().zlfaChixuJianxieNeifenDetailSelectedIndex == 2) {
                        if(!GCase2().zlfaNeifenmiYaowuName1) {
                            [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                            return NO;
                        }
                    } else if (GCase2().zlfaChixuJianxieNeifenDetailSelectedIndex == 3) {
                        if(!GCase2().zlfaNeifenmiYaowuName1 || !GCase2().zlfaNeifenmiYaowuName2) {
                            [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                            return NO;
                        }
                    }
                }
            }
        }
    }
    return YES;
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
        if (_currentStep != CurrentStepTwo) {
            _section2PickerView1.hidden = YES;
            _section2PickerView2.hidden = YES;
        }
        [self taskList:sender];
    }], nil] show];
}

- (void)taskList:(UIButton *)sender
{
    if (_currentStep == CurrentStepOne) {
        _currentStep = CurrentStepTwo;
        if (GCase2().zlfa2SegmentSelectedIndex == 1 ||
            GCase2().zlfa2SegmentSelectedIndex == 2 ||
            GCase2().zlfa2SegmentSelectedIndex == 3) {
            _titleLabel.text = @"治疗方案记录";
            NSString *imageName = @"";
            if (GCase2().zlfa2SegmentSelectedIndex == 1) {
                imageName = @"c2zlfa2chigu";
            } else if (GCase2().zlfa2SegmentSelectedIndex == 2) {
                imageName = @"c2zlfa2fuqiangjing";
            } else if (GCase2().zlfa2SegmentSelectedIndex == 3) {
                imageName = @"c2zlfa2waizhaoshe";
            }
            _section2BGImageView.image = [UIImage imageNamed:imageName];
            [UIView transitionWithView:_sectionAnimationView
                              duration:0.8
                               options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                            animations:^{
                                _section1View.hidden = YES;
                                _section2View.hidden = NO;
                            }
                            completion:^(BOOL finished){

                            }];
        } else if (GCase2().zlfa2SegmentSelectedIndex == 4) {
            _titleLabel.text = @"选择具体治疗方法";

            NSUInteger detailSelectedIndex = GCase2().zlfaChixuJianxieNeifenDetailSelectedIndex;

            GCase2().zlfaNeifenmiYaowuName1 = nil;
            GCase2().zlfaNeifenmiYaowuName2 = nil;
            UIImage *section2BGImage = [UIImage imageNamed:[NSString stringWithFormat:@"c2zlfa2neifenmi_%ld", (long)detailSelectedIndex]];
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
            [self taskList:nil];
        }
    } else if (_currentStep == CurrentStepTwo) {
        if ([self.scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
            [self.scrollViewDelegate didClickConfirmButton:sender];
        }
    }
}

#pragma mark - UIPickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *pickViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld%ld", (long)pickerView.tag, (long)GCase2().zlfaChixuJianxieNeifenDetailSelectedIndex]];
    return [pickViewSource count];
}

#pragma mark UIPickerView Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *pickViewSource = [self.pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld%ld", (long)pickerView.tag, (long)GCase2().zlfaChixuJianxieNeifenDetailSelectedIndex]];
    return pickViewSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    Case2Data *globalData = GCase2();
    NSArray *pickerViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld%ld", (long)pickerView.tag, (long)GCase2().zlfaChixuJianxieNeifenDetailSelectedIndex]];
    NSString *selectedString = pickerViewSource[row];
    selectedString = [selectedString isEqualToString:DoubleSpace]? nil : selectedString;
    if (pickerView.tag == 1) {
        globalData.zlfaNeifenmiYaowuName1 = selectedString;
    }
    if (pickerView.tag == 2) {
        globalData.zlfaNeifenmiYaowuName2 = selectedString;
    }
}

- (void)rollToTopView
{
    _section1View.hidden = NO;
    _section2View.hidden = YES;
    _neifenmiView.hidden = YES;
    _right1View.hidden = NO;
}

@end
