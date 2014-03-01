//
//  LLUIView.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 27/2/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "LLUIView.h"

@implementation LLUIView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeup:)];
        swipeGes.direction = UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:swipeGes];
    }
    return self;
}

- (void)swipeup:(UISwipeGestureRecognizer *)recognizer
{
    if ([_LLDelegate respondsToSelector:@selector(swipeup:)]) {
        [_LLDelegate swipeup:self];
    }
}

@end
