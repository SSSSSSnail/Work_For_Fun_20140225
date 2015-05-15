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
@class Case3Data;
@interface LLGlobalData : NSObject

@property (copy, nonatomic) NSString *subjectName;
@property (copy, nonatomic) NSString *subjectId;
@property (copy, nonatomic) NSString *groupNumber;

@property (assign, nonatomic) NSUInteger currentIndex;
@property (assign, nonatomic) NSUInteger maxIndex;

@property (copy, nonatomic) NSString *hasAddtoGroup;

@property (copy, nonatomic, readonly) NSString *dataClass;

@end


static NSString *const HOSTURL = @"http://diphereline-case.com/";
//Local
//static NSString *const HOSTURL = @"http://192.168.1.14:8080/diphereline-case/";

#define SERVERURL [NSString stringWithFormat:@"%@%@", HOSTURL, @"subject.do"]
#define STEPURL [NSString stringWithFormat:@"%@case%ld.do", HOSTURL, (long)GInstance().caseNumber]

static NSString *const E1 = @"E01";
static NSString *const E2 = @"E02";

static NSString *const YCase = @"Y";

typedef NS_ENUM (NSUInteger, CaseNumber) {
    CaseNumberZero = 0,
    CaseNumberOne = 1,
    CaseNumberTwo = 2,
    CaseNumberThree = 3
};

@interface LLGlobalContant : NSObject

@property (nonatomic, assign) CaseNumber caseNumber;
@property (nonatomic, assign) BOOL validatedCode;

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

- (void)animationDateInOut:(UIView *)animationView withCompletion:(void (^)())completion;

/**
 *  一个弹出放大后缩小的动画
 *
 *  @param animationView 执行动画的UIView
 *  @param afterDelay     延迟执行
 *  @param completion     Block动画完成
 */
- (void)animationScale:(UIView *)animationView afterDelay:(NSTimeInterval)delay withCompletion:(void (^)())completion;

/**
 *  一个放大后淡出的动画
 *
 *  @param animationView 执行动画的UIView
 *  @param completion    Block动画完成
 */
- (void)animationScaleUpOut:(UIView *)animationView withCompletion:(void (^)())completion;

/**
 *  一个缩小后淡出的动画
 *
 *  @param animationView 执行动画的UIView
 *  @param completion    Block动画完成
 */
- (void)animationScaleDownOut:(UIView *)animationView withCompletion:(void (^)())completion;

/**
 *  日期格式化 yyyy/MM/dd
 *
 *  @param numberDate json传过来的时间
 *
 *  @return 格式化之后的时间
 */
- (NSString *)formatDate:(NSNumber *)numberDate;

@property (strong, nonatomic) LLGlobalData *globalData;

@end

LLGlobalContant *GInstance();
Case1Data *GCase1();
Case2Data *GCase2();
Case3Data *GCase3();
