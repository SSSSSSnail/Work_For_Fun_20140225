//
//  UIFont+MicrosoftFont.m
//  Work_For_Fun_20140225
//
//  Created by user on 14-3-5.
//  Copyright (c) 2014年 Snail. All rights reserved.
//

#import "UIFont+MicrosoftFont.h"
static float const DefaultFontSize = 17.0f;
static NSString *const YaHeiFontName = @"Microsoft YaHei";
static NSString *const YaHeiFontBoldName = @"Microsoft Yahei In-Bold";
@implementation UIFont (MicrosoftFont)

#pragma mark YaHei font 

/*
 YaHei Font with Default Size
 */
+ (UIFont *)miscrosoftYaHeiFont
{
    return [UIFont miscrosoftYaHeiFontWithSize:DefaultFontSize];
}

/*
 YaHei Font with fontSize
 */
+ (UIFont *)miscrosoftYaHeiFontWithSize:(float)fontSize
{
    return [UIFont fontWithName:YaHeiFontName size:fontSize];
}


/*
 YaHei BoldFont with DefaultSize
 */
+ (UIFont *)miscrosoftYaHeiBoldFont;
{
    return [UIFont miscrosoftYaHeiBoldFontWithSize:DefaultFontSize];
}

/*
 YaHei BoldFont with fontsize
 */
+ (UIFont *)miscrosoftYaHeiBoldFontWithSize:(float)fontSize
{
    return [UIFont fontWithName:YaHeiFontBoldName size:fontSize];
}

/*
 YaHei bold:isBold with fontSize
 */
+ (UIFont *)miscrosoftYaHeiFontWithSize:(float)fontSize bold:(BOOL)isBold
{
    if (isBold) {
        return [UIFont miscrosoftYaHeiBoldFontWithSize:fontSize];
    }
    return [UIFont miscrosoftYaHeiFontWithSize:fontSize];
}

/*
 isBold yes :boldFont
 */
+ (UIFont *)miscrosoftYaHeiFont:(BOOL)isBold
{
    if (isBold) {
        return [UIFont miscrosoftYaHeiBoldFont];
    }
    return [UIFont miscrosoftYaHeiFont];
}

@end
