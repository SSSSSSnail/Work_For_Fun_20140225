//
//  LLGlobalContant.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 27/2/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "LLGlobalContant.h"
#import <objc/runtime.h>

@implementation LLGlobalData

@end

@interface LLGlobalContant ()

@property (strong, nonatomic) NSMutableDictionary *globalDictionary;

@property (strong, nonatomic) NSDictionary *globalDataDictionary;

- (NSMutableDictionary *)mapZDJG;
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

//从Documents/data.plist读取数据并替换当前全局的GlobalData
- (void)loadData
{
    self.globalDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:DataFileName()];
    self.globalData = [[LLGlobalData alloc] init];
//    self.globalDataDictionary = @{@"1" : @{@"": @""},
//                                  @"2" : @{},
//                                  @"3" : [self mapZDJG]};
    [GInstance() coverToObject:_globalData fromDictionary:_globalDictionary];
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
}

- (NSMutableDictionary *)coverToDictionaryFromObject:(id)object
{
    NSMutableDictionary *theDictionary = [NSMutableDictionary dictionary];
    NSString *className = NSStringFromClass([object class]);
    id theClass = objc_getClass([className UTF8String]);
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(theClass, &outCount);
    for (i = 0; i < outCount; i++) {
        NSString *propertyNameString = [[NSString alloc] initWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding];
//        NSLog(@"coverToDictionaryFromObject : %@", propertyNameString);
        id value = [object valueForKey:propertyNameString];
        if (!value) {
            value = @"";
        }
        [theDictionary setObject:value forKey:propertyNameString];
    }
    return theDictionary;
}

- (void)coverToObject:(id)object fromDictionary:(NSMutableDictionary *)dictionary
{
    for (NSString *dicKey in dictionary.allKeys) {
//        NSLog(@"coverToObject : %@", dicKey);
        id dicValue = dictionary[dicKey];
        [object setValue:dicValue forKey:dicKey];
    }
}

- (NSMutableDictionary *)mapZDJG
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
//    NSDictionary *pickViewSourceDictionary = @{@"pg": @[@"  ", @"gw", @"zw", @"dw"],
//                                               @"t": @[@"  ", @"1a", @"1b", @"1c", @"2a", @"2b", @"2c", @"3a", @"3b", @"4"],
//                                               @"n": @[@"  ", @"0", @"1", @"2"],
//                                               @"m": @[@"  ", @"0", @"1"],
//                                               @"zd":@[@"bph", @"jxa", @"jxw", @"zya"]};
//    NSDictionary *sourceDictionary = @{@"pg": _globalData.zdjgPGSelectIndex,
//                                       @"t": _globalData.zdjgTSelectIndex,
//                                       @"n": _globalData.zdjgNSelectIndex,
//                                       @"m": _globalData.zdjgMSelectIndex,
//                                       @"zd": _globalData.zdjgZDSelectIndex};
//    for (NSString *key in sourceDictionary) {
//        NSArray *array = pickViewSourceDictionary[key];
//        [dictionary setObject:array[((NSNumber *)sourceDictionary[key]).integerValue] forKey:key];
//    }
    return dictionary;
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