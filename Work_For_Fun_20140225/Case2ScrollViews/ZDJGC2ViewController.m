//
//  ZDJGC2ViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 27/7/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "ZDJGC2ViewController.h"

static NSString * const DoubleSpace = @"  ";

typedef NS_ENUM(NSInteger, ComponentsTag)
{
    UIPickViewZDJG1Evalute = 200,
    UIPickViewZDJG1T = 201,
    UIPickViewZDJG1N = 202,
    UIPickViewZDJG1M = 203,
};

@interface ZDJGC2ViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *pgjgLabel;
@property (weak, nonatomic) IBOutlet UILabel *lcfqLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *zdjglcfqTPickView;
@property (weak, nonatomic) IBOutlet UIPickerView *zdjglcfqNPickView;
@property (weak, nonatomic) IBOutlet UIPickerView *zdjglcfqMPickView;
@property (weak, nonatomic) IBOutlet UIPickerView *zdjgEvaluatePickView;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *oneButtonCollection;
- (IBAction)buttonClick:(UIButton *)sender;

@property (strong, nonatomic) NSDictionary *buttonValueDictionary;
@property (strong, nonatomic) NSDictionary *pickViewSourceDictionary;

- (IBAction)confirmClick:(UIButton *)sender;

@end

@implementation ZDJGC2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.buttonValueDictionary = @{@204: @"jxa", @205: @"jxw", @206: @"zya",
                                   @207: @"bph", @208: @"tnb", @209: @"gxy"};

    self.pickViewSourceDictionary = @{@"200": @[DoubleSpace, @"高危", @"中危", @"低危"],
                                      @"201": @[DoubleSpace, @"1a", @"1b", @"1c", @"2a", @"2b", @"2c", @"3a", @"3b", @"4"],
                                      @"202": @[DoubleSpace, @"0", @"1", @"2"],
                                      @"203": @[DoubleSpace, @"0", @"1"]};
    _lcfqLabel.text = @"T  N  M  ";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    BOOL isOneButton;
    for (UIButton *button in _oneButtonCollection) {
        if (button == sender) {
            isOneButton = YES;
            break;
        }
    }
    if (isOneButton) {
        for (UIButton *button in _oneButtonCollection) {
            if (sender.selected == YES && button != sender && button.selected == YES) {
                button.selected = NO;
            }
        }
    }

    Case2Data *globalData = GCase2();
    globalData.zdjgZDSelectItem = [self buttonValuesString];
}

- (NSString *)buttonValuesString
{
    NSMutableString *buttonValuesString = [NSMutableString string];
    for (UIButton *button in _buttonCollection) {
        if (button.isSelected) {
            [buttonValuesString appendFormat:@"%@,", _buttonValueDictionary[@(button.tag)]];
        }
    }
    if (buttonValuesString.length > 0) {
        [buttonValuesString deleteCharactersInRange:NSMakeRange(buttonValuesString.length - 1, 1)];
    } else {
        return nil;
    }
    return buttonValuesString;
}

#pragma mark - UIPickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *pickViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld", (long)pickerView.tag]];
    return [pickViewSource count];
}

#pragma mark UIPickerView Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *pickViewSource = [self.pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)pickerView.tag]];
    return pickViewSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //选择内容之后进行存储的操作
    Case2Data *globalData = GCase2();
    NSArray *pickerViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)pickerView.tag]];
    NSString *selectedString = pickerViewSource[row];
    selectedString = [selectedString isEqualToString:DoubleSpace]? nil : selectedString;
    switch (pickerView.tag) {
        case UIPickViewZDJG1T: // 诊断结果 T
        {
            globalData.zdjgTSelectItem = selectedString;
            [self refreshTNMLabel];
        }
            break;
        case UIPickViewZDJG1N: // 诊断结果 N
        {
            globalData.zdjgNSelectItem = selectedString;
            [self refreshTNMLabel];
        }
            break;
        case UIPickViewZDJG1M: // 诊断结果 M
        {
            globalData.zdjgMSelectItem = selectedString;
            [self refreshTNMLabel];
        }
            break;
        case UIPickViewZDJG1Evalute: //患者危险评估
        {
            if ([selectedString isEqualToString:@"高危"]) {
                globalData.zdjgPGSelectItem = @"gw";
            } else if ([selectedString isEqualToString:@"中危"]) {
                globalData.zdjgPGSelectItem = @"zw";
            } else if ([selectedString isEqualToString:@"低危"]) {
                globalData.zdjgPGSelectItem = @"dw";
            }
            _pgjgLabel.text = selectedString;
        }
            break;
        default:
            break;
    }
}

- (void)refreshTNMLabel
{
    Case2Data *globalData = GCase2();
    _lcfqLabel.text = [NSString stringWithFormat:@"T%@N%@M%@",globalData.zdjgTSelectItem?:DoubleSpace,globalData.zdjgNSelectItem?:DoubleSpace,globalData.zdjgMSelectItem?:DoubleSpace];
}

#pragma mark - IBAction
- (IBAction)confirmClick:(UIButton *)sender
{
    Case2Data *globalData = GCase2();
    if (globalData.zdjgZDSelectItem.length <= 0 ||
        globalData.zdjgTSelectItem.length <= 0 ||
        globalData.zdjgMSelectItem.length <= 0 ||
        globalData.zdjgNSelectItem.length <= 0 ||
        globalData.zdjgPGSelectItem.length <= 0
        ) {
        [GInstance() showInfoMessage:@"请完成所有的诊断!"];
        return;
    }

    if ([self.scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
        [self.scrollViewDelegate didClickConfirmButton:sender];
    }
}


@end
