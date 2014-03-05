//
//  LLGlobalContant.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 27/2/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "LLGlobalContant.h"
@interface LLGlobalContant ()

@property (strong, nonatomic) NSMutableDictionary *globalDictionary;

@end

static LLGlobalData *staticGlobalData;
NSString *DataFileName();
NSString *BackupFileName(NSString *subjectName);

@implementation LLGlobalContant

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LLGlobalContant alloc] init];
    });
    return sharedInstance;
}

- (LLGlobalData *)globalData
{
    if (!staticGlobalData) {
        [self loadData];
    }
    return staticGlobalData;
}

//从Documents/data.plist读取数据
- (void)loadData
{
    self.globalDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:DataFileName()];
    //dictionary 转换到 bean
}

//将已存在plist备份至backup文件夹
- (void)backupData
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager moveItemAtPath:DataFileName() toPath:BackupFileName(_globalData.subjectName) error:NULL];
}

//将GlobalDcitionary中的数据持久化到plist中
- (void)savaData
{
    //bean 转换到 dictionary
    [_globalDictionary writeToFile:DataFileName() atomically:YES];
}

- (void)httprequestWithHUD:(UIView *)addToView
            withRequestURL:(NSString *)requestURL
            withParameters:(NSDictionary *)parameters
                completion:(void(^)(NSDictionary *responseJsonDic))requestFinish
{
    [MBProgressHUD showHUDAddedTo:addToView animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10.0f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:requestURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:addToView animated:YES];
        NSLog(@"%@", responseObject);
        NSDictionary *jsonDic;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            jsonDic = (NSDictionary *)responseObject;
        } else {
            NSLog(@"返回数据格式转化错误！");
            return;
        }
        requestFinish(jsonDic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:addToView animated:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常，请检查网络后重试！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        NSLog(@"Error: %@", error);
    }];
}

@end

NSString *DataFileName()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath = [paths objectAtIndex:0];
    return [plistPath stringByAppendingPathComponent:@"data.plist"];
}

NSString *BackupFileName(NSString *subjectName)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:subjectName];
    return [plistPath stringByAppendingPathComponent:@"data.plist"];
}

LLGlobalContant *GInstance()
{
    return [LLGlobalContant sharedInstance];
}