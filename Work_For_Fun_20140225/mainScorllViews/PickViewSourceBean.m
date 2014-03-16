//
//  PickViewSourceBean.m
//  Work_For_Fun_20140225
//
//  Created by user on 14-3-16.
//  Copyright (c) 2014年 Snail. All rights reserved.
//

#import "PickViewSourceBean.h"

@implementation PickViewSourceBean

- (PickViewSourceBean *)initWith:(NSString *)key value:(NSString *)value
{
    if (self = [super init]) {
        self.key = key;
        self.value = value;
    }
    return self;
}
@end
