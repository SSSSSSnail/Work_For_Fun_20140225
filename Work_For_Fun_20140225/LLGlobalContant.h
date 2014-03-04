//
//  LLGlobalContant.h
//  Work_For_Fun_20140225
//
//  Created by Snail on 27/2/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

@interface LLGlobalData : NSObject

@property (copy, nonatomic) NSString *subjectName;
@property (copy, nonatomic) NSString *groupNumber;
//@property (copy, nonatomic)
//@property (copy, nonatomic)
//@property (copy, nonatomic)
//@property (copy, nonatomic)
//@property (copy, nonatomic)
//@property (copy, nonatomic)
//@property (copy, nonatomic)
@end

static NSString *const SERVERURL = @"http://edetailing-data.com/case/subject.do";

@interface LLGlobalContant : NSObject

- (instancetype)sharedInstance;

- (void)loadData;
- (void)backupData;
- (void)savaData;

@property (strong, nonatomic) LLGlobalData *globalData;

@end
