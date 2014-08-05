//
//  BSHGS3ViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 4/8/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "BSHGS3ViewController.h"

@interface BSHGS3ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *bshgTable;
@property (weak, nonatomic) IBOutlet UIImageView *bshgImageView;

- (IBAction)confirmClick:(UIButton *)sender;

@end

@implementation BSHGS3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UILabel *lcjcHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
    lcjcHeaderLabel.textAlignment = NSTextAlignmentCenter;
    lcjcHeaderLabel.text = @"病史回顾";
    lcjcHeaderLabel.font = [UIFont miscrosoftYaHeiFontWithSize:22.0f];
    lcjcHeaderLabel.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    _bshgTable.tableHeaderView = lcjcHeaderLabel;
}


- (void)refresh
{
    CGFloat viewHeight = [self shoudShowBingli] ? 360.0f : 305.0f;
    CGRect frame = _bshgTable.frame;
    frame.size.height = viewHeight;
    _bshgTable.frame = frame;
    [_bshgTable reloadData];

    CGFloat yPosition = [self shoudShowBingli] ? 412.0f : 357;
    frame = _bshgImageView.frame;
    frame.origin.y = yPosition;
    _bshgImageView.frame = frame;

    NSUInteger mNumber = GCase2().step1MNumber;
    NSUInteger sNumber = GCase2().step2SNumber;
    NSString *mNumberString;
    if (mNumber < 3 || mNumber > 5) {
        mNumberString = [NSString stringWithFormat:@"%ld", (long)mNumber];
    } else {
        mNumberString = @"3-5";
    }
    NSMutableString *imageNameString = [NSMutableString stringWithFormat:@"c2bshg2psaM%@S%ld", mNumberString, (long)sNumber];
    if (GCase2().zlfaChixuJianxieNeifenSelectedIndex > 0) {
        [imageNameString appendString:[NSString stringWithFormat:@"-%ld", GCase2().zlfaChixuJianxieNeifenSelectedIndex]];
    }
    UIImage *image = [UIImage imageNamed:imageNameString];
    _bshgImageView.image = image;
}


#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self shoudShowBingli] ? 9 : 8;
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
        lab1.text = @"年龄：78岁" ;
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

        lab.text = [NSString stringWithFormat:@"检查：%@", [self linchuangjiancheString3]];
        lab.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    } else if (indexPath.row == 4) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
        UILabel *lab = (UILabel *)[cell viewWithTag:1];
        lab.text = [NSString stringWithFormat:@"诊断：%@", [self zhenduanString3]];
        lab.textColor = [UIColor colorWithRed:2.0f/255 green:128.0f/255 blue:127.0f/255 alpha:1];
    } else if (indexPath.row == 5) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"button6LabelCell"];
        UILabel *lab = (UILabel *)[cell viewWithTag:1];
        lab.text = [NSString stringWithFormat:@"曾接受过：%@", [self loadZhiLiaoFangAn3]];
        UIButton *button1 = (UIButton *)[cell viewWithTag:2];
        Case2Data *gdata = GCase2();
        if (gdata.zlfa2SegmentSelectedIndex == 1 || gdata.zlfa2SegmentSelectedIndex == 2) {
            button1.selected = YES;
        }
        UIButton *button2 = (UIButton *)[cell viewWithTag:3];
        if (gdata.zlfa2SegmentSelectedIndex == 3) {
            button2.selected = YES;
        }
        UIButton *button3 = (UIButton *)[cell viewWithTag:4];
        if (gdata.zlfa2SegmentSelectedIndex == 4) {
            button3.selected = YES;
        }
        UIButton *button4 = (UIButton *)[cell viewWithTag:5];
        if (gdata.zlfa2SegmentSelectedIndex == 5) {
            button4.selected = YES;
        }
        UIButton *button5 = (UIButton *)[cell viewWithTag:6];
        if (gdata.zlfa2SegmentSelectedIndex == 6) {
            button5.selected = YES;
        }
        UIButton *button6 = (UIButton *)[cell viewWithTag:7];
        if (gdata.zlfa2SegmentSelectedIndex == 7) {
            button6.selected = YES;
        }
    } else if (indexPath.row == 6) {
        if ([self shoudShowBingli]) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
            UILabel *lab = (UILabel *)[cell viewWithTag:1];
            lab.font = [UIFont systemFontOfSize:16.0f];
            lab.frame = CGRectMake(CGRectGetMinX(lab.frame), CGRectGetMinY(lab.frame), CGRectGetWidth(lab.frame), 42);
            lab.text = @"前列腺癌，Gleason Score 4+3（SUM=7）。右叶24张切片可见7张有癌，左叶24张切片可见13张有癌。左叶浸润被膜外及神经，PT3a，尖部切缘未见肿瘤。未累及尿道粘膜、双侧精囊腺、膀胱颈以及输精管。未见转移癌。";
            lab.numberOfLines = 2;
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
            UILabel *lab = (UILabel *)[cell viewWithTag:1];
            lab.frame = CGRectMake(CGRectGetMinX(lab.frame), CGRectGetMinY(lab.frame), CGRectGetWidth(lab.frame), 21);
            lab.text = [NSString stringWithFormat:@"内分泌治疗方案：%@", [self loadYaoWuFangAn3]];
        }
    } else if (indexPath.row == 7) {
        if ([self shoudShowBingli]) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
            UILabel *lab = (UILabel *)[cell viewWithTag:1];
            lab.text = [NSString stringWithFormat:@"内分泌治疗方案：%@", [self loadYaoWuFangAn3]];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
            UILabel *lab = (UILabel *)[cell viewWithTag:1];
            lab.text = [NSString stringWithFormat:@"治疗药物：%@", [self loadYaoWu3]];
        }
    } else if (indexPath.row == 8) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"oneLabelCell"];
        UILabel *lab = (UILabel *)[cell viewWithTag:1];
        lab.text = [NSString stringWithFormat:@"治疗药物：%@", [self loadYaoWu3]];
    }
    return cell;
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self shoudShowBingli]) {
        if (indexPath.row == 5 || indexPath.row == 6) {
            return 55.0f;
        } else if (indexPath.row == 3){

        }
        return 30.0f;
    } else {
        if (indexPath.row == 5) {
            return 55.0f;
        } else if (indexPath.row == 3){

        }
        return 30.0f;
    }
}

- (NSString *)linchuangjiancheString3
{
    NSMutableString *string = [NSMutableString string];
    NSArray *array= @[@"直肠指诊", @"血常规", @"尿常规", @"血生化",
                      @"凝血筛查", @"心电图", @"超声心动", @"胸片",
                      @"B超", @"前列腺特异抗原PSA", @"睾酮", @"放射性核素骨扫描",
                      @"盆腔核磁共振MR", @"ECOG评分", @"CT检查", @"穿刺活检"];
    NSArray *indexArray = [GCase2().lcjcSelectedArrayStringR2 componentsSeparatedByString:@","];
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

- (NSString *)zhenduanString3
{
    NSArray *itemsArray = [GCase2().zdjg2ZDSelectItem componentsSeparatedByString:@","];
    NSMutableString *itemsString = [NSMutableString string];
    for (NSString *item in itemsArray) {
        if ([item isEqualToString:@"jxas"] || [item isEqualToString:@"jxaj"]) {
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


- (NSString *)loadZhiLiaoFangAn3
{
    Case2Data *gdata = GCase2();
    NSMutableString *fanganString = [NSMutableString string];
    if (gdata.zlfa2SegmentSelectedIndex == 1) {
        [fanganString appendFormat:@"%@, ", @"耻骨后根治性前列腺切除术"];
    } else if (gdata.zlfa2SegmentSelectedIndex == 2) {
        [fanganString appendFormat:@"%@, ", @"腹腔镜根治性前列腺切除术"];
    } else if (gdata.zlfa2SegmentSelectedIndex == 3) {
        [fanganString appendFormat:@"%@, ", @"外照射"];
    } else if (gdata.zlfa2SegmentSelectedIndex == 4) {
        [fanganString appendFormat:@"%@, ", @"内分泌治疗"];
    } else if (gdata.zlfa2SegmentSelectedIndex == 5) {
        [fanganString appendFormat:@"%@, ", @"中断抗雄治疗"];
    } else if (gdata.zlfa2SegmentSelectedIndex == 6) {
        [fanganString appendFormat:@"%@, ", @"二线内分泌治疗"];
    } else if (gdata.zlfa2SegmentSelectedIndex == 7) {
        [fanganString appendFormat:@"%@, ", @"化疗"];
    }

    if (fanganString.length > 2) {
        [fanganString deleteCharactersInRange:NSMakeRange(fanganString.length - 2, 2)];
    }
    return fanganString == nil ? @"" : fanganString;
}


- (NSString *)loadYaoWuFangAn3
{
    Case2Data *gdata = GCase2();
    NSMutableString *yaowufanganString = [NSMutableString string];

    if (gdata.zlfaChixuJianxieNeifenSelectedIndex == 1) {
        [yaowufanganString appendFormat:@"%@, ", @"持续"];
    } else if (gdata.zlfaChixuJianxieNeifenSelectedIndex == 2) {
        [yaowufanganString appendFormat:@"%@, ", @"间歇"];
    }

    if (gdata.zlfaChixuJianxieNeifenDetailSelectedIndex == 1) {
        [yaowufanganString appendFormat:@"%@, ", @"单一药物去势治疗"];
    } else if (gdata.zlfaChixuJianxieNeifenDetailSelectedIndex == 2) {
        [yaowufanganString appendFormat:@"%@, ", @"单一抗雄激素治疗"];
    } else if (gdata.zlfaChixuJianxieNeifenDetailSelectedIndex == 3) {
        [yaowufanganString appendFormat:@"%@, ", @"最大限度雄激素阻断"];
    } else if (gdata.zlfaChixuJianxieNeifenDetailSelectedIndex == 4) {
        [yaowufanganString appendFormat:@"%@, ", @"手术去势治疗"];
    }

    if (yaowufanganString.length > 2) {
        [yaowufanganString deleteCharactersInRange:NSMakeRange(yaowufanganString.length - 2, 2)];
    }
    return yaowufanganString == nil ? @"" : yaowufanganString;
}

- (NSString *)loadYaoWu3
{
    Case2Data *gdata = GCase2();
    NSMutableString *yaowuString = [NSMutableString string];
    if (gdata.zlfaNeifenmiYaowuName1.length > 1) {
        [yaowuString appendFormat:@"%@, ", gdata.zlfaNeifenmiYaowuName1];
    }
    if (gdata.zlfaNeifenmiYaowuName2.length > 1) {
        [yaowuString appendFormat:@"%@, ", gdata.zlfaNeifenmiYaowuName2];
    }
    if (yaowuString.length > 2) {
        [yaowuString deleteCharactersInRange:NSMakeRange(yaowuString.length - 2, 2)];
    }
    return yaowuString == nil ? @"" : yaowuString;
}

- (BOOL)shoudShowBingli
{
    if (GCase2().zlfa2SegmentSelectedIndex == 1 ||
        GCase2().zlfa2SegmentSelectedIndex == 2) {
        return YES;
    }
    return NO;
}

- (NSString *)chixujianxieString3
{
    return [NSString stringWithFormat:@"%ld", GCase2().zlfaChixuJianxieNeifenSelectedIndex];
}

- (NSString *)loadButtonString3
{
    NSMutableString *buttonString = [NSMutableString string];
    Case2Data *gdata = GCase2();
    if (gdata.zlfa2SegmentSelectedIndex == 1 || gdata.zlfa2SegmentSelectedIndex == 2) {
        [buttonString appendFormat:@"%d,", 0];
    } else {
        [buttonString appendFormat:@"%ld,", (long)GCase2().zlfa2SegmentSelectedIndex -2];
    }
    return buttonString == nil ? @"" : buttonString;
}

- (IBAction)confirmClick:(UIButton *)sender
{
    if ([self.scrollViewDelegate respondsToSelector:@selector(didClickConfirmButton:)]) {
        [self.scrollViewDelegate didClickConfirmButton:sender];
    }
}
@end
