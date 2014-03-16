//
//  ZDJGViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 15/3/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "ZDJGViewController.h"
#import "LLUIPickView.h"
#import "PickViewSourceBean.h"
typedef NS_ENUM(NSInteger, ComponentsTag)
{
    UIPickViewZDJG1Evalute = 200,
    UIPickViewZDJG1T = 201,
    UIPickViewZDJG1N = 202,
    UIPickViewZDJG1M = 203,
    UIButtonQLZS = 204,
    UIButtonJXX = 205,
    UIButtonJBWQ = 206,
    UIButtonZYX = 207,
    UIPickViewZLFATYQS = 210,
};
@interface ZDJGViewController ()

@property (weak, nonatomic) IBOutlet UILabel *qgRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *bmRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *jnRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lbjRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *pgjgLabel;
@property (weak, nonatomic) IBOutlet UILabel *lcfqLabel;

@property (weak, nonatomic) IBOutlet LLUIPickView *zdjglcfqTPickView;
@property (weak, nonatomic) IBOutlet LLUIPickView *zdjglcfqNPickView;
@property (weak, nonatomic) IBOutlet LLUIPickView *zdjglcfqMPickView;
@property (weak, nonatomic) IBOutlet LLUIPickView *zdjgEvaluatePickView;

@property (strong, nonatomic) NSDictionary *pickViewSourceDictionary;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *lczdButtonGroup;
@property (getter = isZDJGPreView, nonatomic) BOOL zdjgPreview;
@property (getter = isConformed, nonatomic) BOOL conformed;
@end

@implementation ZDJGViewController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    /* 诊断结果初始化 */
    self.pickViewSourceDictionary = @{@"200": @[doubleSpace, @"高危", @"中危", @"低危"],
                                      @"201": @[doubleSpace, @"1a", @"1b", @"1c", @"2a", @"2b", @"2c", @"3a", @"3b", @"4"],
                                      @"202": @[doubleSpace, @"0", @"1", @"2"],
                                      @"203": @[doubleSpace, @"0", @"1"]};
    
    _lcfqLabel.text = @"T  N  M  ";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Property

- (BOOL)isZDJGPreView
{
    return GInstance().globalData.currentIndex != 2;
}

- (BOOL)isConformed
{
    return _conformed;
}

#pragma mark -
#pragma mark UIPickerView Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *pickViewSource = [self.pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)pickerView.tag]];
    return pickViewSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //选择内容之后进行存储的操作
    switch (pickerView.tag) {
        case UIPickViewZDJG1T: // 诊断结果 T
        {
            NSArray *pickerViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)pickerView.tag]];
            NSString *selectedString = pickerViewSource[row];
            ((LLUIPickView *)pickerView).selectedOjbect = selectedString;
            _qgRateLabel.hidden = NO;
            _bmRateLabel.hidden = NO;
            _jnRateLabel.hidden = NO;
            _lbjRateLabel.hidden = NO;
            if ([selectedString isEqualToString:@"1c"]) {
                _qgRateLabel.text = @"器官局限性癌概率：80%";
                _bmRateLabel.text = @"包膜侵犯概率：18%";
                _jnRateLabel.text = @"精囊侵犯概率：1%";
                _lbjRateLabel.text = @"淋巴结转移概率：0";
            } else if ([selectedString isEqualToString:@"2a"]) {
                _qgRateLabel.text = @"器官局限性癌概率：73%";
                _bmRateLabel.text = @"包膜侵犯概率：26%";
                _jnRateLabel.text = @"精囊侵犯概率：1%";
                _lbjRateLabel.text = @"淋巴结转移概率：0";
            } else if ([selectedString isEqualToString:@"2b"] || [_zdjglcfqTPickView.selectedOjbect isEqualToString:@"2c"]){
                _qgRateLabel.text = @"器官局限性癌概率：58%";
                _bmRateLabel.text = @"包膜侵犯概率：38%";
                _jnRateLabel.text = @"精囊侵犯概率：4%";
                _lbjRateLabel.text = @"淋巴结转移概率：1%";
            } else {
                _qgRateLabel.hidden = YES;
                _bmRateLabel.hidden = YES;
                _jnRateLabel.hidden = YES;
                _lbjRateLabel.hidden = YES;
            }
            // 添加label
            _lcfqLabel.text = [NSString stringWithFormat:@"T%@N%@M%@",_zdjglcfqTPickView.selectedOjbect,_zdjglcfqNPickView.selectedOjbect,_zdjglcfqMPickView.selectedOjbect];
            
        }
            break;
        case UIPickViewZDJG1M: // 诊断结果 M
        case UIPickViewZDJG1N: // 诊断结果 N
        {
            NSArray *pickerViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)pickerView.tag]];
            ((LLUIPickView *)pickerView).selectedOjbect = pickerViewSource[row];
            // 添加label
            _lcfqLabel.text = [NSString stringWithFormat:@"T%@N%@M%@",_zdjglcfqTPickView.selectedOjbect,_zdjglcfqNPickView.selectedOjbect,_zdjglcfqMPickView.selectedOjbect];
        }
            break;
        case UIPickViewZDJG1Evalute: //患者危险评估
        {
            NSArray *pickerViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)pickerView.tag]];
            switch (row) {
                case 0:
                    ((LLUIPickView *)pickerView).selectedOjbect = @"";
                    break;
                    case 1:
                {
                    ((LLUIPickView *)pickerView).selectedOjbect = @"gw";
                }
                    break;
                    case 2:
                {
                    ((LLUIPickView *)pickerView).selectedOjbect = @"zw";
                }
                    break;
                    case 3:
                {
                    ((LLUIPickView *)pickerView).selectedOjbect = @"dw";
                }
                default:
                    break;
            }
            _pgjgLabel.text = pickerViewSource[row];
        }
            break;
        default:
            break;
    }
}


- (BOOL)hasCompletedPickViewSelctionZDJGPage
{
    if ([_zdjglcfqTPickView.selectedOjbect isEqualToString:doubleSpace] ||
        [_zdjglcfqMPickView.selectedOjbect isEqualToString:doubleSpace] ||
        [_zdjglcfqNPickView.selectedOjbect isEqualToString:doubleSpace] ||
        [_zdjgEvaluatePickView.selectedOjbect isEqualToString:doubleSpace]) {
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark UIPickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *pickViewSource = [_pickViewSourceDictionary objectForKey:[NSString stringWithFormat:@"%ld", (long)pickerView.tag]];
    return [pickViewSource count];
}

#pragma mark - IBAction

- (IBAction)confirmClick:(UIButton *)sender
{
    //save data
    
    if (![self checkValue]){
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"警 告" message:@"请完成所有的选项 !" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alterView show];
        return;
    };
    
    for (UIButton *button in _lczdButtonGroup) {
        if (button.isSelected) {
            GInstance().globalData.zdjgZDSelectItem = [self buttonValue];
            break;
        }
    }
    GInstance().globalData.zdjgTSelectItem = _zdjglcfqTPickView.selectedOjbect;
    GInstance().globalData.zdjgMSelectItem = _zdjglcfqMPickView.selectedOjbect;
    GInstance().globalData.zdjgNSelectItem = _zdjglcfqNPickView.selectedOjbect;
    GInstance().globalData.zdjgPGSelectItem = _zdjgEvaluatePickView.selectedOjbect;
    
    if ([_scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
        [_scrollViewDelegate didClickConfirmButton:sender];
    }
}

- (IBAction)refreshButtonGroup:(UIButton *)sender
{
    if (sender.isSelected) {
        return;
    }
    for (UIButton *button in _lczdButtonGroup) {
        if (button == sender) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
    }
}

- (BOOL)checkValue
{
    BOOL noCheck = YES;
    for (UIButton *button in _lczdButtonGroup) {
        if (button.isSelected) {
            noCheck = NO;
            break;
        }
    }
    if (noCheck) {
        return NO;
    }
    if ([_zdjgEvaluatePickView selectedRowInComponent:0] == 0) {
        return NO;
    }
    if ([_zdjglcfqNPickView selectedRowInComponent:0] == 0 ||
        [_zdjglcfqMPickView selectedRowInComponent:0] == 0 ||
        [_zdjglcfqTPickView selectedRowInComponent:0] == 0) {
        return NO;
    }
    return YES;
}


- (NSString *)buttonValue
{
    NSInteger index = 0;
    NSDictionary *sourceDictionary = @{@"204": @"bph",
                                       @"205": @"jxa",
                                       @"206": @"jxw",
                                       @"207": @"zya"};
    for (UIButton *button in _lczdButtonGroup) {
        if (button.isSelected) {
            index = button.tag;
            break;
        }
    }
    if (index == 0) {
        return @"";
    } else {
        return [sourceDictionary objectForKey:[NSString stringWithFormat:@"%ld",index]];
    }
}

- (NSInteger)buttonSelected:(NSString *)item
{
    NSDictionary *sourceDictionary = @{@"204": @"bph",
                                       @"205": @"jxa",
                                       @"206": @"jxw",
                                       @"207": @"zya"};
    NSInteger index = 0;
    for (NSString *key in sourceDictionary) {
        if ([sourceDictionary[key] isEqualToString:item]) {
            index = key.integerValue;
            break;
        }
    }
    return index;
}

- (PickViewSourceBean *)pingguPickviewSelectIndex:(NSString *)item
{
    if ([item isEqualToString:@"gw"]) {
        PickViewSourceBean *bean = [[PickViewSourceBean alloc] initWith:@"1" value:@"高危"];
        return bean;
    } else if ([item isEqualToString:@"zw"]) {
        PickViewSourceBean *bean = [[PickViewSourceBean alloc] initWith:@"2" value:@"中危"];
        return bean;
    } else if ([item isEqualToString:@"dw"]) {
        PickViewSourceBean *bean = [[PickViewSourceBean alloc] initWith:@"3" value:@"低危"];
        return bean;
    } else {
        PickViewSourceBean *bean = [[PickViewSourceBean alloc] initWith:@"0" value:doubleSpace];
        return bean;
    }
}

- (void)loadDataFromGlobalData
{
    LLGlobalData *data = GInstance().globalData;
//    data.zdjgZDSelectItem = @"bph";
//    data.zdjgTSelectItem = @"1c";
//    data.zdjgMSelectItem = @"1";
//    data.zdjgNSelectItem = @"0";
//    data.zdjgPGSelectItem = @"gw";
    UIView *view = [self.view viewWithTag:[self buttonSelected:data.zdjgZDSelectItem]];
    if ([view isKindOfClass:[UIButton class]]) {
        ((UIButton *)view).selected = YES;
    }
    PickViewSourceBean *bean = [self pingguPickviewSelectIndex:data.zdjgPGSelectItem];
    NSString *tItem = data.zdjgTSelectItem;
    [_zdjglcfqTPickView selectRow:[self pickviewSelectItem:tItem key:@"201"] inComponent:0 animated:NO];
    [_zdjglcfqMPickView selectRow:[self pickviewSelectItem:data.zdjgMSelectItem key:@"203"] inComponent:0 animated:NO];
    [_zdjglcfqNPickView selectRow:[self pickviewSelectItem:data.zdjgNSelectItem key:@"202"] inComponent:0 animated:NO];
    [_zdjgEvaluatePickView selectRow:bean.key.integerValue inComponent:0 animated:NO];
    
    
    _qgRateLabel.hidden = NO;
    _bmRateLabel.hidden = NO;
    _jnRateLabel.hidden = NO;
    _lbjRateLabel.hidden = NO;
    if ([tItem isEqualToString:@"1c"]) {
        _qgRateLabel.text = @"器官局限性癌概率：80%";
        _bmRateLabel.text = @"包膜侵犯概率：18%";
        _jnRateLabel.text = @"精囊侵犯概率：1%";
        _lbjRateLabel.text = @"淋巴结转移概率：0";
    } else if ([tItem isEqualToString:@"2a"]) {
        _qgRateLabel.text = @"器官局限性癌概率：73%";
        _bmRateLabel.text = @"包膜侵犯概率：26%";
        _jnRateLabel.text = @"精囊侵犯概率：1%";
        _lbjRateLabel.text = @"淋巴结转移概率：0";
    } else if ([tItem isEqualToString:@"2b"] || [tItem isEqualToString:@"2c"]){
        _qgRateLabel.text = @"器官局限性癌概率：58%";
        _bmRateLabel.text = @"包膜侵犯概率：38%";
        _jnRateLabel.text = @"精囊侵犯概率：4%";
        _lbjRateLabel.text = @"淋巴结转移概率：1%";
    } else {
        _qgRateLabel.hidden = YES;
        _bmRateLabel.hidden = YES;
        _jnRateLabel.hidden = YES;
        _lbjRateLabel.hidden = YES;
    }
    
    _zdjgEvaluatePickView.selectedOjbect = bean.value;
    _lcfqLabel.text = [NSString stringWithFormat:@"T%@N%@M%@",_zdjglcfqTPickView.selectedOjbect,_zdjglcfqNPickView.selectedOjbect,_zdjglcfqMPickView.selectedOjbect];
    _pgjgLabel.text = bean.value;
}

- (NSInteger)pickviewSelectItem:(NSString *)item key:(NSString *)key
{
    if (!item) {
        return 0;
    }
    NSArray *itemArray = _pickViewSourceDictionary[key];
    ((LLUIPickView *)[self.view viewWithTag:key.intValue]).selectedOjbect = item;
    return [itemArray indexOfObject:item];
}

@end
