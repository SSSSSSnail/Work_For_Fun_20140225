//
//  Case1Data.h
//  Work_For_Fun_20140225
//
//  Created by Snail on 19/7/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "LLGlobalContant.h"

@interface Case1Data : LLGlobalData

@property (copy, nonatomic) NSString *lcjcSelectedArrayString;
@property (copy, nonatomic) NSString *lcjcSelectedArrayStringR2;
@property (copy, nonatomic) NSString *lcjcChuanCiBA;

@property (assign, nonatomic) NSUInteger zlfaLeftSelectedIndex; // 1 2 3 4 5
@property (assign, nonatomic) NSUInteger zlfaRightSelectedIndex; // 1 2 3   0标示未选择
@property (copy, nonatomic) NSString *zlfaFuzhuType; // C : 持续 J : 间歇
@property (copy, nonatomic) NSString *zlfaFuzhuOrZhaoShe; // F : 辅助 W : 外照射
@property (assign, nonatomic) NSUInteger zlfaFuzhuSelectedIndex; // 1 2 3 4

@property (copy, nonatomic) NSString *zlfaXinFuZhuYaoWuSeg1;
@property (copy, nonatomic) NSString *zlfaXinFuZhuYaoWuSeg2;

@property (copy, nonatomic) NSString *zlfaFuzhuYaoWuSeg1;
@property (copy, nonatomic) NSString *zlfaFuzhuYaoWuSeg2;
@property (copy, nonatomic) NSString *zlfaFuzhuYaoWuSeg3;

@property (copy, nonatomic) NSString *zlfaR2FuzhuYaoWuSeg1;
@property (copy, nonatomic) NSString *zlfaR2FuzhuYaoWuSeg2;
@property (copy, nonatomic) NSString *zlfaR2FuzhuYaoWuSeg3;

//R2
@property (assign, nonatomic) NSUInteger zlfaR2RightSelectedIndex;
@property (copy, nonatomic) NSString *zlfaR2RightYaowuSelected; //C : 雌激素 F : 氟他胺

@property (copy, nonatomic) NSString *zdjgZDSelectItem;
@property (copy, nonatomic) NSString *zdjgPGSelectItem;
@property (copy, nonatomic) NSString *zdjgTSelectItem;
@property (copy, nonatomic) NSString *zdjgMSelectItem;
@property (copy, nonatomic) NSString *zdjgNSelectItem;
@property (copy, nonatomic) NSString *zdjgZDSelectItemR2;
@property (copy, nonatomic) NSString *zdjgPGSelectItemR2;
@property (copy, nonatomic) NSString *zdjgTSelectItemR2;
@property (copy, nonatomic) NSString *zdjgMSelectItemR2;
@property (copy, nonatomic) NSString *zdjgNSelectItemR2;
@property (getter = isFSSetp2, nonatomic) BOOL fsStep2;
@property (assign, nonatomic) BCJZMResult r2Type;
@property (assign, nonatomic) BCJZResult r1Result;
@property (assign, nonatomic) BCJZResult r2Result;
@property (copy, nonatomic) NSString *dateTimeOneMonth;
@property (copy, nonatomic) NSString *dateTimeSixMonth;

@end
