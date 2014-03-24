//
//  CoverViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 26/2/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "CoverViewController.h"

@interface CoverViewController ()

@end

@implementation CoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *swipeGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(swipeup:)];
    [self.view addGestureRecognizer:swipeGes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)swipeup:(UISwipeGestureRecognizer *)recognizer
{
    NSDictionary *parametersDictionary = @{@"step": @"0",
                                           @"action": @"getsubject"};
    [GInstance() httprequestWithHUD:self.view
                     withRequestURL:SERVERURL
                     withParameters:parametersDictionary
                         completion:^(NSDictionary *jsonDic) {
                             NSLog(@"responseJson: %@", jsonDic);
                             if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                 [GInstance() loadData];
                                 NSString *subjectid = (NSString *)jsonDic[@"subject_id"];                               
                                 if (![subjectid isEqualToString:GInstance().globalData.subjectId]) {
                                     if (GInstance().globalData.subjectId) {
                                         [GInstance() backupData];
                                     }
                                     GInstance().globalData = [[LLGlobalData alloc] init];
                                     GInstance().globalData.subjectId = subjectid;
                                     GInstance().globalData.subjectName = (NSString *)jsonDic[@"subject_name"];
                                     [GInstance() savaData];
                                 }
                                 [self performSegueWithIdentifier:@"modalToCover2" sender:self];
                             } else {
                                 [GInstance() showErrorMessage:@"服务器结果异常!"];
                             }
                         }];
}

@end
