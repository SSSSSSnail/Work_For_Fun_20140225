//
//  ZLFAC2ViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 27/7/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "ZLFAC3ViewController.h"
#import "Case3Data.h"

typedef NS_ENUM(NSInteger, CurrentStep) {
    CurrentStepOne,
    CurrentStepTwo,
    CurrentStepThree
};

typedef NS_ENUM(NSInteger, CurrentState) {
    CurrentStateFAXZ,
    CurrentStateYWXZ,
    CurrentStateShowResult,
    CurrentStateWithNext,
    CurrentStateBCXZ,
    CurrentStateBC,
    CurrentStateMustBC,
    CurrentStateFinish
};

static NSString * const DoubleSpace = @"  ";

@interface ZLFAC3ViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *sectionAnimationView;
@property (weak, nonatomic) IBOutlet UIView *section1View;
@property (weak, nonatomic) IBOutlet UIView *section2View;
@property (weak, nonatomic) IBOutlet UIImageView *section2BGImageView;



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
/*
 segment
 */
@property (weak, nonatomic) IBOutlet UISegmentedControl *gzsbkSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gzspqSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *wflSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *nfmSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hlSegmentedControl;

@property (strong, nonatomic) NSArray *segmentedControls;

@property (nonatomic, strong) UIView *showedView;


/*
 view
 */
@property (weak, nonatomic) IBOutlet UIView *gzsbkView;
@property (weak, nonatomic) IBOutlet UIView *gzspqView;
@property (weak, nonatomic) IBOutlet UIView *wflMasterView;
@property (weak, nonatomic) IBOutlet UIView *gzspqMasterView;

@property (weak, nonatomic) IBOutlet UIView *nfmView;
@property (weak, nonatomic) IBOutlet UIView *hlMasterView;


@property (weak, nonatomic) IBOutlet UIButton *gzsbkZhiguButton;

@property (weak, nonatomic) IBOutlet UIButton *gzsbkFuqiangButton;
@property (strong, nonatomic) NSArray *gzsbkArray;

@property (weak, nonatomic) IBOutlet UIButton *gzspqZhiguButton;
@property (weak, nonatomic) IBOutlet UIButton *gzspqFuqiangButton;

@property (strong, nonatomic) NSArray *gzspqArray;

@property (weak, nonatomic) IBOutlet UIButton *nfmShoushuButton;
@property (weak, nonatomic) IBOutlet UIButton *nfmZuidaButton;

@property (strong, nonatomic) NSArray *nfmArray;

@property (weak, nonatomic) IBOutlet UIView *nfmZuidazuduanSubView;
@property (weak, nonatomic) IBOutlet UIButton *nfmZuidaChixuButton;
@property (weak, nonatomic) IBOutlet UIButton *nfmZuidaJianxieButton;
@property (strong, nonatomic) NSArray *zuidaArray;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (assign, nonatomic) CurrentState state;
@end

@implementation ZLFAC3ViewController

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

    
    _section2PickerView1.dataSource = self;
    _section2PickerView1.delegate = self;
    _section2PickerView2.dataSource = self;
    _section2PickerView2.delegate = self;
    
    self.segmentedControls = @[_gzsbkSegmentedControl, _gzspqSegmentedControl, _wflSegmentedControl, _nfmSegmentedControl, _hlSegmentedControl];
    
    for (UISegmentedControl *view in _segmentedControls) {
        [view addTarget:self action:@selector(segmentedValueChanged:) forControlEvents:UIControlEventValueChanged];
        view.selectedSegmentIndex = 1;
    }
    
    self.gzsbkArray = @[_gzsbkZhiguButton, _gzsbkFuqiangButton];
    
    self.gzspqArray = @[_gzspqZhiguButton, _gzspqFuqiangButton];
    
    self.nfmArray = @[_nfmZuidaButton, _nfmShoushuButton];
    self.zuidaArray = @[_nfmZuidaJianxieButton, _nfmZuidaChixuButton];
    
    for (UIButton *view in _gzsbkArray) {
        [view addTarget:self action:@selector(gzsbkClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (UIButton *view in _gzspqArray) {
        [view addTarget:self action:@selector(gzspqCick:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (UIButton *view in _nfmArray) {
        [view addTarget:self action:@selector(nfmClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (UIButton *view in _zuidaArray) {
        [view addTarget:self action:@selector(zuidaClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    _nfmZuidazuduanSubView.hidden = YES;
    _state = CurrentStateFAXZ;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UISegmentedControl valueChanged
- (void)segmentedValueChanged:(UISegmentedControl *)seg
{
//    self sh
    
    BOOL isGZS = seg == _gzsbkSegmentedControl || seg == _gzspqSegmentedControl;
    
    BOOL selection = seg.selectedSegmentIndex == 0;
    
    
    
    if (_state == CurrentStateFAXZ) {
        if (seg == _nfmSegmentedControl) {
            for (UISegmentedControl *segment in _segmentedControls) {
                if (segment == _nfmSegmentedControl) {
                    continue;
                } else {
                    if (segment == _wflSegmentedControl || segment == _hlSegmentedControl) {
                        segment.enabled = segment.selectedSegmentIndex == 0 || seg.selectedSegmentIndex == 1;
                        continue;
                    } else {
                        if (segment.selectedSegmentIndex != 1) {
                            segment.selectedSegmentIndex = 1;
                            GCase3().zlfaLeftSelectedIndex = 0;
                        }
                        segment.enabled = !selection;
                    }
                }
            }
            
            GCase3().zlfaRightSelectedIndex = selection ? seg.tag : 0;
            
        } else {
            
            for (UISegmentedControl *segment in _segmentedControls) {
                if (seg == segment) {
                    continue;
                } else {
                    if (segment.selectedSegmentIndex != 1) {
                        segment.selectedSegmentIndex = 1;
                    }
                    
                    if (isGZS) {
                        segment.enabled = !selection;
                    } else {
                        if (segment == _nfmSegmentedControl) {
                            if (selection) {
                                segment.selectedSegmentIndex = 0;
                            } else {
                                segment.selectedSegmentIndex = 1;
                            }
                        }
                        segment.enabled = !selection;
                    }
                    
                }
            }
            GCase3().zlfaLeftSelectedIndex = selection ? seg.tag : 0;
            GCase3().zlfaRightSelectedIndex = _nfmSegmentedControl.selectedSegmentIndex == 0 ? 1 : 0;
        }
        [self task:seg.tag showOrHide:selection isBC:NO];
    } else if (_state == CurrentStateBCXZ) {
        if (seg == _nfmSegmentedControl) {
            GCase3().zlfaBuchongRightSelectedIndex = selection ? seg.tag : 0;
        } else {
            GCase3().zlfaBuchongLeftSelectedIndex = selection ? seg.tag : 0;
        }
        
        [self task:seg.tag showOrHide:selection isBC:YES];
    }
}

#pragma mark - 补充方案
- (IBAction)buchongfanganButtonClick:(UIButton *)sender
{
    Case3Data *globalData = GCase3();
    [[[UIAlertView alloc] initWithTitle:nil
                                message:@"您是否确认需要添加补充治疗?"
                       cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{

    }]
                       otherButtonItems:[RIButtonItem itemWithLabel:@"确认" action:^{
        _titleLabel.text = @"选择补充治疗方案";

        _danyifuzhuView.hidden = YES;
        _fuzhuView.hidden = NO;

        _state = CurrentStateBCXZ;
        _confirmButton.hidden = NO;
        
        BOOL isM4 = globalData.zlfaLeftSelectedIndex == 4;
        
        for (UISegmentedControl *segmentedControl in _segmentedControls) {
            if (segmentedControl.tag == 1) {
                segmentedControl.enabled = YES;
            } else if (segmentedControl.tag == 3) {
                segmentedControl.enabled = isM4;
            } else {
                segmentedControl.enabled = NO;
            }
        }
        
        if (isM4) {
            _gzsbkView.userInteractionEnabled = NO;
        } else {
            _gzspqView.userInteractionEnabled = NO;
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

     }], nil] show];
}

#pragma mark - UIPickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *pickViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%@", @(pickerView.tag)]];
    return [pickViewSource count];
}

#pragma mark UIPickerView Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *pickViewSource = [self.pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%@", @(pickerView.tag)]];
    return pickViewSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    Case3Data *globalData = GCase3();
    NSArray *pickerViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%@", @(pickerView.tag)]];
    NSString *selectedString = pickerViewSource[row];
    selectedString = [selectedString isEqualToString:DoubleSpace] ? nil : selectedString;
    if (pickerView.tag == 11) {
        if (globalData.zlfaRightSelectedIndex != 0) {
            globalData.zlfaRightYWName1 = selectedString;
        } else {
            globalData.zlfaBuchongRightYWName1 = selectedString;
        }
    }
    if (pickerView.tag == 12) {
        if (globalData.zlfaRightSelectedIndex != 0) {
            globalData.zlfaRightYWName2 = selectedString;
        } else {
            globalData.zlfaBuchongRightYWName2 = selectedString;
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
        [self taskList:sender];
        
        if (_state == CurrentStateShowResult) {
            _titleLabel.text = @"手术去势治疗";
        } else if (_state == CurrentStateYWXZ) {
            _titleLabel.text = @"最大限度雄激素阻断";
        }
        
    }], nil] show];
}

- (void)taskList:(UIButton *)sender
{
    Case3Data *globalData = GCase3();
    _titleLabel.text = @"";
    if (_state == CurrentStateFAXZ) {
        NSArray *arr = [self countM];
        NSString *imageName = nil;
        if (arr.count > 1) {
            imageName = [NSString stringWithFormat:@"c3M%@_%@", arr[0], arr[1]];
        } else {
            imageName = [NSString stringWithFormat:@"c3M%@_1", arr[0]];
        }
        
        _state = [self calcState];
        
        _section2BGImageView.image = [UIImage imageNamed:imageName];
        [UIView transitionWithView:_sectionAnimationView
                          duration:0.8
                           options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                        animations:^{
                            _section1View.hidden = YES;
                            _section2View.hidden = NO;
                            
                            BOOL needHideYWXZ = _state != CurrentStateYWXZ;
                            _section2PickerView1.hidden = needHideYWXZ;
                            _section2PickerView2.hidden = needHideYWXZ;
                            
                            _buchongfanganButton.hidden = !(_state == CurrentStateMustBC || _state == CurrentStateBC);
                            
                            _confirmButton.hidden = _state == CurrentStateMustBC;
                            
                        }
                        completion:^(BOOL finished){
                            
                        }];
    } else if (_state == CurrentStateYWXZ || _state == CurrentStateBC || _state == CurrentStateShowResult) {
        _state = CurrentStateFinish;
        if ([self.scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
            [self.scrollViewDelegate didClickConfirmButton:sender];
        }
    } else if (_state == CurrentStateFinish) {
        if ([self.scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
            [self.scrollViewDelegate didClickConfirmButton:sender];
        }
    } else if (_state == CurrentStateWithNext) {
        NSString *imageName = nil;
        if (globalData.zlfaLeftSelectedIndex == 2 || globalData.zlfaLeftSelectedIndex == 3) {
            if (globalData.zlfaNeifenmiSelectedIndex == 1) {
                _state = CurrentStateShowResult;
            } else if (globalData.zlfaNeifenmiSelectedIndex == 2) {
                _state = CurrentStateYWXZ;
            }
            imageName = [NSString stringWithFormat:@"c3M1_%@", @(globalData.zlfaNeifenmiSelectedIndex)];
        } else if (globalData.zlfaLeftSelectedIndex == 4) {
            if (globalData.zlfaBuchongNeifenmiSelectedIndex == 1) {
                _state = CurrentStateShowResult;
            } else if (globalData.zlfaBuchongNeifenmiSelectedIndex == 2) {
                _state = CurrentStateYWXZ;
            }
            imageName = [NSString stringWithFormat:@"c3M1_%@", @(globalData.zlfaBuchongNeifenmiSelectedIndex)];
        }
        
        _section2BGImageView.image = [UIImage imageNamed:imageName];
        
        [UIView transitionWithView:_sectionAnimationView
                          duration:0.8
                           options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                        animations:^{
                            _section1View.hidden = YES;
                            _section2View.hidden = NO;
                            
                            BOOL needHideYWXZ = _state != CurrentStateYWXZ;
                            _section2PickerView1.hidden = needHideYWXZ;
                            _section2PickerView2.hidden = needHideYWXZ;
                        }
                        completion:^(BOOL finished){
                            
                        }];
    } else if (_state == CurrentStateBCXZ) {
        if (globalData.zlfaBuchongLeftSelectedIndex == 0) {
            
            if (globalData.zlfaBuchongNeifenmiSelectedIndex == 1) {
                _state = CurrentStateShowResult;
            } else if (globalData.zlfaBuchongNeifenmiSelectedIndex == 2) {
                _state = CurrentStateYWXZ;
            } else {
                _state = CurrentStateFinish;
                if ([self.scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
                    [self.scrollViewDelegate didClickConfirmButton:sender];
                }
                return;
            }
            NSString *imageName = [NSString stringWithFormat:@"c3M1_%@", @(globalData.zlfaBuchongNeifenmiSelectedIndex)];
            _section2BGImageView.image = [UIImage imageNamed:imageName];
            
            [UIView transitionWithView:_sectionAnimationView
                              duration:0.8
                               options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                            animations:^{
                                _section1View.hidden = YES;
                                _section2View.hidden = NO;
                                
                                BOOL needHideYWXZ = _state != CurrentStateYWXZ;
                                _section2PickerView1.hidden = needHideYWXZ;
                                _section2PickerView2.hidden = needHideYWXZ;
                                _buchongfanganButton.hidden = YES;
                            }
                            completion:^(BOOL finished){
                                
                            }];
        } else {
            NSString *imageName = nil;// ;
            if (globalData.zlfaLeftSelectedIndex == 4) {
                _state = CurrentStateWithNext;
                imageName = [NSString stringWithFormat:@"c3M3_1"];
            }
            _section2BGImageView.image = [UIImage imageNamed:imageName];
            [UIView transitionWithView:_sectionAnimationView
                              duration:0.8
                               options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionShowHideTransitionViews
                            animations:^{
                                _section1View.hidden = YES;
                                _section2View.hidden = NO;
                                
                                BOOL needHideYWXZ = _state != CurrentStateYWXZ;
                                _section2PickerView1.hidden = needHideYWXZ;
                                _section2PickerView2.hidden = needHideYWXZ;
                                _buchongfanganButton.hidden = YES;
                            }
                            completion:^(BOOL finished){
                                
                            }];
        }
    }
}
- (BOOL)checkValues
{
    Case3Data *globalData = GCase3();
    if (_state == CurrentStateFAXZ) {
        if (globalData.zlfaLeftSelectedIndex == 0) {
            if (globalData.zlfaRightSelectedIndex == 0) {
                [GInstance() showInfoMessage:@"请完成治疗方案选择!"];
                return NO;
            } else {
                if (globalData.zlfaNeifenmiSelectedIndex == 2) {
                    if (globalData.zlfaZuidaZuduanSelectedIndex == 2) {
                        [GInstance() showInfoMessage:@"根据该患者情况，不适合间歇!"];
                        return NO;
                    } else if (globalData.zlfaZuidaZuduanSelectedIndex == 0) {
                        [GInstance() showInfoMessage:@"请完成治疗方案选择!"];
                        return NO;
                    }
                } else if (globalData.zlfaNeifenmiSelectedIndex == 0) {
                    [GInstance() showInfoMessage:@"请完成治疗方案选择!"];
                    return NO;
                }
            }
        } else {
            if (globalData.zlfaLeftSelectedIndex == 2 || globalData.zlfaLeftSelectedIndex == 3) {
                if (globalData.zlfaRightSelectedIndex == 0) {
                    [GInstance() showInfoMessage:@"请完成治疗方案选择!"];
                    return NO;
                } else {
                    if (globalData.zlfaNeifenmiSelectedIndex == 0) {
                        [GInstance() showInfoMessage:@"请完成治疗方案选择!"];
                        return NO;
                    }
                    if (globalData.zlfaNeifenmiSelectedIndex == 2) {
                        if (globalData.zlfaZuidaZuduanSelectedIndex == 2) {
                            [GInstance() showInfoMessage:@"根据该患者情况，不适合间歇!"];
                            return NO;
                        } else if (globalData.zlfaZuidaZuduanSelectedIndex == 0) {
                            [GInstance() showInfoMessage:@"请完成治疗方案选择!"];
                            return NO;
                        }
                    }
                    
                }
            } else {
                if (globalData.zlfaLeftSelectedIndex == 4) {
                    if (globalData.zlfaGZSBikongSelectedIndex == 0) {
                        [GInstance() showInfoMessage:@"请完成治疗方案选择!"];
                        return NO;
                    }
                } else if (globalData.zlfaLeftSelectedIndex == 5) {
                    if (globalData.zlfaGZSPenqiangSelectedIndex == 0) {
                        [GInstance() showInfoMessage:@"请完成治疗方案选择!"];
                        return NO;
                    }
                }
            }
        }
    } else if (_state == CurrentStateBCXZ) {
        BOOL isM4 = globalData.zlfaLeftSelectedIndex == 4;
        if (isM4) {
            if (globalData.zlfaBuchongLeftSelectedIndex == 0 ||
                globalData.zlfaBuchongNeifenmiSelectedIndex == 0) {
                [GInstance() showInfoMessage:@"请完成治疗方案选择!"];
                return NO;
            } else if (globalData.zlfaBuchongNeifenmiSelectedIndex == 2) {
                if (globalData.zlfaBuchongZuidaZuduanSelectedIndex == 0) {
                    [GInstance() showInfoMessage:@"请完成治疗方案选择!"];
                    return NO;
                } else if (globalData.zlfaBuchongZuidaZuduanSelectedIndex == 2) {
                    [GInstance() showInfoMessage:@"根据该患者情况，不适合间歇!"];
                    return NO;
                }
            }
        } else {
            if (globalData.zlfaBuchongRightSelectedIndex == 1) {
                if (globalData.zlfaBuchongNeifenmiSelectedIndex == 2) {
                    if (globalData.zlfaBuchongZuidaZuduanSelectedIndex == 0) {
                        [GInstance() showInfoMessage:@"请完成治疗方案选择!"];
                        return NO;
                    } else if (globalData.zlfaBuchongZuidaZuduanSelectedIndex == 2) {
                        [GInstance() showInfoMessage:@"根据该患者情况，不适合间歇!"];
                        return NO;
                    }
                } else if (globalData.zlfaBuchongNeifenmiSelectedIndex == 0) {
                    [GInstance() showInfoMessage:@"请完成治疗方案选择!"];
                    return NO;
                }
            }
        }
    } else if (_state == CurrentStateYWXZ) {
        if (globalData.zlfaRightSelectedIndex != 0) {
            if (globalData.zlfaRightYWName1.length == 0 || globalData.zlfaRightYWName2.length == 0) {
                [GInstance() showInfoMessage:@"请完成治疗方案选择!"];
                return NO;
            }
        } else {
            if (globalData.zlfaBuchongRightYWName1.length == 0 || globalData.zlfaBuchongRightYWName2.length == 0) {
                [GInstance() showInfoMessage:@"请完成治疗方案选择!"];
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

#pragma mark
- (void)task:(NSInteger)selectIndex showOrHide:(BOOL)show isBC:(BOOL)BC
{
    switch (selectIndex) {
        case 1: {
            if (!BC) {
                if (!_gzspqView.isHidden) {
                    [self hideTaskView:_gzspqView showOrHide:NO];
                    [self resetGZSPQArray];
                    
                }
                if (!_gzsbkView.isHidden) {
                    [self hideTaskView:_gzsbkView showOrHide:NO];
                    [self resetGZSBKArray];
                }
            }
            [self hideTaskView:_nfmView showOrHide:show];
            if (!show) {
                [self resetNFMArray];
            }
            break;
        }
        case 2:
        case 3: {
            if (!BC) {
                
                [self hideTaskView:_nfmView showOrHide:show];
                if (!_gzspqView.isHidden) {
                    [self hideTaskView:_gzspqView showOrHide:NO];
                }
                if (!_gzsbkView.isHidden) {
                    [self hideTaskView:_gzsbkView showOrHide:NO];
                }
                [self resetButtonState];

            }
            break;
        }
        case 4: {
            if (!_nfmView.isHidden) {
                [self hideTaskView:_nfmView showOrHide:NO];
                [self resetNFMArray];
            }
            if (!_gzspqView.isHidden) {
                [self hideTaskView:_gzspqView showOrHide:NO];
                [self resetGZSPQArray];
            }
            [self hideTaskView:_gzsbkView showOrHide:show];
            if (!show) {
                [self resetGZSBKArray];
            }
            break;
        }
        case 5: {
            if (!_nfmView.isHidden) {
                [self hideTaskView:_nfmView showOrHide:NO];
                [self resetNFMArray];

            }
            if (!_gzsbkView.isHidden) {
                [self hideTaskView:_gzsbkView showOrHide:NO];
                [self resetGZSBKArray];
            }
            [self hideTaskView:_gzspqView showOrHide:show];
            if (!show) {
                [self resetGZSPQArray];
            }
            break;
        }
        default:
            break;
    }
}
- (void)taskBC:(NSInteger)selectIndex showOrHide:(BOOL)show
{
    //补充
    switch (selectIndex) {
        case 1 : {
            [self hideTaskView:_nfmView showOrHide:show];
            if (!show) {
                [self resetNFMArray];
            }
            break;
        }
            break;
            
        default:
            break;
    }
}

- (void)hideTaskView:(UIView *)view showOrHide:(BOOL)show
{
    CGFloat rate = show ? -1.0f : 1.0f;
    
    CGFloat height = CGRectGetHeight(view.frame) * rate;
    [UIView animateWithDuration:0.8f animations:^{
        if (view == _gzsbkView) {
            CGRect frame = _gzspqMasterView.frame;
            _gzspqMasterView.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) - height, CGRectGetWidth(frame), CGRectGetHeight(frame));
            frame = _wflMasterView.frame;
            _wflMasterView.frame =  CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) - height, CGRectGetWidth(frame), CGRectGetHeight(frame));
        } else if (view == _gzspqView) {
            CGRect frame = _wflMasterView.frame;
            _wflMasterView.frame =  CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) - height, CGRectGetWidth(frame), CGRectGetHeight(frame));
        } else if (view == _nfmView) {
            CGRect frame = _hlMasterView.frame;
            _hlMasterView.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) - height, CGRectGetWidth(frame), CGRectGetHeight(frame));

        }
    } completion:^(BOOL finished) {
        
    }];
    
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

#pragma mark
- (void)gzsbkClick:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        for (UIButton *view in _gzsbkArray) {
            if (view != sender && view.isSelected) {
                view.selected = NO;
            }
        }
        GCase3().zlfaGZSBikongSelectedIndex = sender.tag;
    } else {
        GCase3().zlfaGZSBikongSelectedIndex = 0;
    }

}

- (void)gzspqCick:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        for (UIButton *view in _gzspqArray) {
            if (view != sender && view.isSelected) {
                view.selected = NO;
            }
        }
        GCase3().zlfaGZSPenqiangSelectedIndex = sender.tag;
    } else {
        GCase3().zlfaGZSPenqiangSelectedIndex = 0;
    }
}

- (void)nfmClick:(UIButton *)sender
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
                                [self resetZuidaZuduanArray];
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
                                [self resetZuidaZuduanArray];
                            }];
        }
    }
    
    if (sender.isSelected) {
        if (_state == CurrentStateFAXZ) {
            GCase3().zlfaNeifenmiSelectedIndex = sender.tag;
        } else {
            GCase3().zlfaBuchongNeifenmiSelectedIndex = sender.tag;
        }
    } else {
        if (_state == CurrentStateFAXZ) {
            GCase3().zlfaNeifenmiSelectedIndex = 0;
        } else {
            GCase3().zlfaBuchongNeifenmiSelectedIndex = 0;
        }
        
    }
    
}

- (void)zuidaClick:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        for (UIButton *view in _zuidaArray) {
            if (view != sender && view.isSelected) {
                view.selected = NO;
            }
        }
        if (_state == CurrentStateFAXZ) {
            GCase3().zlfaZuidaZuduanSelectedIndex = sender.tag;
        } else {
            GCase3().zlfaBuchongZuidaZuduanSelectedIndex = sender.tag;
        }
    } else {
        if (_state == CurrentStateFAXZ) {
            GCase3().zlfaZuidaZuduanSelectedIndex = 0;
        } else {
            GCase3().zlfaBuchongZuidaZuduanSelectedIndex = 0;
        }
    }
}

#pragma mark
- (void)resetButtonState
{
    for (UIButton *button in _gzsbkArray) {
        if (button.isSelected) {
            button.selected = NO;
        }
    }
    for (UIButton *button in _gzspqArray) {
        if (button.isSelected) {
            button.selected = NO;
        }
    }
    for (UIButton *button in _nfmArray) {
        if (button.isSelected) {
            button.selected = NO;
        }
    }
    for (UIButton *button in _zuidaArray) {
        if (button.isSelected) {
            button.selected = NO;
        }
    }
    _nfmZuidazuduanSubView.hidden = YES;
}

- (void)resetZuidaZuduanArray
{
    [_zuidaArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = (UIButton *)obj;
        if (button.isSelected) {
            button.selected = NO;
        }
    }];
    _nfmZuidazuduanSubView.hidden = YES;
    if (_state == CurrentStateFAXZ) {
        GCase3().zlfaZuidaZuduanSelectedIndex = 0;
    } else {
        GCase3().zlfaBuchongZuidaZuduanSelectedIndex = 0;
    }
}

- (void)resetGZSBKArray
{
    [_gzsbkArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = (UIButton *)obj;
        if (button.isSelected) {
            button.selected = NO;
        }
    }];
    GCase3().zlfaGZSBikongSelectedIndex = 0;
}

- (void)resetGZSPQArray
{
    [_gzspqArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = (UIButton *)obj;
        if (button.isSelected) {
            button.selected = NO;
        }
    }];
    GCase3().zlfaGZSPenqiangSelectedIndex = 0;
}

- (void)resetNFMArray
{
    [_nfmArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = (UIButton *)obj;
        if (button.isSelected) {
            button.selected = NO;
        }
    }];
    if (_state == CurrentStateFAXZ) {
        GCase3().zlfaNeifenmiSelectedIndex = 0;
    } else {
        GCase3().zlfaBuchongNeifenmiSelectedIndex = 0;
    }
    [self resetZuidaZuduanArray];
}

- (NSArray *)countM
{
    if (GCase3().zlfaLeftSelectedIndex != 0) {
        NSUInteger secondNumber = 1;
        if (GCase3().zlfaLeftSelectedIndex == 4) {
            secondNumber = GCase3().zlfaGZSBikongSelectedIndex;
        } else if (GCase3().zlfaLeftSelectedIndex == 5) {
            secondNumber = GCase3().zlfaGZSPenqiangSelectedIndex;
        }
        return @[@(GCase3().zlfaLeftSelectedIndex), @(secondNumber)];
    } else {
        return @[@1, @(GCase3().zlfaNeifenmiSelectedIndex)];
    }
    return nil;
}

- (CurrentState)calcState
{
    Case3Data *globalData = GCase3();
    switch (_state) {
        case CurrentStateFAXZ: {
            if (globalData.zlfaLeftSelectedIndex == 2 || globalData.zlfaLeftSelectedIndex == 3) {
                return CurrentStateWithNext;
            } else if (globalData.zlfaLeftSelectedIndex == 4) {
                return CurrentStateMustBC;
            } else if (globalData.zlfaLeftSelectedIndex == 5) {
                return CurrentStateBC;
            } else {
                if (globalData.zlfaNeifenmiSelectedIndex == 1) {
                    return CurrentStateShowResult;
                } else {
                    return CurrentStateYWXZ;
                }
            }
            break;
        }
        case CurrentStateMustBC: {
            break;
        }
        case CurrentStateBCXZ: {
            break;
        }
        case CurrentStateYWXZ: {
            break;
        }
        case CurrentStateShowResult: {
            break;
        }
        case CurrentStateBC: {
            break;
        }
            
        default:
            break;
    }
    
    return CurrentStateFAXZ;
}

@end
