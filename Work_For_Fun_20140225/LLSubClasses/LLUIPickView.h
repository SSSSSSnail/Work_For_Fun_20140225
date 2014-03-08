//
//  LLUIPickView.h
//  Work_For_Fun_20140225
//
//  Created by user on 14-3-7.
//  Copyright (c) 2014年 Snail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLUIPickView : UIPickerView
@property ( copy, nonatomic) NSString *selectedOjbect;
- (void)resizeFrameMinHeight;
@end
