//
//  HZQKViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 14/3/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "HZQKViewController.h"

@interface HZQKViewController ()<UITableViewDataSource>

- (IBAction)confirmClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UITableView *bshgTable;
@property (weak, nonatomic) IBOutlet UIImageView *bshgImageView;

@property (assign, nonatomic) BOOL isLocked;
@end

@implementation HZQKViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UILabel *lcjcHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
    lcjcHeaderLabel.textAlignment = NSTextAlignmentCenter;
    lcjcHeaderLabel.text = @"病史回顾";
    lcjcHeaderLabel.font = [UIFont miscrosoftYaHeiFontWithSize:22.0f];
    lcjcHeaderLabel.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    _bshgTable.tableHeaderView = lcjcHeaderLabel;

    _isLocked = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Reload Data
- (void)reloadViewDataForR2
{
    _bgImageView.hidden = YES;
    _bshgTable.hidden = NO;
    _bshgImageView.hidden = NO;
    BOOL isTypeBetween2to6 = [self isTypeBetween2to6];
    CGFloat viewHeight = isTypeBetween2to6 ? 420.0f : 365.0f;
    
    CGRect frame = _bshgTable.frame;
    _bshgTable.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), viewHeight);
    [_bshgTable reloadData];
    frame = _bshgImageView.frame;
    CGFloat yPosition = isTypeBetween2to6 ? 442.0f : 387;
    _bshgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bshg%ld.png",GInstance().globalData.r1Result]];
    _bshgImageView.frame = CGRectMake(CGRectGetMinX(frame), yPosition, CGRectGetWidth(frame), CGRectGetHeight(frame));

    _dateTimeLabel.text = GInstance().globalData.dateTimeOneMonth;
}

- (IBAction)confirmClick:(UIButton *)sender
{
    if ([_scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
        [_scrollViewDelegate didClickConfirmButton:sender];
    }
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return ([self isTypeBetween2to6] ? 11 : 10);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"twoLabelCell"];
        UILabel *lab1 = (UILabel *)[cell viewWithTag:1];
        lab1.font = [UIFont miscrosoftYaHeiFontWithSize:14.0f];
        lab1.text = @"姓名：徐XX" ;
        lab1.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];

        lab1 = (UILabel *)[cell viewWithTag:2];
        lab1.font = [UIFont miscrosoftYaHeiFontWithSize:14.0f];
        lab1.text = @"年龄：72岁" ;
        lab1.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"twoLabelCell"];
        UILabel *lab1 = (UILabel *)[cell viewWithTag:1];
        lab1.font = [UIFont miscrosoftYaHeiFontWithSize:14.0f];
        lab1.text = @"性别：男" ;
        lab1 = (UILabel *)[cell viewWithTag:2];
        lab1.font = [UIFont miscrosoftYaHeiFontWithSize:14.0f];
        lab1.text = @"职业：退休" ;
    } else if (indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
        UILabel *lab = (UILabel *)[cell viewWithTag:1];
        lab.text = @"主诉：体检发现PSA升高，要求入院治疗。";
        lab.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    } else if (indexPath.row == 3) {
//        检查：血常规、PSA、B超
        cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
        UILabel *lab = (UILabel *)[cell viewWithTag:1];
        lab.text = [NSString stringWithFormat:@"检查：%@", [self linchuangjiancheString]];
        lab.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    } else if (indexPath.row == 4) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
        UILabel *lab = (UILabel *)[cell viewWithTag:1];
        lab.text = [NSString stringWithFormat:@"诊断：%@", [self zhenduanString]];
        lab.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    } else if (indexPath.row == 5) {
//        危险评估为：低危
        cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
        UILabel *lab = (UILabel *)[cell viewWithTag:1];
        lab.text = [NSString stringWithFormat:@"危险评估为：%@", [self weixianxingpingguString]];
    } else if (indexPath.row == 6) {
//        临床分期cTNM：T2aN0M0
        cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
        UILabel *lab = (UILabel *)[cell viewWithTag:1];
        lab.text = [NSString stringWithFormat:@"临床分期cTNM：T%@N%@M%@",GInstance().globalData.zdjgTSelectItem, GInstance().globalData.zdjgNSelectItem, GInstance().globalData.zdjgMSelectItem];
    } else if (indexPath.row == 7) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"buttonLabelCell"];
        UILabel *lab = (UILabel *)[cell viewWithTag:1];
        lab.text = [NSString stringWithFormat:@"曾接受过：%@", [self loadZhiLiaoFangAn]];
        UIButton *button1 = (UIButton *)[cell viewWithTag:2];
        LLGlobalData *gdata = GInstance().globalData;
        if (gdata.zlfaLeftSelectedIndex == 1 || gdata.zlfaLeftSelectedIndex == 2) {
            button1.selected = YES;
        }
        UIButton *button2 = (UIButton *)[cell viewWithTag:3];
        if (gdata.zlfaLeftSelectedIndex == 3 || gdata.zlfaLeftSelectedIndex == 4 || [gdata.zlfaFuzhuOrZhaoShe isEqualToString:@"W"]) {
            button2.selected = YES;
        }
        UIButton *button3 = (UIButton *)[cell viewWithTag:4];
        if (gdata.zlfaRightSelectedIndex > 0) {
            button3.selected = YES;
        }
        UIButton *button4 = (UIButton *)[cell viewWithTag:5];
        if ([gdata.zlfaFuzhuOrZhaoShe isEqualToString:@"F"]) {
            button4.selected = YES;
        }
    } else if (indexPath.row == 8) {
        if ([self isTypeBetween2to6]) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
            UILabel *lab = (UILabel *)[cell viewWithTag:1];
            lab.frame = CGRectMake(CGRectGetMinX(lab.frame), CGRectGetMinY(lab.frame), CGRectGetWidth(lab.frame), 42);
            lab.text = @"术后病理：采用开放性前列腺癌根治术治疗方案。术后病理：Gleason分级4+3=7，肿瘤累及前列腺左叶，外周及尖部切缘阳性。左右闭孔淋巴结未见癌转移。";
            lab.numberOfLines = 2;
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
            UILabel *lab = (UILabel *)[cell viewWithTag:1];
            lab.frame = CGRectMake(CGRectGetMinX(lab.frame), CGRectGetMinY(lab.frame), CGRectGetWidth(lab.frame), 21);
            lab.text = [NSString stringWithFormat:@"内分泌治疗方案：%@", [self loadYaoWuFangAn]];
        }
    } else if (indexPath.row == 9) {
        if ([self isTypeBetween2to6]) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
            UILabel *lab = (UILabel *)[cell viewWithTag:1];
            lab.text = [NSString stringWithFormat:@"内分泌治疗方案：%@", [self loadYaoWuFangAn]];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
            UILabel *lab = (UILabel *)[cell viewWithTag:1];
            lab.text = [NSString stringWithFormat:@"治疗药物：%@", [self loadYaoWu]];
        }
    } else if (indexPath.row == 10) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
        UILabel *lab = (UILabel *)[cell viewWithTag:1];
        lab.text = [NSString stringWithFormat:@"治疗药物：%@", [self loadYaoWu]];
    }
    return cell;
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isTypeBetween2to6]) {
        if (indexPath.row == 7 || indexPath.row == 8) {
            return 55.0f;
        } else if (indexPath.row == 3){
            
        }
        return 30.0f;
    } else {
        if (indexPath.row == 7) {
            return 55.0f;
        } else if (indexPath.row == 3){
            
        }
        return 30.0f;
    }
}

#pragma mark - private Methods

- (BOOL)isTypeBetween2to6
{
    BCJZMResult r2Type = GInstance().globalData.r2Type;
    if (r2Type >= M2 && r2Type <= M6) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)zhenduanString
{
    NSArray *itemsArray = [GInstance().globalData.zdjgZDSelectItem componentsSeparatedByString:@","];
    NSMutableString *itemsString = [NSMutableString string];
    for (NSString *item in itemsArray) {
        if ([item isEqualToString:@"bph"]) {
            [itemsString appendFormat:@"%@, ", @"前列腺增生"];
        } else if ([item isEqualToString:@"jxa"]) {
            [itemsString appendFormat:@"%@, ", @"局限性前列腺癌"];
        } else if ([item isEqualToString:@"jxw"]) {
            [itemsString appendFormat:@"%@, ", @"局部晚期前列腺癌"];
        } else if ([item isEqualToString:@"zya"]) {
            [itemsString appendFormat:@"%@, ", @"转移性前列腺癌"];
        }
    }
    if (itemsString.length > 2) {
        [itemsString deleteCharactersInRange:NSMakeRange(itemsString.length - 2, 2)];
    }
    return itemsString;
}

- (NSString *)weixianxingpingguString
{
    NSString *string = GInstance().globalData.zdjgPGSelectItem;
    if ([string isEqualToString:@"dw"]) {
        return @"低危";
    } else if ([string isEqualToString:@"zw"]) {
        return @"中危";
    } else if ([string isEqualToString:@"gw"]) {
        return @"高危";
    }
    return @"";
}

- (NSString *)linchuangjiancheString
{
    NSMutableString *string = [NSMutableString string];
    NSArray *array= @[@"血常规", @"尿常规", @"血生化", @"凝血筛查",
                      @"直肠指诊", @"心电图", @"超声心动", @"胸片", @"B超",
                      @"前列腺特异抗原PSA", @"睾酮", @"放射性核素骨扫描", @"盆腔核磁共振MR",
                      @"ECOG评分", @"穿刺活检", @"CT检查"];
    NSArray *indexArray = [GInstance().globalData.lcjcSelectedArrayString componentsSeparatedByString:@","];
    if (indexArray.count > 0) {
        for (int i = 0; i < indexArray.count; i++) {
            if ([indexArray[i] isEqualToString:@""]) {
                continue;
            }
            NSString *index = indexArray[i];
            [string appendFormat:@"%@, ", array[index.integerValue]];
        }
    }
    if (string.length > 2) {
        [string deleteCharactersInRange:NSMakeRange(string.length - 2, 2)];
    }
    return string;
}

- (NSString *)loadZhiLiaoFangAn
{
    LLGlobalData *gdata = GInstance().globalData;
    NSMutableString *fanganString = [NSMutableString string];
    if (gdata.zlfaLeftSelectedIndex == 1) {
        [fanganString appendFormat:@"%@, ", @"耻骨后根治性前列腺切除术"];
    } else if (gdata.zlfaLeftSelectedIndex == 2) {
        [fanganString appendFormat:@"%@, ", @"腹腔镜根治性前列腺切除术"];
    } else if (gdata.zlfaLeftSelectedIndex == 3) {
        [fanganString appendFormat:@"%@, ", @"外照射"];
    } else if (gdata.zlfaLeftSelectedIndex == 4) {
        [fanganString appendFormat:@"%@, ", @"近距离放疗"];
    }

    if (gdata.zlfaRightSelectedIndex > 0) {
        [fanganString appendFormat:@"%@, ", @"新辅助内分泌治疗"];
    }

    if ([gdata.zlfaFuzhuOrZhaoShe isEqualToString:@"F"]) {
        [fanganString appendFormat:@"%@, ", @"辅助内分泌治疗"];
    } else if ([gdata.zlfaFuzhuOrZhaoShe isEqualToString:@"W"]) {
        [fanganString appendFormat:@"%@, ", @"外照射"];
    }

    if (fanganString.length > 2) {
        [fanganString deleteCharactersInRange:NSMakeRange(fanganString.length - 2, 2)];
    }
    return fanganString;
}

- (NSString *)loadYaoWuFangAn
{
    LLGlobalData *gdata = GInstance().globalData;
    NSMutableString *yaowufanganString = [NSMutableString string];
    if (gdata.zlfaRightSelectedIndex == 1) {
        [yaowufanganString appendFormat:@"%@, ", @"单一药物去势治疗"];
    } else if (gdata.zlfaRightSelectedIndex == 2) {
        [yaowufanganString appendFormat:@"%@, ", @"单一抗雄激素治疗"];
    } else if (gdata.zlfaRightSelectedIndex == 3) {
        [yaowufanganString appendFormat:@"%@, ", @"最大限度雄激素阻断"];
    }

    if ([gdata.zlfaFuzhuType isEqualToString:@"C"]) {
        [yaowufanganString appendFormat:@"%@, ", @"持续"];
    } else if ([gdata.zlfaFuzhuType isEqualToString:@"J"]) {
        [yaowufanganString appendFormat:@"%@, ", @"间歇"];
    }

    if (gdata.zlfaFuzhuSelectedIndex == 1) {
        [yaowufanganString appendFormat:@"%@, ", @"手术去势治疗"];
    } else if (gdata.zlfaFuzhuSelectedIndex == 2) {
        [yaowufanganString appendFormat:@"%@, ", @"单一药物去势治疗"];
    } else if (gdata.zlfaFuzhuSelectedIndex == 3) {
        [yaowufanganString appendFormat:@"%@, ", @"单一抗雄激素治疗"];
    } else if (gdata.zlfaFuzhuSelectedIndex == 4) {
        [yaowufanganString appendFormat:@"%@, ", @"最大限度雄激素阻断"];
    }

    if (yaowufanganString.length > 2) {
        [yaowufanganString deleteCharactersInRange:NSMakeRange(yaowufanganString.length - 2, 2)];
    }
    return yaowufanganString;
}

- (NSString *)loadYaoWu
{
    LLGlobalData *gdata = GInstance().globalData;
    NSMutableString *yaowuString = [NSMutableString string];
    if (gdata.zlfaXinFuZhuYaoWuSeg1.length > 1) {
        [yaowuString appendFormat:@"%@, ", gdata.zlfaXinFuZhuYaoWuSeg1];
    }
    if (gdata.zlfaXinFuZhuYaoWuSeg2.length > 1) {
        [yaowuString appendFormat:@"%@, ", gdata.zlfaXinFuZhuYaoWuSeg2];
    }
    if (gdata.zlfaFuzhuYaoWuSeg2.length > 1) {
        [yaowuString appendFormat:@"%@, ", gdata.zlfaFuzhuYaoWuSeg2];
    }
    if (gdata.zlfaFuzhuYaoWuSeg3.length > 1) {
        [yaowuString appendFormat:@"%@, ", gdata.zlfaFuzhuYaoWuSeg3];
    }
    if (yaowuString.length > 2) {
        [yaowuString deleteCharactersInRange:NSMakeRange(yaowuString.length - 2, 2)];
    }
    return yaowuString;
}

@end
