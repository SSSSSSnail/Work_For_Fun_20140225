//
//  Case2Data.h
//  Work_For_Fun_20140225
//
//  Created by Snail on 19/7/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "LLGlobalContant.h"

typedef NS_ENUM(NSInteger, Case2Step) {
    Case2Step1 = 0,
    Case2Step2,
    Case2Step3
};

@interface Case2Data : LLGlobalData

@property (assign, nonatomic) Case2Step currentStep;

//临床检查
@property (copy, nonatomic) NSString *lcjcSelectedArrayStringR1;
@property (copy, nonatomic) NSString *lcjcSelectedArrayStringR2;
@property (copy, nonatomic) NSString *lcjcSelectedArrayStringR3;
@property (copy, nonatomic) NSString *lcjcChuanCiBA;

//诊断结果
@property (copy, nonatomic) NSString *zdjgZDSelectItem;
@property (copy, nonatomic) NSString *zdjgTSelectItem;
@property (copy, nonatomic) NSString *zdjgMSelectItem;
@property (copy, nonatomic) NSString *zdjgNSelectItem;
@property (copy, nonatomic) NSString *zdjgPGSelectItem;

//治疗方案
@property (assign, nonatomic) NSUInteger zlfaLeftSelectedIndex; // 1 2 3 4
@property (assign, nonatomic) NSUInteger zlfaRightSelectedIndex; // 1 2    0 未选择
@property (assign, nonatomic) NSUInteger zlfaChixuJianxieSelectedIndex; // 1 持续 2 间歇 0 未选择
@property (assign, nonatomic) NSUInteger zlfaChixujianxieDetailSelectedIndex; // 1 药物 2 抗雄 3 雄激素 4 手术 0 未选择
@property (assign, nonatomic) NSUInteger zlfaLianheSelectedIndex; //1 选中 0 未选
@property (copy, nonatomic) NSString *zlfaYaowuName1; //Picker1
@property (copy, nonatomic) NSString *zlfaYaowuName2; //Picker2

@property (assign, nonatomic) NSUInteger zlfaWaifangliao; // 1 选择 0 未选
@property (assign, nonatomic) NSUInteger zlfaFuzhuSelectedIndex; // 1 选择    0 未选择
@property (assign, nonatomic) NSUInteger zlfaFuzhuChixuJianxieSelectedIndex; // 1 持续 2 间歇 0 未选择
@property (assign, nonatomic) NSUInteger zlfaFuzhuChixujianxieDetailSelectedIndex; // 1 药物 2 抗雄 3 雄激素 4 手术 0 未选择

@property (assign, nonatomic) NSUInteger step1MNumber;

@end
