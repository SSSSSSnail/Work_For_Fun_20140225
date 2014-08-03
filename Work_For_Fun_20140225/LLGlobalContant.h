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

#define SKIPREQUEST

#import "UIFont+MicrosoftFont.h"
#import "UIAlertView+Blocks.h"
#import "BCJZViewController.h"

@class Case1Data;
@class Case2Data;
@interface LLGlobalData : NSObject

@property (copy, nonatomic) NSString *subjectName;
@property (copy, nonatomic) NSString *subjectId;
@property (copy, nonatomic) NSString *groupNumber;

@property (assign, nonatomic) NSUInteger currentIndex;
@property (assign, nonatomic) NSUInteger maxIndex;

@property (copy, nonatomic) NSString *hasAddtoGroup;

@property (copy, nonatomic, readonly) NSString *dataClass;

@end

//Local
//static NSString *const SERVERURL = @"http://192.168.1.12:8080/diphereline-case/subject.do";
//static NSString *const STEPURL = @"http://192.168.1.12:8080/diphereline-case/case2.do";

//Prod
//static NSString *const SERVERURL = @"http://diphereline-case.com/subject.do";
//static NSString *const STEPURL = @"http://diphereline-case.com/case1.do";

//Test
static NSString *const SERVERURL = @"http://edetailing-data.com/diphereline-case/subject.do";
static NSString *const STEPURL = @"http://edetailing-data.com/diphereline-case/case2.do";

static NSString *const E1 = @"E01";
static NSString *const E2 = @"E02";

typedef NS_ENUM (NSUInteger, CaseNumber) {
    CaseNumberOne = 1,
    CaseNumberTwo = 2
};

@interface LLGlobalContant : NSObject

@property (nonatomic, assign) CaseNumber caseNumber;

+ (instancetype)sharedInstance;

- (void)initData;
- (void)loadData;
- (void)backupData;
- (void)savaData;

- (void)showInfoMessage:(NSString *)message;
- (void)showErrorMessage:(NSString *)message;

/**
 *  该方法用于请求服务器返回数据
 *
 *  @param addToView     添加HUD的view 一般为self.view
 *  @param requestURL    发送请求的URL
 *  @param parameters    POST的数据
 *  @param requestFinish Block请求完成后处理事件
 */
- (void)httprequestWithHUD:(UIView *)addToView
            withRequestURL:(NSString *)requestURL
            withParameters:(NSDictionary *)parameters
                completion:(void(^)(NSDictionary *responseJsonDic))requestFinish;

@property (strong, nonatomic) LLGlobalData *globalData;

@end

LLGlobalContant *GInstance();
Case1Data *GCase1();
Case2Data *GCase2();
