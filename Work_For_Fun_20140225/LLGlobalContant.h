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

#import "UIFont+MicrosoftFont.h"
#import "UIAlertView+Blocks.h"

@interface LLGlobalData : NSObject

@property (copy, nonatomic) NSString *subjectName;
@property (copy, nonatomic) NSString *subjectId;
@property (copy, nonatomic) NSString *groupNumber;

@property (copy, nonatomic) NSString *lcjcSelectedArrayString;
@property (copy, nonatomic) NSString *lcjcChuanCiBA;

@property (assign, nonatomic) NSUInteger zlfaLeftSelectedIndex; // 1 2 3 4 5
@property (assign, nonatomic) NSUInteger zlfaRightSelectedIndex; // 1 2 3   0标示未选择
@property (copy, nonatomic) NSString *zlfaFuzhuType; // C : 持续 J : 间歇
@property (copy, nonatomic) NSString *zlfaFuzhuOrZhaoShe; // F : 辅助 W : 外照射
@property (assign, nonatomic) NSUInteger zlfaFuzhuSelectedIndex; // 1 2 3 4

@property (assign, nonatomic) NSUInteger currentIndex;
@property (assign, nonatomic) NSUInteger maxIndex;
//@property (copy, nonatomic)
//@property (copy, nonatomic)
//@property (copy, nonatomic)
//@property (copy, nonatomic)
//@property (copy, nonatomic)
//@property (copy, nonatomic)
//@property (copy, nonatomic)

@end

static NSString *const SERVERURL = @"http://diphereline-case.com/subject.do";

@interface LLGlobalContant : NSObject

+ (instancetype)sharedInstance;

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

- (NSMutableDictionary *)coverToDictionaryFromObject:(id)object;
- (void)coverToObject:(id)object fromDictionary:(NSMutableDictionary *)dictionary;

@property (strong, nonatomic) LLGlobalData *globalData;

@end

LLGlobalContant *GInstance();