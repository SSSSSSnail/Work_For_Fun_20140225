//
//  ZDJGS2C2ViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 2/8/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "ZDJGS2C3ViewController.h"

@interface ZDJGS2C3ViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonCollection;
- (IBAction)buttonClick:(UIButton *)sender;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonLeftCollection;

@property (strong, nonatomic) NSDictionary *buttonValueDictionary;

- (IBAction)confirmClick:(UIButton *)sender;

@end

@implementation ZDJGS2C3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.buttonValueDictionary = @{@203: @"jxxa", @204: @"jbwa", @205: @"zyff", @206: @"zyjz",
                                   @207: @"qlzs", @208: @"gxy"};
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;

    if ([_buttonLeftCollection containsObject:sender]) {
        for (UIButton *button in _buttonLeftCollection) {
            if (sender.selected == YES && button != sender && button.selected == YES) {
                button.selected = NO;
            }
        }
    }

    Case3Data *globalData = GCase3();
    globalData.zdjg2ZDSelectItem = [self buttonValuesString];
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

#pragma mark - IBAction
- (IBAction)confirmClick:(UIButton *)sender
{
    Case3Data *globalData = GCase3();
    NSString *checkString = globalData.zdjg2ZDSelectItem;
    
    if (checkString.length <= 0) {
        [GInstance() showInfoMessage:@"请完成所有的诊断!"];
        return;
    }

    if ([self.scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
        [self.scrollViewDelegate didClickConfirmButton:sender];
    }
}


@end
