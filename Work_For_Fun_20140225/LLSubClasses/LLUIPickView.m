//
//  LLUIPickView.m
//  Work_For_Fun_20140225
//
//  Created by user on 14-3-7.
//  Copyright (c) 2014年 Snail. All rights reserved.
//

#import "LLUIPickView.h"

@implementation LLUIPickView
#pragma mark – Lifecycle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (void)resizeFrameMinHeight
{
    CGFloat minHeight = 162.0f;
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    CGRect frame = self.frame;
    CGFloat originYCenter = CGRectGetMinY(frame);
    CGFloat originHeight = CGRectGetHeight(frame) - minHeight;
    self.frame = CGRectMake(CGRectGetMinX(frame), originYCenter + (originHeight / 2.0), CGRectGetWidth(frame), minHeight);
    frame = self.frame;
    self.showsSelectionIndicator= YES;
}

- (NSString *)selectedOjbect
{
    if (_selectedOjbect) {
        return _selectedOjbect;
    }
    _selectedOjbect = @"";
    return _selectedOjbect;
}

@end
