//
//  UIFont+MicrosoftFont.h
//  Work_For_Fun_20140225
//
//  Created by user on 14-3-5.
//  Copyright (c) 2014年 Snail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (MicrosoftFont)
+ (UIFont *)miscrosoftYaHeiFont;
+ (UIFont *)miscrosoftYaHeiFontWithSize:(float)fontSize;
+ (UIFont *)miscrosoftYaHeiBoldFont;
+ (UIFont *)miscrosoftYaHeiBoldFontWithSize:(float)fontSize;
+ (UIFont *)miscrosoftYaHeiFontWithSize:(float)fontSize bold:(BOOL)isBold;
+ (UIFont *)miscrosoftYaHeiFont:(BOOL)isBold;
@end
