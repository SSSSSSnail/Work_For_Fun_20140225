//
//  UIFont+MicrosoftFont.m
//  Work_For_Fun_20140225
//
//  Created by user on 14-3-5.
//  Copyright (c) 2014年 Snail. All rights reserved.
//

#import "UIFont+MicrosoftFont.h"
static float const DefaultFontSize = 12.0f;
static NSString *const YaHeiFontName = @"MicrosoftYaHei";
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

@end
