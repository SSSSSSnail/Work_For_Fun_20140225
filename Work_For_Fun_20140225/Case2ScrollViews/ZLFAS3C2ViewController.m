//
//  ZLFAS3C2ViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 4/8/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "ZLFAS3C2ViewController.h"

typedef NS_ENUM(NSInteger, CurrentStep) {
    CurrentStepOne,
    CurrentStepTwo
};

static NSString * const DoubleSpace = @"  ";

@interface ZLFAS3C2ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *sectionAnimationView;
@property (weak, nonatomic) IBOutlet UIView *section1View;
@property (weak, nonatomic) IBOutlet UIView *section2View;
@property (weak, nonatomic) IBOutlet UIImageView *section2BGImageView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *zlfa3LeftSegmentedControl;
- (IBAction)zlfa3LeftSegmentChanged:(UISegmentedControl *)sender;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *zlfa3LfetButtonCollection;
- (IBAction)zlfa3LeftButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *zlfa3LeftMaskView;

@property (weak, nonatomic) IBOutlet UIView *zlfa3LeftAnimationView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView2;

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

@implementation ZLFAS3C2ViewController

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
    NSUInteger sNumber = GCase2().step2SNumber;
    NSArray *enableArray;
    switch (GCase2().step1MNumber) {
        case 2:
            if (sNumber == 1) {   //M2S1
                enableArray = @[@5, @6, @7, @8];
            } else if (sNumber == 2) {  //M2S2
                enableArray = @[@4];
            }
            break;
        case 3:
        case 4:
        case 5:
            if (sNumber == 1) {   //M3S1
                enableArray = @[@6, @7, @8];
            } else if (sNumber == 2) {  //M3S2
                enableArray = @[@8];
            } else if (sNumber == 3) {  //M3S3
                enableArray = @[@6, @7, @8];
            } else if (sNumber == 4) {  //M3S4
                enableArray = @[@5, @6, @7, @8];
            }
            break;
        case 6:
            if (sNumber == 1) {   //M6S1
                enableArray = @[@5, @6, @7, @8];
            }
            break;
        case 7:
            if (sNumber == 1) {   //M7S1
                enableArray = @[@6, @7, @8];
            } else if (sNumber == 2) {  //M7S2
                enableArray = @[@8];
            } else if (sNumber == 3) {  //M7S3
                enableArray = @[@6, @7, @8];
            }
            break;
        case 8:
            if (sNumber == 1) {   //M8S1
                enableArray = @[@6, @7, @8];
            } else if (sNumber == 2) {  //M8S2
                enableArray = @[@8];
            } else if (sNumber == 3) {  //M8S3
                enableArray = @[@6, @7, @8];
            }
            break;
        case 9:
            if (sNumber == 1) {   //M9S1
                enableArray = @[@5, @6, @7, @8];
            } else if (sNumber == 2) {  //M9S2
                enableArray = @[@5, @6, @7, @8];
            } else if (sNumber == 3) {  //M9S3
                enableArray = @[@5, @6, @8];
            } else if (sNumber == 4) {  //M9S4
                enableArray = @[@7, @8];
            }
            break;
        default:
            enableArray = @[];
            break;
    }
    for (UISegmentedControl *segmentControl in _zlfa2SegmentedCollection) {
        segmentControl.enabled = NO;
    }

    for (UISegmentedControl *segmentControl in _zlfa2SegmentedCollection) {
        for (NSNumber *tagNumber in enableArray) {
            if (tagNumber.integerValue == segmentControl.tag) {
                segmentControl.enabled = YES;
                break;
            }
        }
    }

    if (GCase2().step1MNumber == 2 ||
        ((GCase2().step1MNumber == 3 ||
          GCase2().step1MNumber == 4 ||
          GCase2().step1MNumber == 5) && sNumber == 4
         )) {
            _zlfa3LeftSegmentedControl.enabled = NO;
        } else {
            _zlfa3LeftSegmentedControl.enabled = YES;
        }

    if (GCase2().zlfa2ErfenSelectedIndex == 1) {

    } else if (GCase2().zlfa2ErfenSelectedIndex == 2) {

    }
}

- (IBAction)zlfa3LeftSegmentChanged:(UISegmentedControl *)sender
{
    BOOL buttonEnable;
    CGRect frame = _zlfa3LeftMaskView.frame;
    if (sender.selectedSegmentIndex == 0) {
        GCase2().zlfa3GutongSelectedIndex = 1;
        buttonEnable = YES;
        frame.origin.y = CGRectGetHeight(frame) + CGRectGetMinY(frame);
    } else {
        GCase2().zlfa3GutongSelectedIndex = 0;
        buttonEnable = NO;
        frame.origin.y = CGRectGetMinY(frame) - CGRectGetHeight(frame);
        _leftImageView1.hidden = YES;
        _leftImageView2.hidden = YES;
    }

    [UIView animateWithDuration:0.5 animations:^{
        _zlfa3LeftMaskView.frame = frame;
    }];

    for (UIButton *button in _zlfa3LfetButtonCollection) {
        button.enabled = buttonEnable;
        if (!buttonEnable) {
            button.selected = NO;
        }
    }
    if (!buttonEnable) {
        GCase2().zlfa3GutongSelectedIndex = 0;
    }
}

- (IBAction)zlfa3LeftButtonClick:(UIButton *)sender
{
    sender.selected = YES;

    for (UIButton *button in _zlfa3LfetButtonCollection) {
        if (button != sender) {
            button.selected = NO;
        }
    }

    [UIView transitionWithView:_zlfa3LeftAnimationView
                      duration:0.8
                       options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                    animations:^{
                        if (sender.tag == 1) {
                            _leftImageView1.hidden = NO;
                            _leftImageView2.hidden = YES;
                        } else {
                            _leftImageView1.hidden = YES;
                            _leftImageView2.hidden = NO;
                        }
                    }
                    completion:^(BOOL finished){
                    }];

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
        if (sender.tag == 3 && GCase2().zlfa3SegmentSelectedIndex == 4) {
            for (UIButton *button in _chixujianxieButtonCollection) {
                button.selected = NO;
            }
            for (UIButton *button in _chixuButtonCollection) {
                button.selected = NO;
            }
            for (UIButton *button in _jianxieButtonCollection) {
                button.selected = NO;
            }
            GCase2().zlfa3ChixuJianxieNeifenSelectedIndex = 0;
            GCase2().zlfa3ChixuJianxieNeifenDetailSelectedIndex = 0;
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

        GCase2().zlfa3SegmentSelectedIndex = sender.tag;
    } else {
        GCase2().zlfa3SegmentSelectedIndex = 0;

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
            GCase2().zlfa3ChixuJianxieNeifenSelectedIndex = 0;
            GCase2().zlfa3ChixuJianxieNeifenDetailSelectedIndex = 0;
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
        if (button.tag == GCase2().zlfa2ErfenSelectedIndex) {
            button.enabled = NO;
        }
        if (!buttonEnable) {
            button.selected = NO;
        }
    }

    if (!buttonEnable) {
        GCase2().zlfa3ErfenSelectedIndex = 0;
    }
}

- (IBAction)erxianButtonClick:(UIButton *)sender
{
    GCase2().zlfa3ErfenSelectedIndex = sender.tag;

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

    GCase2().zlfa3ChixuJianxieNeifenSelectedIndex = sender.tag;
    GCase2().zlfa3ChixuJianxieNeifenDetailSelectedIndex = 0;

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
    GCase2().zlfa3ChixuJianxieNeifenDetailSelectedIndex = sender.tag;
}

- (IBAction)confirmClick:(UIButton *)sender
{
    if (![self checkValues]) {
        return;
    }

    _section2PickerView1.hidden = YES;
    _section2PickerView2.hidden = YES;

    [[[UIAlertView alloc] initWithTitle:nil
                                message:@"治疗方案确认后不能修改!"
                       cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{

    }]
                       otherButtonItems:[RIButtonItem itemWithLabel:@"确认" action:^{
        [self taskList:sender];
    }], nil] show];
}

- (void)taskList:(UIButton *)sender
{
    if (_currentStep == CurrentStepOne) {
        _currentStep = CurrentStepTwo;
        if (GCase2().zlfa3SegmentSelectedIndex == 4) {
            _titleLabel.text = @"选择具体治疗方法";

            NSUInteger detailSelectedIndex = GCase2().zlfa3ChixuJianxieNeifenDetailSelectedIndex;

            GCase2().zlfa3NeifenmiYaowuName1 = nil;
            GCase2().zlfa3NeifenmiYaowuName2 = nil;
            UIImage *section2BGImage = [UIImage imageNamed:[NSString stringWithFormat:@"c2zlfa3neifenmi_%ld", detailSelectedIndex]];
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

- (BOOL)checkValues
{
    if (_zlfa3LeftSegmentedControl.enabled == YES &&
        GCase2().zlfa3GutongSelectedIndex != 0) {
        [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
        return NO;
    }

    if (GCase2().zlfa3SegmentSelectedIndex == 0) {
        [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
        return NO;
    }

    return YES;
}

#pragma mark - UIPickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *pickViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld%ld", (long)pickerView.tag, (long)GCase2().zlfa3ChixuJianxieNeifenDetailSelectedIndex]];
    return [pickViewSource count];
}

#pragma mark UIPickerView Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *pickViewSource = [self.pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld%ld", (long)pickerView.tag, (long)GCase2().zlfa3ChixuJianxieNeifenDetailSelectedIndex]];
    return pickViewSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    Case2Data *globalData = GCase2();
    NSArray *pickerViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld%ld", (long)pickerView.tag, (long)GCase2().zlfa3ChixuJianxieNeifenDetailSelectedIndex]];
    NSString *selectedString = pickerViewSource[row];
    selectedString = [selectedString isEqualToString:DoubleSpace]? nil : selectedString;
    if (pickerView.tag == 1) {
        globalData.zlfa3NeifenmiYaowuName1 = selectedString;
    }
    if (pickerView.tag == 2) {
        globalData.zlfa3NeifenmiYaowuName2 = selectedString;
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
