//
//  BCJZViewController.h
//  Work_For_Fun_20140225
//
//  Created by Snail on 15/3/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "ScrollViewControllerDelegate.h"

typedef NS_ENUM(NSInteger, BCJZResult) {
    ZDJC             = 1, //M1 主动监测
    GZS              = 2, //M2 根治术
    GZSFZNFMCX       = 3, //M3 根治术+辅助 持续
    GZSFZNFMJX       = 4, //M3 根治术+辅助 间歇
    XFZNFMGZS        = 5, //M4 新辅助+根治术
    XFZNFMGZSFZNFMCX = 6, //M5 新辅助+根治术+辅助 持续
    XFZNFMGZSFZNFMJX = 7, //M5 新辅助+根治术+辅助 间歇
    GZSFL            = 8, //M6 根治术+放疗
    FL               = 9, //M7 放疗
    FLFZNFMCX        = 10,//M8 放疗+辅助 持续
    FLFZNFMJX        = 11,//M8 放疗+辅助 间歇
};

typedef NS_ENUM(NSInteger, BCJZMResult) {
    M1 = 21,
    M2 = 22,
    M3 = 23,
    M4 = 24,
    M5 = 25,
    M6 = 26,
    M7 = 27,
    M8 = 28
};

@interface BCJZViewController : UIViewController

@property (weak, nonatomic) id<ScrollViewControllerDelegate> scrollViewDelegate;

- (void)changeLabelText:(BCJZResult)result;
- (void)changedLabelTextInM2:(BCJZResult)result;
- (void)reloadViewDataForR2;

@end
