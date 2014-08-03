//
//  BSHGC2ViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 2/8/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "BSHGC2ViewController.h"

@interface BSHGC2ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *bshgTable;
@property (weak, nonatomic) IBOutlet UIImageView *bshgImageView;

- (IBAction)confirmClick:(UIButton *)sender;

@end

@implementation BSHGC2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    UILabel *lcjcHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
    lcjcHeaderLabel.textAlignment = NSTextAlignmentCenter;
    lcjcHeaderLabel.text = @"病史回顾";
    lcjcHeaderLabel.font = [UIFont miscrosoftYaHeiFontWithSize:22.0f];
    lcjcHeaderLabel.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    _bshgTable.tableHeaderView = lcjcHeaderLabel;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh
{
    [_bshgTable reloadData];
    NSString *imageName = [NSString stringWithFormat:@"c2bshg1psaM%ld_%@", GCase2().step1MNumber, [self chixujianxieString2]];
    UIImage *image = [UIImage imageNamed:imageName];
    _bshgImageView.image = image;
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return ([self isTypeBetween2to7] ? 11 : 10);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"twoLabelCell"];
        UILabel *lab1 = (UILabel *)[cell viewWithTag:1];
        lab1.font = [UIFont miscrosoftYaHeiFontWithSize:14.0f];
        lab1.text = @"姓名：王右强" ;
        lab1.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];

        lab1 = (UILabel *)[cell viewWithTag:2];
        lab1.font = [UIFont miscrosoftYaHeiFontWithSize:14.0f];
        lab1.text = @"年龄：75岁" ;
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
        lab.text = [NSString stringWithFormat:@"检查：%@", [self linchuangjiancheString2]];
        lab.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    } else if (indexPath.row == 4) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
        UILabel *lab = (UILabel *)[cell viewWithTag:1];
        lab.text = [NSString stringWithFormat:@"诊断：%@", [self zhenduanString2]];
        lab.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    } else if (indexPath.row == 5) {
        //        危险评估为：低危
        cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
        UILabel *lab = (UILabel *)[cell viewWithTag:1];
        lab.text = [NSString stringWithFormat:@"危险评估为：%@", [self weixianxingpingguString2]];
    } else if (indexPath.row == 6) {
        //        临床分期cTNM：T2aN0M0
        cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
        UILabel *lab = (UILabel *)[cell viewWithTag:1];
        lab.text = [NSString stringWithFormat:@"临床分期cTNM：T%@N%@M%@",GCase2().zdjgTSelectItem, GCase2().zdjgNSelectItem, GCase2().zdjgMSelectItem];
    } else if (indexPath.row == 7) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"buttonLabelCell"];
        UILabel *lab = (UILabel *)[cell viewWithTag:1];
        lab.text = [NSString stringWithFormat:@"曾接受过：%@", [self loadZhiLiaoFangAn2]];
        UIButton *button1 = (UIButton *)[cell viewWithTag:2];
        Case2Data *gdata = GCase2();
        if (gdata.zlfaLeftSelectedIndex == 1 || gdata.zlfaLeftSelectedIndex == 2) {
            button1.selected = YES;
        }
        UIButton *button2 = (UIButton *)[cell viewWithTag:3];
        if (gdata.zlfaLeftSelectedIndex == 3 || gdata.zlfaWaifangliao == 1) {
            button2.selected = YES;
        }
        UIButton *button3 = (UIButton *)[cell viewWithTag:4];
        if (gdata.zlfaRightSelectedIndex == 2) {
            button3.selected = YES;
        }
        UIButton *button4 = (UIButton *)[cell viewWithTag:5];
        if (gdata.zlfaChixuJianxieSelectedIndex > 0 || gdata.zlfaFuzhuChixuJianxieSelectedIndex > 0) {
            button4.selected = YES;
        }
    } else if (indexPath.row == 8) {
        if ([self isTypeBetween2to7]) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
            UILabel *lab = (UILabel *)[cell viewWithTag:1];
            lab.frame = CGRectMake(CGRectGetMinX(lab.frame), CGRectGetMinY(lab.frame), CGRectGetWidth(lab.frame), 42);
            lab.text = @"术后病理：前列腺癌，Gleason Score 4+3（SUM=7）。右叶24张切片中可见7张有癌，左叶24张切片中可见13张有癌。左叶浸润被膜外及神经，PT3a，尖部切缘未见肿瘤。未累及尿道粘膜、双侧精囊腺、膀胱颈以及输精管。另送左闭孔淋巴结1个，右闭孔淋巴结4个，均未见转移癌。";
            lab.numberOfLines = 2;
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
            UILabel *lab = (UILabel *)[cell viewWithTag:1];
            lab.frame = CGRectMake(CGRectGetMinX(lab.frame), CGRectGetMinY(lab.frame), CGRectGetWidth(lab.frame), 21);
            lab.text = [NSString stringWithFormat:@"内分泌治疗方案：%@", [self loadYaoWuFangAn2]];
        }
    } else if (indexPath.row == 9) {
        if ([self isTypeBetween2to7]) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
            UILabel *lab = (UILabel *)[cell viewWithTag:1];
            lab.text = [NSString stringWithFormat:@"内分泌治疗方案：%@", [self loadYaoWuFangAn2]];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
            UILabel *lab = (UILabel *)[cell viewWithTag:1];
            lab.text = [NSString stringWithFormat:@"治疗药物：%@", [self loadYaoWu2]];
        }
    } else if (indexPath.row == 10) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
        UILabel *lab = (UILabel *)[cell viewWithTag:1];
        lab.text = [NSString stringWithFormat:@"治疗药物：%@", [self loadYaoWu2]];
    }
    return cell;
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isTypeBetween2to7]) {
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
- (BOOL)isTypeBetween2to7
{
    if (GCase2().step1MNumber >= 2 && GCase2().step1MNumber <= 7) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - 病史回顾
- (NSString *)zhenduanString2
{
    NSArray *itemsArray = [GCase2().zdjgZDSelectItem componentsSeparatedByString:@","];
    NSMutableString *itemsString = [NSMutableString string];
    for (NSString *item in itemsArray) {
        if ([item isEqualToString:@"jxa"]) {
            [itemsString appendFormat:@"%@, ", @"局限性前列腺癌"];
        } else if ([item isEqualToString:@"jxw"]) {
            [itemsString appendFormat:@"%@, ", @"局部晚期前列腺癌"];
        } else if ([item isEqualToString:@"zya"]) {
            [itemsString appendFormat:@"%@, ", @"转移性前列腺癌"];
        } else if ([item isEqualToString:@"bph"]) {
            [itemsString appendFormat:@"%@, ", @"前列腺增生"];
        } else if ([item isEqualToString:@"tnb"]) {
            [itemsString appendFormat:@"%@, ", @"2型糖尿病"];
        } else if ([item isEqualToString:@"gxy"]) {
            [itemsString appendFormat:@"%@, ", @"高血压"];
        }
    }
    if (itemsString.length > 2) {
        [itemsString deleteCharactersInRange:NSMakeRange(itemsString.length - 2, 2)];
    }
    return itemsString == nil ? @"" : itemsString;
}

- (NSString *)weixianxingpingguString2
{
    NSString *string = GCase2().zdjgPGSelectItem;
    if ([string isEqualToString:@"dw"]) {
        return @"低危";
    } else if ([string isEqualToString:@"zw"]) {
        return @"中危";
    } else if ([string isEqualToString:@"gw"]) {
        return @"高危";
    }
    return string == nil ? @"" : string;
}

- (NSString *)linchuangjiancheString2
{
    NSMutableString *string = [NSMutableString string];
    NSArray *array= @[@"直肠指诊", @"血常规", @"尿常规", @"血生化",
                      @"凝血筛查", @"心电图", @"超声心动", @"胸片",
                      @"B超", @"前列腺特异抗原PSA", @"睾酮", @"放射性核素骨扫描",
                      @"盆腔核磁共振MR", @"ECOG评分", @"CT检查", @"穿刺活检"];
    NSArray *indexArray = [GCase2().lcjcSelectedArrayStringR1 componentsSeparatedByString:@","];
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
    return string == nil ? @"" : string;
}

- (NSString *)loadZhiLiaoFangAn2
{
    Case2Data *gdata = GCase2();
    NSMutableString *fanganString = [NSMutableString string];
    if (gdata.zlfaLeftSelectedIndex == 1) {
        [fanganString appendFormat:@"%@, ", @"耻骨后根治性前列腺切除术"];
    } else if (gdata.zlfaLeftSelectedIndex == 2) {
        [fanganString appendFormat:@"%@, ", @"腹腔镜根治性前列腺切除术"];
    } else if (gdata.zlfaLeftSelectedIndex == 3) {
        [fanganString appendFormat:@"%@, ", @"外照射"];
    }

    if (gdata.zlfaWaifangliao == 1) {
        [fanganString appendFormat:@"%@, ", @"外照射"];
    }

    if (gdata.zlfaRightSelectedIndex == 2) {
        [fanganString appendFormat:@"%@, ", @"新辅助内分泌治疗"];
    } else if (gdata.zlfaRightSelectedIndex == 1) {
        [fanganString appendFormat:@"%@, ", @"单一内分泌治疗"];
    }

    if (fanganString.length > 2) {
        [fanganString deleteCharactersInRange:NSMakeRange(fanganString.length - 2, 2)];
    }
    return fanganString == nil ? @"" : fanganString;
}

- (NSString *)loadYaoWuFangAn2
{
    Case2Data *gdata = GCase2();
    NSMutableString *yaowufanganString = [NSMutableString string];
    if (gdata.zlfaChixujianxieDetailSelectedIndex == 1) {
        [yaowufanganString appendFormat:@"%@, ", @"单一药物去势治疗"];
    } else if (gdata.zlfaChixujianxieDetailSelectedIndex == 2) {
        [yaowufanganString appendFormat:@"%@, ", @"单一抗雄激素治疗"];
    } else if (gdata.zlfaChixujianxieDetailSelectedIndex == 3) {
        [yaowufanganString appendFormat:@"%@, ", @"最大限度雄激素阻断"];
    } else if (gdata.zlfaChixujianxieDetailSelectedIndex == 4) {
        [yaowufanganString appendFormat:@"%@, ", @"手术去势治疗"];
    }

    if (gdata.zlfaFuzhuChixuJianxieSelectedIndex == 1) {
        [yaowufanganString appendFormat:@"%@, ", @"持续"];
    } else if (gdata.zlfaFuzhuChixuJianxieSelectedIndex == 2) {
        [yaowufanganString appendFormat:@"%@, ", @"间歇"];
    }

    if (gdata.zlfaChixuJianxieSelectedIndex == 1) {
        [yaowufanganString appendFormat:@"%@, ", @"持续"];
    } else if (gdata.zlfaChixuJianxieSelectedIndex == 2) {
        [yaowufanganString appendFormat:@"%@, ", @"间歇"];
    }

    if (gdata.zlfaFuzhuChixujianxieDetailSelectedIndex == 1) {
        [yaowufanganString appendFormat:@"%@, ", @"单一药物去势治疗"];
    } else if (gdata.zlfaFuzhuChixujianxieDetailSelectedIndex == 2) {
        [yaowufanganString appendFormat:@"%@, ", @"单一抗雄激素治疗"];
    } else if (gdata.zlfaFuzhuChixujianxieDetailSelectedIndex == 3) {
        [yaowufanganString appendFormat:@"%@, ", @"最大限度雄激素阻断"];
    } else if (gdata.zlfaFuzhuChixujianxieDetailSelectedIndex == 4) {
        [yaowufanganString appendFormat:@"%@, ", @"手术去势治疗"];
    }

    if (yaowufanganString.length > 2) {
        [yaowufanganString deleteCharactersInRange:NSMakeRange(yaowufanganString.length - 2, 2)];
    }
    return yaowufanganString == nil ? @"" : yaowufanganString;
}

- (NSString *)loadYaoWu2
{
    Case2Data *gdata = GCase2();
    NSMutableString *yaowuString = [NSMutableString string];
    if (gdata.zlfaYaowuName1.length > 1) {
        [yaowuString appendFormat:@"%@, ", gdata.zlfaYaowuName1];
    }
    if (gdata.zlfaYaowuName2.length > 1) {
        [yaowuString appendFormat:@"%@, ", gdata.zlfaYaowuName2];
    }
    if (gdata.zlfaXinfuzhuYaowuName1.length > 1) {
        [yaowuString appendFormat:@"%@, ", gdata.zlfaXinfuzhuYaowuName1];
    }
    if (gdata.zlfaXinfuzhuYaowuName2.length > 1) {
        [yaowuString appendFormat:@"%@, ", gdata.zlfaXinfuzhuYaowuName2];
    }
    if (yaowuString.length > 2) {
        [yaowuString deleteCharactersInRange:NSMakeRange(yaowuString.length - 2, 2)];
    }
    return yaowuString == nil ? @"" : yaowuString;
}

- (NSString *)loadButtonString2
{
    NSMutableString *buttonString = [NSMutableString string];
    Case2Data *gdata = GCase2();
    if (gdata.zlfaLeftSelectedIndex == 1 || gdata.zlfaLeftSelectedIndex == 2) {
        [buttonString appendFormat:@"%d,", 0];
    }
    if (gdata.zlfaLeftSelectedIndex == 3 || gdata.zlfaWaifangliao == 1) {
        [buttonString appendFormat:@"%d,", 1];
    }
    if (gdata.zlfaRightSelectedIndex == 2) {
        [buttonString appendFormat:@"%d,", 2];
    }
    if (gdata.zlfaChixuJianxieSelectedIndex > 0 || gdata.zlfaFuzhuChixuJianxieSelectedIndex > 0) {
        [buttonString appendFormat:@"%d,", 3];
    }
    return buttonString == nil ? @"" : buttonString;
}

- (NSString *)chixujianxieString2
{
    NSUInteger mNumber = GCase2().step1MNumber;
    NSUInteger lastNumber = 0;
    if (mNumber == 3 || mNumber == 5) {
        lastNumber = GCase2().zlfaFuzhuChixuJianxieSelectedIndex;
    }
    if (mNumber == 8 || mNumber == 9) {
        lastNumber = GCase2().zlfaChixuJianxieSelectedIndex;
    }
    return [NSString stringWithFormat:@"%ld", (long)lastNumber];
}

- (IBAction)confirmClick:(UIButton *)sender
{
    if ([self.scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
        [self.scrollViewDelegate didClickConfirmButton:sender];
    }
}

@end
