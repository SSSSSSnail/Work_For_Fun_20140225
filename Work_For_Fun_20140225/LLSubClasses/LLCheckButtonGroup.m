//
//  LLCheckButtonGroup.m
//  Work_For_Fun_20140225
//
//  Created by user on 14-3-9.
//  Copyright (c) 2014年 Snail. All rights reserved.
//

#import "LLCheckButtonGroup.h"
#import "LLCheckButton.h"
@interface LLCheckButtonGroup ()
@property (nonatomic, retain) NSMutableArray *container;
@end

@implementation LLCheckButtonGroup

#pragma mark - Lifecycle
- (LLCheckButtonGroup *)init
{
    if (self = [super init]) {
        self.container = [NSMutableArray array];
    }
    return self;
}

#pragma mark - selectedItemTag Accessor
- (void)setSelectedItemTag:(NSInteger)selectedItemTag
{
    for (LLCheckButton *checkButton in _container) {
        if (checkButton.tag == selectedItemTag) {
            self.selectedItem = checkButton;
            return;
        }
    }
}

- (NSInteger)selectedItemTag
{
    if (self.selectedItem) {
        return self.selectedItem.tag;
    }
    return -1;
}

#pragma mark - selectedItem Accessor
- (void)setSelectedItem:(LLCheckButton *)selectedItem
{
    for (LLCheckButton *checkButton in _container) {
        if ([selectedItem isEqual:checkButton]) {
            if (!checkButton.checked) {
                checkButton.checked = YES;
            }
            continue;
        }
        if (checkButton.checked) {
            checkButton.checked = NO;
        }
    }
}

- (LLCheckButton *)selectedItem
{
    for (LLCheckButton *checkButton in _container) {
        if (checkButton.checked) {
            return checkButton;
        }
    }
    return nil;
}

#pragma mark - Public Method
- (void)addObject:(LLCheckButton *)checkButton
{
    [_container addObject:checkButton];
    [checkButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchButton:(LLCheckButton *)sender
{
    if (sender.checked) {
        sender.checked = NO;
    } else {
        self.selectedItem = sender;
    }
    [_delegate buttonItemTouchedinGroup:sender];
}
@end
