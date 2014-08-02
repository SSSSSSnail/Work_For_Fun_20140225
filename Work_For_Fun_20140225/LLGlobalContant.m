//
//  LLGlobalContant.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 27/2/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "LLGlobalContant.h"
#import <objc/runtime.h>
#import "Case1Data.h"
#import "Case2Data.h"

static NSString *kDataClass = @"dataClass";

@implementation LLGlobalData

- (NSString *)dataClass
{
    NSAssert(NO, @"请在子类实现");
    return nil;
}

@end

@interface LLGlobalContant ()

@property (strong, nonatomic) NSMutableDictionary *globalDictionary;

@property (strong, nonatomic) NSDictionary *globalDataDictionary;

@end

NSString *DataFileName();
NSString *BackupFileName();

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

- (void)initData
{
    switch (_caseNumber) {
        case CaseNumberOne:
            self.globalData = [[Case1Data alloc] init];
            break;
        case CaseNumberTwo:
            self.globalData = [[Case2Data alloc] init];
            break;

        default:
            break;
    }
}

//从Documents/data.plist读取数据并替换当前全局的GlobalData
- (void)loadData
{
    self.globalDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:DataFileName()];
    self.globalData = [self coverToObject:_globalDictionary];
}

//将已存在plist备份至backup文件夹
- (void)backupData
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL isFolderCreated = YES;
    if (![fileManager fileExistsAtPath:BackupFileName()]) {
        isFolderCreated = [fileManager createDirectoryAtPath:BackupFileName() withIntermediateDirectories:YES attributes:NO error:&error];
    }
    if (isFolderCreated) {
        [fileManager moveItemAtPath:DataFileName() toPath:[BackupFileName() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", _globalData.subjectId]] error:&error];
    }
    if (error) {
        NSLog(@"BackupData Error : %@", error.localizedDescription);
    }
}

//将GlobalDcitionary中的数据持久化到plist中
- (void)savaData
{
    if (_globalData) {
        self.globalDictionary = [GInstance() coverToDictionaryFromObject:_globalData];
        [_globalDictionary writeToFile:DataFileName() atomically:YES];
    }
}

- (void)showInfoMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)showErrorMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

- (void)httprequestWithHUD:(UIView *)addToView
            withRequestURL:(NSString *)requestURL
            withParameters:(NSDictionary *)parameters
                completion:(void(^)(NSDictionary *responseJsonDic))requestFinish
{
#ifdef SKIPREQUEST
    requestFinish(@{@"result": @"true"});
#endif

#ifndef SKIPREQUEST
    [MBProgressHUD showHUDAddedTo:addToView animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15.0f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:requestURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:addToView animated:YES];
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
        [self showInfoMessage:@"网络异常，请检查网络后重试！"];
        NSLog(@"Error: %@", error);
    }];
#endif
}

- (NSMutableDictionary *)coverToDictionaryFromObject:(id)object
{
    NSMutableDictionary *theDictionary = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (i = 0; i < outCount; i++) {
        NSString *propertyNameString = [[NSString alloc] initWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding];
        id value = [object valueForKey:propertyNameString];
        if (!value) {
            value = @"";
        }

        NSLog(@"Object2Dic : %@ -> %@", propertyNameString, value);
        [theDictionary setObject:value forKey:propertyNameString];
    }

    objc_property_t *superProperties = class_copyPropertyList(class_getSuperclass([object class]), &outCount);
    for (i = 0; i < outCount; i++) {
        NSString *propertyNameString = [[NSString alloc] initWithCString:property_getName(superProperties[i]) encoding:NSUTF8StringEncoding];
        id value = [object valueForKey:propertyNameString];
        if (!value) {
            value = @"";
        }
        [theDictionary setObject:value forKey:propertyNameString];
        NSLog(@"Object2Dic(Super) : %@ -> %@", propertyNameString, value);
    }
    return theDictionary;
}

- (id)coverToObject:(NSMutableDictionary *)dictionary
{
    NSString *className = dictionary[kDataClass];
    id instance = [NSClassFromString(className) new];
    for (NSString *dicKey in dictionary.allKeys) {
        if ([dicKey isEqualToString:kDataClass]) {
            continue;
        }
        id dicValue = dictionary[dicKey];
        [instance setValue:dicValue forKey:dicKey];
        NSLog(@"Dic2Object : %@ -> %@", dicKey, dicValue);
    }
    return instance;
}

@end

NSString *DataFileName()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"data.plist"];
    return plistPath;
}

NSString *BackupFileName()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"backup"];
    return plistPath;
}

LLGlobalContant *GInstance()
{
    return [LLGlobalContant sharedInstance];
}

Case1Data *GCase1()
{
    return (Case1Data *)GInstance().globalData;
}

Case2Data *GCase2()
{
    return (Case2Data *)GInstance().globalData;
}