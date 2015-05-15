//
//  Case3Data.h
//  Work_For_Fun_20140225
//
//  Created by Mac on 15-5-6.
//  Copyright (c) 2015年 Snail. All rights reserved.
//

#import "CaseData.h"

@interface Case3Data : CaseData

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

//治疗方案1
@property (assign, nonatomic) NSUInteger zlfaLeftSelectedIndex; // 2 3 4 5
@property (assign, nonatomic) NSUInteger zlfaRightSelectedIndex; // 1 2    0 未选择

@property (assign, nonatomic) NSUInteger zlfaNeifenmiSelectedIndex; // 1 2 0 未选择

@property (assign, nonatomic) NSUInteger zlfaZuidaZuduanSelectedIndex; // 1 持续 2 间歇 0未选择 （0，2错误提示）

@property (assign, nonatomic) NSUInteger zlfaGZSBikongSelectedIndex; //1 耻骨后 2 腹腔 0未选择
@property (assign, nonatomic) NSUInteger zlfaGZSPenqiangSelectedIndex; //1 耻骨后 2 腹腔 0未选择

@property (assign, nonatomic) NSUInteger zlfaBuchongLeftSelectedIndex;//
@property (assign, nonatomic) NSUInteger zlfaBuchongRightSelectedIndex; // 1
@property (assign, nonatomic) NSUInteger zlfaBuchongNeifenmiSelectedIndex;
@property (assign, nonatomic) NSUInteger zlfaBuchongZuidaZuduanSelectedIndex;

@property (copy, nonatomic) NSString *zlfaRightYWName1;
@property (copy, nonatomic) NSString *zlfaRightYWName2;

@property (copy, nonatomic) NSString *zlfaBuchongRightYWName1;
@property (copy, nonatomic) NSString *zlfaBuchongRightYWName2;

@property (assign, nonatomic) NSUInteger zlfaChixuJianxieSelectedIndex; // 1 持续 2 间歇 0 未选择
@property (assign, nonatomic) NSUInteger zlfaChixujianxieDetailSelectedIndex; // 1 药物 2 抗雄 3 雄激素 4 手术 0 未选择
@property (assign, nonatomic) NSUInteger zlfaLianheSelectedIndex; //1 选中 0 未选
@property (copy, nonatomic) NSString *zlfaYaowuName1; //Picker1
@property (copy, nonatomic) NSString *zlfaYaowuName2; //Picker2


@property (copy, nonatomic) NSString *zlfaXinfuzhuYaowuName1; //Picker1 新辅助
@property (copy, nonatomic) NSString *zlfaXinfuzhuYaowuName2; //Picker2 新辅助


@property (assign, nonatomic) NSUInteger zlfaWaifangliao; // 1 选择 0 未选
@property (assign, nonatomic) NSUInteger zlfaFuzhuSelectedIndex; // 1 选择    0 未选择
@property (assign, nonatomic) NSUInteger zlfaFuzhuChixuJianxieSelectedIndex; // 1 持续 2 间歇 0 未选择
@property (assign, nonatomic) NSUInteger zlfaFuzhuChixujianxieDetailSelectedIndex; // 1 药物 2 抗雄 3 雄激素 4 手术 0 未选择

@property (assign, nonatomic) NSUInteger zlfa2SegmentSelectedIndex; // 1 2 3 4 5 6 7 0 未选择
@property (assign, nonatomic) NSUInteger zlfa2ErfenSelectedIndex; // 1 雌激素 2 氟他胺 0 未选择
@property (assign, nonatomic) NSUInteger zlfaChixuJianxieNeifenSelectedIndex; // 1 持续 2 间歇 0 未选择
@property (assign, nonatomic) NSUInteger zlfaChixuJianxieNeifenDetailSelectedIndex; // 1 药物 2 抗雄 3 雄激素 4 手术 0 未选择

@property (copy, nonatomic) NSString *zlfaNeifenmiYaowuName1; //Picker1
@property (copy, nonatomic) NSString *zlfaNeifenmiYaowuName2; //Picker2
//病程进展




@property (assign, nonatomic) NSUInteger step1MNumber;
@property (assign, nonatomic) NSUInteger step2SNumber;
@property (assign, nonatomic) NSUInteger step3SNumber;
@end
