//
//  LLCheckButton.h
//  Work_For_Fun_20140225
//
//  Created by user on 14-3-9.
//  Copyright (c) 2014年 Snail. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLCheckButtonGroup;
@interface LLCheckButton : UIButton
@property (nonatomic, assign) BOOL checked;
@property (weak, nonatomic) LLCheckButtonGroup *group;
@end
