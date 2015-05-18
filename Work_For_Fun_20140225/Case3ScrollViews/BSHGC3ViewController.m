//
//  BSHGC2ViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 2/8/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "BSHGC3ViewController.h"

@interface BSHGC3ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *bshgTable;
@property (weak, nonatomic) IBOutlet UIImageView *bshgImageView;

- (IBAction)confirmClick:(UIButton *)sender;

@end

@implementation BSHGC3ViewController

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
    CGFloat viewHeight = [self isNeededShowBingli] ? 440.0f : 365.0f;
    CGRect frame = _bshgTable.frame;
    frame.size.height = viewHeight;
    _bshgTable.frame = frame;
    [_bshgTable reloadData];

    CGFloat yPosition = [self isNeededShowBingli] ? 462.0f : 387;
    frame = _bshgImageView.frame;
    frame.origin.y = yPosition;
    _bshgImageView.frame = frame;
    NSString *imageName = [NSString stringWithFormat:@"c3bshgM%@", @(GCase3().step1MNumber)];
    UIImage *image = [UIImage imageNamed:imageName];
    _bshgImageView.image = image;
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([self isNeededShowBingli] ? 11 : 10);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"twoLabelCell"];
        UILabel *lab1 = (UILabel *)[cell viewWithTag:1];
        lab1.font = [UIFont miscrosoftYaHeiFontWithSize:14.0f];
        lab1.text = @"姓名：张涛" ;
        lab1.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];

        lab1 = (UILabel *)[cell viewWithTag:2];
        lab1.font = [UIFont miscrosoftYaHeiFontWithSize:14.0f];
        lab1.text = @"年龄：64岁" ;
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
        lab.text = @"主诉：排尿困难，尿痛，要求入院治疗。";
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
        lab.text = [NSString stringWithFormat:@"临床分期cTNM：T%@N%@M%@",GCase3().zdjgTSelectItem, GCase3().zdjgNSelectItem, GCase3().zdjgMSelectItem];
    } else if (indexPath.row == 7) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"buttonLabelCell"];
        UILabel *lab = (UILabel *)[cell viewWithTag:1];
        lab.text = [NSString stringWithFormat:@"曾接受过：%@", [self loadZhiLiaoFangAn2]];
        /*
         2 手术
         3 外放疗
         4 内分泌
         5 化疗
         */
        UIButton *button1 = (UIButton *)[cell viewWithTag:2];
        Case3Data *gdata = GCase3();
        if (gdata.zlfaLeftSelectedIndex == 4 || gdata.zlfaLeftSelectedIndex == 5) {
            button1.selected = YES;
        }
        UIButton *button2 = (UIButton *)[cell viewWithTag:3];
        if (gdata.zlfaLeftSelectedIndex == 3 || gdata.zlfaBuchongLeftSelectedIndex == 3) {
            button2.selected = YES;
        }
        UIButton *button3 = (UIButton *)[cell viewWithTag:4];
        if (gdata.zlfaRightSelectedIndex == 1 || gdata.zlfaBuchongRightSelectedIndex == 1) {
            button3.selected = YES;
        }
        UIButton *button4 = (UIButton *)[cell viewWithTag:5];
        if (gdata.zlfaLeftSelectedIndex == 2) {
            button4.selected = YES;
        }
    } else if (indexPath.row == 8) {
        if ([self isNeededShowBingli]) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
            UILabel *lab = (UILabel *)[cell viewWithTag:1];
            lab.font = [UIFont systemFontOfSize:16.0f];
            lab.frame = CGRectMake(CGRectGetMinX(lab.frame), CGRectGetMinY(lab.frame), CGRectGetWidth(lab.frame), 67.0f);
            lab.text = @"前列腺癌，Gleason Score 4+5（SUM=9）。右叶24张切片中可见15张有癌，左叶24张切片中可见9张有癌。右叶浸润被膜外，PT3a，右侧切缘阳性。未累及尿道粘膜、双侧精囊腺、膀胱颈以及输精管。另送左闭孔淋巴结0/2个，右闭孔淋巴结0/3个，右髂内淋巴结2/2个，左髂内淋巴结0/2个，见转移癌。";
            lab.numberOfLines = 3;
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
            UILabel *lab = (UILabel *)[cell viewWithTag:1];
            lab.frame = CGRectMake(CGRectGetMinX(lab.frame), CGRectGetMinY(lab.frame), CGRectGetWidth(lab.frame), 21);
            lab.text = [NSString stringWithFormat:@"内分泌治疗方案：%@", [self loadYaoWuFangAn2]];
        }
    } else if (indexPath.row == 9) {
        if ([self isNeededShowBingli]) {
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
    if ([self isNeededShowBingli]) {
        if (indexPath.row == 7 ) {
            return 55.0f;
        } else if(indexPath.row == 8) {
            return 75.0f;
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
- (BOOL)isNeededShowBingli
{
    if (GCase3().step1MNumber >= 4 && GCase3().step1MNumber <= 6) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - 病史回顾
- (NSString *)zhenduanString2
{
    NSArray *itemsArray = [GCase3().zdjgZDSelectItem componentsSeparatedByString:@","];
    NSMutableString *itemsString = [NSMutableString string];
    for (NSString *item in itemsArray) {
        if ([item isEqualToString:@"jxa"]) {
            [itemsString appendFormat:@"%@, ", @"局限性前列腺癌"];
        } else if ([item isEqualToString:@"jxw"]) {
            [itemsString appendFormat:@"%@, ", @"局部晚期前列腺癌"];
        } else if ([item isEqualToString:@"zya"]) {
            [itemsString appendFormat:@"%@, ", @"转移性前列腺癌"];
        }
    }
    for (NSString *item in itemsArray) {
        if ([item isEqualToString:@"bph"]) {
            [itemsString appendFormat:@"%@, ", @"前列腺增生"];
        }  else if ([item isEqualToString:@"gxy"]) {
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
    NSString *string = GCase3().zdjgPGSelectItem;
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
    NSArray *indexArray = [GCase3().lcjcSelectedArrayStringR1 componentsSeparatedByString:@","];
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
    Case3Data *gdata = GCase3();
    NSMutableString *fanganString = [NSMutableString string];
    
    if (gdata.zlfaLeftSelectedIndex == 2) {
        [fanganString appendFormat:@"%@", @"化疗"];
    } else if (gdata.zlfaLeftSelectedIndex == 3) {
        [fanganString appendFormat:@"%@", @"外放疗"];
    } else if (gdata.zlfaLeftSelectedIndex == 4) {
        if (gdata.zlfaGZSBikongSelectedIndex == 1) {
            [fanganString appendFormat:@"%@", @"耻骨后根治性前列腺切除术+闭孔髂内淋巴结活检术"];
        } else if (gdata.zlfaGZSBikongSelectedIndex == 2) {
            [fanganString appendFormat:@"%@", @"腹腔镜根治性前列腺切除术+闭孔髂内淋巴结活检术"];
        }
    } else if (gdata.zlfaLeftSelectedIndex == 5) {
        if (gdata.zlfaGZSPenqiangSelectedIndex == 1) {
            [fanganString appendFormat:@"%@", @"耻骨后根治性前列腺切除术+盆腔淋巴结扩大清扫术"];
        } else if (gdata.zlfaGZSPenqiangSelectedIndex == 2) {
            [fanganString appendFormat:@"%@", @"腹腔镜根治性前列腺切除术+盆腔淋巴结扩大清扫术"];
        }
    }
    
    if (gdata.zlfaBuchongLeftSelectedIndex == 3) {
        if (fanganString.length > 0) {
            [fanganString appendFormat:@","];
        }
        [fanganString appendFormat:@"%@", @"外放疗"];
    }
    
    
    if (gdata.zlfaRightSelectedIndex == 1 || gdata.zlfaBuchongRightSelectedIndex == 1) {
        if (fanganString.length > 0) {
            [fanganString appendFormat:@","];
        }
        [fanganString appendFormat:@"%@", @"内分泌"];
    }
    return fanganString == nil ? @"" : fanganString;
}

- (NSString *)loadYaoWuFangAn2
{
    Case3Data *gdata = GCase3();
    NSString *neifenmiSelectItem = nil;
    
    if (gdata.zlfaBuchongNeifenmiSelectedIndex == 1 || gdata.zlfaNeifenmiSelectedIndex == 1) {
        neifenmiSelectItem = @"手术去势治疗";
    } else if (gdata.zlfaBuchongNeifenmiSelectedIndex == 2 || gdata.zlfaNeifenmiSelectedIndex == 2) {
        neifenmiSelectItem = @"最大限度雄激素阻断, 持续";
    }
    
    
    return neifenmiSelectItem == nil ? @"" : neifenmiSelectItem;
}

- (NSString *)loadYaoWu2
{
    Case3Data *gdata = GCase3();
    NSMutableString *yaowuString = [NSMutableString string];
    if (gdata.zlfaRightYWName1.length > 1) {
        [yaowuString appendFormat:@"%@, ", gdata.zlfaRightYWName1];
    }
    if (gdata.zlfaRightYWName2.length > 1) {
        [yaowuString appendFormat:@"%@, ", gdata.zlfaRightYWName2];
    }
    
    if (gdata.zlfaBuchongRightYWName1.length > 1) {
        [yaowuString appendFormat:@"%@, ", gdata.zlfaBuchongRightYWName1];
    }
    if (gdata.zlfaBuchongRightYWName2.length > 1) {
        [yaowuString appendFormat:@"%@, ", gdata.zlfaBuchongRightYWName2];
    }
    
    if (yaowuString.length > 2) {
        [yaowuString deleteCharactersInRange:NSMakeRange(yaowuString.length - 2, 2)];
    }

    return yaowuString.length == 0 ? @"" : yaowuString;
}

- (NSString *)loadButtonString2
{
    NSMutableString *buttonString = [NSMutableString string];
//    Case3Data *gdata = GCase3();
//    if (gdata.zlfaLeftSelectedIndex == 1 || gdata.zlfaLeftSelectedIndex == 2) {
//        [buttonString appendFormat:@"%d,", 0];
//    }
//    if (gdata.zlfaLeftSelectedIndex == 3 || gdata.zlfaWaifangliao == 1) {
//        [buttonString appendFormat:@"%d,", 1];
//    }
//    if (gdata.zlfaRightSelectedIndex == 2) {
//        [buttonString appendFormat:@"%d,", 2];
//    }
//    if (gdata.zlfaChixuJianxieSelectedIndex > 0 || gdata.zlfaFuzhuChixuJianxieSelectedIndex > 0) {
//        [buttonString appendFormat:@"%d,", 3];
//    }
    return buttonString == nil ? @"" : buttonString;
}

- (NSString *)chixujianxieString2
{
    NSUInteger mNumber = GCase3().step1MNumber;
    NSUInteger lastNumber = 0;
    if (mNumber == 3 || mNumber == 5) {
//        lastNumber = GCase3().zlfaFuzhuChixuJianxieSelectedIndex;
    }
    if (mNumber == 8 || mNumber == 9) {
//        lastNumber = GCase3().zlfaChixuJianxieSelectedIndex;
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
