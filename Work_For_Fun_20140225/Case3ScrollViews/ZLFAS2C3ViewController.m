//
//  ZLFAS2C2ViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 2/8/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "ZLFAS2C3ViewController.h"
#import "Case3Data.h"

typedef NS_ENUM(NSInteger, CurrentStep) {
    CurrentStepOne,
    CurrentStepTwo,
    CurrentStepFinish
};




static NSString * const DoubleSpace = @"  ";

@interface ZLFAS2C3ViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

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


@property (weak, nonatomic) IBOutlet UIView *waifangliaoView;


/*
 tag 1
 */
@property (weak, nonatomic) IBOutlet UISegmentedControl *jixuyuanyouNFMSegmentedControl;
/*
 tag 2
 */
@property (weak, nonatomic) IBOutlet UISegmentedControl *hualiaoSegmentedControl;
/*
 tag 3
 */
@property (weak, nonatomic) IBOutlet UISegmentedControl *waifangliaoSegmentedControl;
/*
 tag 4
 */
@property (weak, nonatomic) IBOutlet UISegmentedControl *gutongzhiliaoSegmentedControl;
/*
 tag 5
 */
@property (weak, nonatomic) IBOutlet UISegmentedControl *erxianFNMSegmentedControl;
/*
 tag 6
 */
@property (weak, nonatomic) IBOutlet UISegmentedControl *linchuangyaowushiyanSegmentedControl;

@property (weak, nonatomic) IBOutlet UIButton *gutongfangliaoButton;
@property (weak, nonatomic) IBOutlet UIButton *gutonglvhuasiButton;
@property (weak, nonatomic) IBOutlet UIButton *cijishuButton;
@property (weak, nonatomic) IBOutlet UIButton *futaanButton;

@property (weak, nonatomic) IBOutlet UIButton *abitelongButton;
@property (weak, nonatomic) IBOutlet UIButton *enzaluanButton;

@property (strong, nonatomic) NSArray *m1_5SegmentArray;
@property (strong, nonatomic) NSArray *m1_5SegmentArray2;
@property (strong, nonatomic) NSArray *m6SegmentArray;

@property (strong, nonatomic) NSArray *linchuangyaowuArray;
@property (strong, nonatomic) NSArray *erxianNFMArray;
@property (strong, nonatomic) NSArray *gutongArray;

//@property (strong, nonatomic) u
@property (weak, nonatomic) IBOutlet UIImageView *gutongDetailImage;

@property (weak, nonatomic) IBOutlet UIView *nfmView;

@property (weak, nonatomic) IBOutlet UIButton *nfmShoushuButton;
@property (weak, nonatomic) IBOutlet UIButton *nfmZuidaButton;

@property (strong, nonatomic) NSArray *nfmArray;

@property (weak, nonatomic) IBOutlet UIView *nfmZuidazuduanSubView;
@property (weak, nonatomic) IBOutlet UIButton *nfmZuidaChixuButton;
@property (weak, nonatomic) IBOutlet UIButton *nfmZuidaJianxieButton;
@property (strong, nonatomic) NSArray *zuidaArray;

@property (weak, nonatomic) IBOutlet UISegmentedControl *nfmSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hl2SegmentedControl;

@property (weak, nonatomic) IBOutlet UIView *rightView2;
@property (weak, nonatomic) IBOutlet UIView *hlMasterView;
@property (strong, nonatomic) NSArray *segmentedControlArray6;

@property (assign, nonatomic) BOOL hasSSQS;
@end

@implementation ZLFAS2C3ViewController

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
    
    
    self.m1_5SegmentArray = @[_erxianFNMSegmentedControl, _hualiaoSegmentedControl, _linchuangyaowushiyanSegmentedControl];
    self.m1_5SegmentArray2 = @[_jixuyuanyouNFMSegmentedControl, _erxianFNMSegmentedControl];
    
    self.gutongArray = @[_gutongfangliaoButton, _gutonglvhuasiButton];
    self.erxianNFMArray = @[_cijishuButton, _futaanButton];
    self.linchuangyaowuArray = @[_abitelongButton, _enzaluanButton];
    self.nfmArray = @[_nfmZuidaButton, _nfmShoushuButton];
    self.zuidaArray = @[_nfmZuidaChixuButton, _nfmZuidaJianxieButton];
    
    self.segmentedControlArray6 = @[_hl2SegmentedControl, _waifangliaoSegmentedControl];
    
    for (UISegmentedControl *view in _m1_5SegmentArray) {
        [view addTarget:self action:@selector(segmentedValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    
    for (UISegmentedControl *view in _m1_5SegmentArray2) {
        [view addTarget:self action:@selector(segmentedValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    [_gutongzhiliaoSegmentedControl addTarget:self action:@selector(segmentedValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    for (UISegmentedControl *view in _segmentedControlArray6) {
        [view addTarget:self action:@selector(segmentedValueChangedM6:) forControlEvents:UIControlEventValueChanged];
    }
    
    [_nfmSegmentedControl addTarget:self action:@selector(segmentedValueChangedM6:) forControlEvents:UIControlEventValueChanged];
    
    for (UIButton *button in _gutongArray) {
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (UIButton *button in _erxianNFMArray) {
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (UIButton *button in _linchuangyaowuArray) {
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    for (UIButton *button in _nfmArray) {
        [button addTarget:self action:@selector(nfm:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    for (UIButton *button in _zuidaArray) {
        [button addTarget:self action:@selector(zuidazuduan:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _section2PickerView1.dataSource = self;
    _section2PickerView1.delegate = self;
    _section2PickerView2.dataSource = self;
    _section2PickerView2.delegate = self;
    
    _nfmZuidazuduanSubView.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh
{
    
    NSUInteger step1Number = GCase3().step1MNumber;
    switch (step1Number) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5: {
            [self m1_5];
            break;
        }
        case 6:{
            break;
        }
            default:

        break;
    }
}


- (void)m1_5
{
    Case3Data *globalData = GCase3();
    _waifangliaoView.hidden = YES;
    _rightView2.hidden = YES;
    if (globalData.zlfaNeifenmiSelectedIndex == 1 || globalData.zlfaBuchongNeifenmiSelectedIndex == 1) {
        /*
         手术
         */
        _hasSSQS = YES;
        _jixuyuanyouNFMSegmentedControl.enabled = NO;
        _jixuyuanyouNFMSegmentedControl.selectedSegmentIndex = 0;
        globalData.zlfa2RightSelectIndex = 1;
    }
}


- (IBAction)zlfa2SegmentedChanged:(UISegmentedControl *)sender
{
    
    Case3Data *globalData = GCase3();
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
        if (sender.tag == 3 && globalData.zlfa2SegmentSelectedIndex == 4) {
            for (UIButton *button in _chixujianxieButtonCollection) {
                button.selected = NO;
            }
            for (UIButton *button in _chixuButtonCollection) {
                button.selected = NO;
            }
            for (UIButton *button in _jianxieButtonCollection) {
                button.selected = NO;
            }
            globalData.zlfaChixuJianxieNeifenSelectedIndex = 0;
            globalData.zlfaChixuJianxieNeifenDetailSelectedIndex = 0;
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

        globalData.zlfa2SegmentSelectedIndex = sender.tag;
    } else {
        globalData.zlfa2SegmentSelectedIndex = 0;

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
            globalData.zlfaChixuJianxieNeifenSelectedIndex = 0;
            globalData.zlfaChixuJianxieNeifenDetailSelectedIndex = 0;
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
        globalData.zlfa2ErfenSelectedIndex = 0;
    }
}

- (IBAction)erxianButtonClick:(UIButton *)sender
{
    GCase3().zlfa2ErfenSelectedIndex = sender.tag;

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
    Case3Data *globalData = GCase3();
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

    globalData.zlfaChixuJianxieNeifenSelectedIndex = sender.tag;
    globalData.zlfaChixuJianxieNeifenDetailSelectedIndex = 0;

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
    GCase3().zlfaChixuJianxieNeifenDetailSelectedIndex = sender.tag;
}


- (BOOL)checkValues
{
    Case3Data *globalData = GCase3();
    NSInteger step = globalData.step1MNumber;
    if (globalData.zlfa2GutongSelecteIndex == 0) {
        [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
        return NO;
    }
    if (globalData.zlfa2GutongItemSelecteIndex == 0) {
        [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
        return NO;
    }
    if (step == 6) {
        if (globalData.zlfa2LeftSelectedIndex == 2) {
            if (![self validationNFM:NO]) {
                [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                return NO;
            }
            if (globalData.zlfa2ZuidaZuduanSelectedIndex == 2) {
                [GInstance() showInfoMessage:@"根据该患者情况，不适合间歇!"];
                return NO;
            }
            if (_currentStep == CurrentStepFinish) {
                if (globalData.zlfa2NeifenmiSelectedIndex == 2) {
                    if (globalData.zlfaNeifenmiYaowuName1.length == 0 || globalData.zlfaNeifenmiYaowuName2 == 0) {
                        [GInstance() showInfoMessage:@"请完成治疗药物选择。"];
                        return NO;
                    }
                }
            }
        } else {
            if (![self validationNFM:YES]) {
                [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                return NO;
            }
            if (globalData.zlfa2ZuidaZuduanSelectedIndex == 2) {
                [GInstance() showInfoMessage:@"根据该患者情况，不适合间歇!"];
                return NO;
            }
        }
        if (_currentStep == CurrentStepFinish) {
            if (globalData.zlfa2NeifenmiSelectedIndex == 2) {
                if (globalData.zlfaNeifenmiYaowuName1.length == 0 || globalData.zlfaNeifenmiYaowuName2 == 0) {
                    [GInstance() showInfoMessage:@"请完成治疗药物选择。"];
                    return NO;
                }
            }
        }
        
    } else {
        if (globalData.zlfa2RightSelectIndex == 0) {
            if (globalData.zlfa2LeftSelectedIndex == 0) {
                [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                return NO;
            }
            if (globalData.zlfa2LeftSelectedIndex == 5) {
                if (globalData.zlfa2ErfenSelectedIndex == 0) {
                    [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                    return NO;
                }
            } else if (globalData.zlfa2LeftSelectedIndex == 6) {
                if (globalData.zlfa2LinchuangYaowuSelectedIndex == 0) {
                    [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                    return NO;
                }
            }
        } else {
            if (globalData.zlfa2LeftSelectedIndex == 0) {
                [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                return NO;
            } else if (globalData.zlfa2LeftSelectedIndex == 6) {
                if (globalData.zlfa2LinchuangYaowuSelectedIndex == 0) {
                    [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                    return NO;
                }
            } else if (globalData.zlfa2LeftSelectedIndex == 5) {
                if (globalData.zlfa2ErfenSelectedIndex == 0) {
                    [GInstance() showInfoMessage:@"请完成治疗方案选择。"];
                    return NO;
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
    Case3Data *globalData = GCase3();
    _titleLabel.text = nil;
    if (globalData.step1MNumber == 6) {
        
        if (_currentStep == CurrentStepFinish) {
            if ([self.scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
                [self.scrollViewDelegate didClickConfirmButton:sender];
            }
            return;
        }
        NSString *imageName = nil;

        if (_currentStep == CurrentStepOne) {
            if (globalData.zlfa2LeftSelectedIndex != 0) {
                imageName = [NSString stringWithFormat:@"c3M%@_1", @(globalData.zlfa2LeftSelectedIndex)];
                if (globalData.zlfa2NeifenmiSelectedIndex != 0) {
                    _currentStep = CurrentStepTwo;
                } else {
                    _currentStep = CurrentStepFinish;
                    if (globalData.zlfa2RightSelectIndex == 0 && globalData.zlfa2LeftSelectedIndex == 2) {
                        [self taskList:nil];
                        return;
                    }
                }
                
            } else {
                imageName = [NSString stringWithFormat:@"c3M1_%@", @(globalData.zlfa2NeifenmiSelectedIndex)];
                _currentStep = CurrentStepFinish;
            }
            
        } else if (_currentStep == CurrentStepTwo) {
            imageName = [NSString stringWithFormat:@"c3M1_%@", @(globalData.zlfa2NeifenmiSelectedIndex)];
            _currentStep = CurrentStepFinish;
        }
        
        _section2BGImageView.image = [UIImage imageNamed:imageName];
        [UIView transitionWithView:_sectionAnimationView
                          duration:0.8
                           options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                        animations:^{
                            _section1View.hidden = YES;
                            _section2View.hidden = NO;
                            
                            if (globalData.zlfa2NeifenmiSelectedIndex == 2) {
                                if (_currentStep == CurrentStepFinish) {
                                    _section2PickerView1.hidden = NO;
                                    _section2PickerView2.hidden = NO;
                                }
                            }
                            
                        }
                        completion:^(BOOL finished){
                            
                        }];
    } else {
        if ([self.scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
            [self.scrollViewDelegate didClickConfirmButton:sender];
        }
    }
    
    /*
    
    if (_currentStep == CurrentStepOne) {
        _currentStep = CurrentStepTwo;
        if (globalData.zlfa2SegmentSelectedIndex == 1 ||
            globalData.zlfa2SegmentSelectedIndex == 2 ||
            globalData.zlfa2SegmentSelectedIndex == 3) {
            _titleLabel.text = @"治疗方案记录";
            NSString *imageName = @"";
            if (globalData.zlfa2SegmentSelectedIndex == 1) {
                imageName = @"c2zlfa2chigu";
            } else if (globalData.zlfa2SegmentSelectedIndex == 2) {
                imageName = @"c2zlfa2fuqiangjing";
            } else if (globalData.zlfa2SegmentSelectedIndex == 3) {
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
        } else if (globalData.zlfa2SegmentSelectedIndex == 4) {
            _titleLabel.text = @"选择具体治疗方法";

            NSUInteger detailSelectedIndex = globalData.zlfaChixuJianxieNeifenDetailSelectedIndex;

            globalData.zlfaNeifenmiYaowuName1 = nil;
            globalData.zlfaNeifenmiYaowuName2 = nil;
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
     */
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
    NSArray *pickViewSource = [self.pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld", (long)pickerView.tag]];
    return pickViewSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    Case3Data *globalData = GCase3();
    NSArray *pickerViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld", (long)pickerView.tag ]];
    NSString *selectedString = pickerViewSource[row];
    selectedString = [selectedString isEqualToString:DoubleSpace]? nil : selectedString;
    if (pickerView.tag == 11) {
        globalData.zlfaNeifenmiYaowuName1 = selectedString;
    }
    if (pickerView.tag == 12) {
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

/*
 * segmentedValueChanged
 */

- (void)segmentedValueChanged:(UISegmentedControl *)segmentedControl
{
    BOOL isYes = segmentedControl.selectedSegmentIndex == 0;
    if (isYes) {
        if ([_m1_5SegmentArray containsObject:segmentedControl]) {
            for (UISegmentedControl *segmented in _m1_5SegmentArray) {
                if (segmented != segmentedControl && segmented.selectedSegmentIndex != 1) {
                    segmented.selectedSegmentIndex = 1;
                    [self changedState:segmented.tag selected:NO];
                }
            }
        }
        
        if ([_m1_5SegmentArray2 containsObject:segmentedControl]) {
            if (!_hasSSQS) {
                for (UISegmentedControl *segmented in _m1_5SegmentArray2) {
                    
                    if (segmented != segmentedControl && segmented.selectedSegmentIndex != 1) {
                        segmented.selectedSegmentIndex = 1;
                        [self changedState:segmented.tag selected:NO];
                        [self segmentedControlChanged:segmented];
                    }
                }
            }
        }
        
        [self changedState:segmentedControl.tag selected:YES];
        [self segmentedControlChanged:segmentedControl];
    } else {
        [self changedState:segmentedControl.tag selected:NO];
        [self segmentedControlChanged:segmentedControl];
    }
}

- (void)segmentedValueChangedM6:(UISegmentedControl *)segmentedControl
{
    BOOL selection = segmentedControl.selectedSegmentIndex == 0;
    if (segmentedControl == _nfmSegmentedControl) {
        GCase3().zlfa2RightSelectIndex = selection ? segmentedControl.tag : 0;
        if (!selection) {
            [self resetNFMArray];
        }
        
        [self hideTaskView:_nfmView showOrHide:selection];
        
    } else {
        NSInteger tag = 0;
        if (selection) {
            tag = segmentedControl.tag;
            for (UISegmentedControl *segment in _segmentedControlArray6) {
                if (segmentedControl != segment && segment.selectedSegmentIndex == 0) {
                    segment.selectedSegmentIndex = 1;
                }
            }
        }
        
        GCase3().zlfa2LeftSelectedIndex = tag;
    }
}

- (void)hideTaskView:(UIView *)view showOrHide:(BOOL)show
{
    CGFloat rate = show ? -1.0f : 1.0f;
    
    CGFloat height = CGRectGetHeight(view.frame) * rate;
    
    CGRect frame = _hlMasterView.frame;
    _hlMasterView.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) - height, CGRectGetWidth(frame), CGRectGetHeight(frame));
    if (show) {
        [UIView transitionWithView:view
                          duration:0.8
                           options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                        animations:^{
                            view.hidden = NO;
                            
                        }
                        completion:^(BOOL finished){
                        }];
        
    } else {
        [UIView transitionWithView:view
                          duration:0.8f
                           options:UIViewAnimationOptionCurveEaseOut
                        animations:^{
                            view.hidden = YES;
                        } completion:^(BOOL finished) {
                            
                        }];
    }
    
}

- (void)segmentedControlChanged:(UISegmentedControl *)segmentedControl
{
    Case3Data *globalData = GCase3();
    BOOL isYes = segmentedControl.selectedSegmentIndex == 0;
    if (segmentedControl.tag == 1) {
        /*
         * 继续原有内分泌治疗
         */
        if (isYes) {
            globalData.zlfa2RightSelectIndex = segmentedControl.tag;
        } else {
            globalData.zlfa2RightSelectIndex = 0;
        }
        
    } else if (segmentedControl.tag == 2) {
        /*
         * 化疗
         */
        if (isYes) {
            globalData.zlfa2LeftSelectedIndex = segmentedControl.tag;
        } else {
            globalData.zlfa2LeftSelectedIndex = 0;
        }
        
    } else if (segmentedControl.tag == 3) {
        /*
         * 外放疗
         */
        if (isYes) {
            globalData.zlfa2LeftSelectedIndex = segmentedControl.tag;
        } else {
            globalData.zlfa2LeftSelectedIndex = 0;
        }
    } else if (segmentedControl.tag == 4) {
        /*
         * 骨痛
         */
        if (isYes) {
            globalData.zlfa2GutongSelecteIndex = segmentedControl.tag;
        } else {
            globalData.zlfa2GutongSelecteIndex = 0;
        }
    } else {
        /*
         * 二线内分泌
         */
        /*
         * 临床药物试验
         */
        if (isYes) {
            globalData.zlfa2LeftSelectedIndex = segmentedControl.tag;
        } else {
            globalData.zlfa2LeftSelectedIndex = 0;
        }
    }
}

- (void)changedState:(NSInteger)tag selected:(BOOL)isSelected
{
    switch (tag) {
        case 1: {
            break;
        }
        case 2: {
            
            break;
        }
        case 3: {
            break;
        }
        case 4: {
            [self gutong:nil];
            [self buttonEnable:isSelected dataSource:_gutongArray];
            break;
        }
        case 5: {
            [self erxianNFM:nil];
            
            [self buttonEnable:isSelected dataSource:_erxianNFMArray];
            break;
        }
        case 6: {
            [self linchuangyaowu:nil];
            
            [self buttonEnable:isSelected dataSource:_linchuangyaowuArray];
            break;
        }
        default:
            break;
    }
    
    if (isSelected) {
        
    }
}


- (void)buttonClick:(UIButton *)button
{
    if ([_linchuangyaowuArray containsObject:button]) {
//        if (_linchuangyaowushiyanSegmentedControl.selectedSegmentIndex == 0) {
//            
//        }
        [self linchuangyaowu:button];
    } else if ([_gutongArray containsObject:button]) {
//        if (_gutongzhiliaoSegmentedControl.selectedSegmentIndex == 0) {
            [self gutong:button];
//        }
    } if ([_erxianNFMArray containsObject:button]) {
//        if (_erxianFNMSegmentedControl.selectedSegmentIndex == 0) {
            [self erxianNFM:button];
//        }
    }
}

- (void)linchuangyaowu:(UIButton *)button
{
    if (button.tag) {
        button.selected = !button.isSelected;
    }

    if (button.isSelected) {
        for (UIButton *view in _linchuangyaowuArray) {
            if (button != view && view.isSelected) {
                view.selected = NO;
            }
        }
        
        if (_linchuangyaowushiyanSegmentedControl.selectedSegmentIndex == 1) {
            _linchuangyaowushiyanSegmentedControl.selectedSegmentIndex = 0;
            [self segmentedValueChanged:_linchuangyaowushiyanSegmentedControl];
        }
        GCase3().zlfa2LinchuangYaowuSelectedIndex = button.tag;

    } else {
        GCase3().zlfa2LinchuangYaowuSelectedIndex = 0;
    }
}

- (void)erxianNFM:(UIButton *)button
{
    if (button.tag) {
        button.selected = !button.isSelected;
    }
    if (button.isSelected) {
        for (UIButton *view in _erxianNFMArray) {
            if (button != view && view.isSelected) {
                view.selected = NO;
            }
        }
        if (_erxianFNMSegmentedControl.selectedSegmentIndex == 1) {
            _erxianFNMSegmentedControl.selectedSegmentIndex = 0;
            [self segmentedValueChanged:_erxianFNMSegmentedControl];
        }
    }
    
    if (button.isSelected) {
        GCase3().zlfa2ErfenSelectedIndex = button.tag;
    } else {
        GCase3().zlfa2ErfenSelectedIndex = 0;
    }
   
}

- (void)gutong:(UIButton *)button
{
    if (button.tag) {
        button.selected = !button.isSelected;
    }
    if (button.isSelected) {
        for (UIButton *view in _gutongArray) {
            if (button != view && view.isSelected) {
                view.selected = NO;
            }
        }
        if (_gutongzhiliaoSegmentedControl.selectedSegmentIndex == 1) {
            _gutongzhiliaoSegmentedControl.selectedSegmentIndex = 0;
            [self segmentedValueChanged:_gutongzhiliaoSegmentedControl];
        }
    }
    
    UIImage *image = button.isSelected ? [UIImage imageNamed:[NSString stringWithFormat:@"c3r2gutongS%@", @(button.tag)]] : nil;

    [UIView transitionWithView:_gutongDetailImage
                      duration:0.8
                       options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                    animations:^{
                        _gutongDetailImage.image = image;
                    }
                    completion:^(BOOL finished){
                        
                    }];
    if (button.isSelected) {
        GCase3().zlfa2GutongItemSelecteIndex = button.tag;
    } else {
        GCase3().zlfa2GutongItemSelecteIndex = 0;
    }
    
}

- (void)buttonEnable:(BOOL)enable dataSource:(NSArray *)data
{
    [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = (UIButton *)obj;
        if (button.isSelected && !enable) {
            button.selected = NO;
        }
    }];
}


- (void)nfm:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (sender == _nfmZuidaButton) {
        if (_nfmShoushuButton.isSelected) {
            _nfmShoushuButton.selected = NO;
        }
        [UIView transitionWithView:_nfmZuidazuduanSubView
                          duration:0.5f
                           options:UIViewAnimationOptionTransitionFlipFromTop |
         UIViewAnimationOptionCurveEaseInOut |
         UIViewAnimationOptionShowHideTransitionViews
                        animations:^{
                            _nfmZuidazuduanSubView.hidden = !sender.isSelected;
                        } completion:^(BOOL finished) {
                            if (!sender.isSelected) {
                                [self resetZuidaZuduan];
                            }
                        }];
    } else {
        if (_nfmZuidaButton.isSelected) {
            _nfmZuidaButton.selected = NO;
            [UIView transitionWithView:_nfmZuidazuduanSubView
                              duration:0.5f
                               options:UIViewAnimationOptionTransitionFlipFromTop |
             UIViewAnimationOptionCurveEaseInOut |
             UIViewAnimationOptionShowHideTransitionViews
                            animations:^{
                                _nfmZuidazuduanSubView.hidden = YES;
                            } completion:^(BOOL finished) {
                                [self resetZuidaZuduan];
                            }];
        }
    }
    if (sender.isSelected) {
        GCase3().zlfa2NeifenmiSelectedIndex = sender.tag;
    } else {
        GCase3().zlfa2NeifenmiSelectedIndex = 0;
    }
    
}

- (void)zuidazuduan:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        for (UIButton *view in _zuidaArray) {
            if (view != sender && view.isSelected) {
                view.selected = NO;
            }
        }
        GCase3().zlfa2ZuidaZuduanSelectedIndex = sender.tag;
    } else {
        GCase3().zlfa2ZuidaZuduanSelectedIndex = 0;
    }
}

- (void)resetNFMArray
{
    [_nfmArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = (UIButton *)obj;
        if (button.isSelected) {
            button.selected = NO;
        }
    }];
    GCase3().zlfa2NeifenmiSelectedIndex = 0;
    [self resetZuidaZuduan];
}

- (void)resetZuidaZuduan
{
    [_zuidaArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = (UIButton *)obj;
        if (button.isSelected) {
            button.selected = NO;
        }
    }];
    _nfmZuidazuduanSubView.hidden = YES;
    GCase3().zlfa2ZuidaZuduanSelectedIndex = 0;
}

#pragma mark - 

- (BOOL)validationNFM:(BOOL)needSelected
{
    Case3Data *globalData = GCase3();
    if (needSelected) {
        if (globalData.zlfa2RightSelectIndex == 0) {
            return NO;
        }
        if (globalData.zlfa2NeifenmiSelectedIndex == 0) {
            return NO;
        } else if (globalData.zlfa2NeifenmiSelectedIndex == 2) {
            if (globalData.zlfa2ZuidaZuduanSelectedIndex == 0) {
                return NO;
            }
        }
    } else {
        if (globalData.zlfa2RightSelectIndex == 1) {
            if (globalData.zlfa2NeifenmiSelectedIndex == 0) {
                return NO;
            } else if (globalData.zlfa2NeifenmiSelectedIndex == 2) {
                if (globalData.zlfa2ZuidaZuduanSelectedIndex == 0) {
                    return NO;
                }
            }
        }
    }
    
    return YES;
}

@end
