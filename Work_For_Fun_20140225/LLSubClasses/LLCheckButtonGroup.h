//
//  LLCheckButtonGroup.h
//  Work_For_Fun_20140225
//
//  Created by user on 14-3-9.
//  Copyright (c) 2014年 Snail. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LLCheckButton;
@interface LLCheckButtonGroup : NSObject
@property (assign, nonatomic) NSInteger selectedItemTag;
@property (strong, nonatomic) LLCheckButton *selectedItem;
- (void)addObject:(id)checkButton;
@end
