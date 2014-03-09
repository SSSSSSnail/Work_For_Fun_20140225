//
//  LLCheckButton.m
//  Work_For_Fun_20140225
//
//  Created by user on 14-3-9.
//  Copyright (c) 2014年 Snail. All rights reserved.
//

#import "LLCheckButton.h"
#import "LLCheckButtonGroup.h"

@interface LLCheckButton ()
@end

@implementation LLCheckButton

#pragma mark - Lifecycle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

#pragma mark - checked Accessors
- (void)setChecked:(BOOL)checked
{
    _checked = checked;
    if (checked) {
        [self setImage:[UIImage imageNamed:@"checkSelectButton@2x.png"] forState:UIControlStateNormal];
    } else {
        [self setImage:[UIImage imageNamed:@"checkUnselectButton@2x.png"] forState:UIControlStateNormal];
    }
}

@end
