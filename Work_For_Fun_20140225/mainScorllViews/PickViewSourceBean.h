//
//  PickViewSourceBean.h
//  Work_For_Fun_20140225
//
//  Created by user on 14-3-16.
//  Copyright (c) 2014年 Snail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PickViewSourceBean : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;

- (PickViewSourceBean *)initWith:(NSString *)key value:(NSString *)value;

@end
