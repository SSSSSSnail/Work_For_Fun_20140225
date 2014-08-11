//
//  CoverViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 26/2/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "CoverViewController.h"

@interface CoverViewController ()<UIAlertViewDelegate>

@property (copy, nonatomic) NSString *validationCode;
@property (strong, nonatomic) UIAlertView *validationCodeAlertView;

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
#ifndef SKIPREQUEST
    if (!GInstance().validatedCode) {
        NSDictionary *parametersDictionary = @{@"step": @"0",
                                               @"action": @"getsubject"};
        [GInstance() httprequestWithHUD:self.view
                         withRequestURL:SERVERURL
                         withParameters:parametersDictionary
                             completion:^(NSDictionary *jsonDic) {
                                 NSLog(@"responseJson: %@", jsonDic);
                                 if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                     GInstance().caseNumber = ((NSString *)jsonDic[@"case_id"]).intValue;
                                     [GInstance() loadData];
                                     NSString *subjectid = (NSString *)jsonDic[@"subject_id"];
                                     if (![subjectid isEqualToString:GInstance().globalData.subjectId]) {
                                         if (GInstance().globalData.subjectId) {
                                             [GInstance() backupData];
                                         }
                                         [GInstance() initData];
                                         GInstance().globalData.subjectId = subjectid;
                                         GInstance().globalData.subjectName = (NSString *)jsonDic[@"subject_name"];
                                         [GInstance() savaData];
                                     }

                                     self.validationCode = (NSString *)jsonDic[@"validation_code"];
                                     self.validationCodeAlertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请输入本次会议验证码！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                     _validationCodeAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
                                     [_validationCodeAlertView dismissWithClickedButtonIndex:1 animated:NO];
                                     [_validationCodeAlertView show];
                                 } else {
                                     [GInstance() showErrorMessage:@"服务器结果异常!"];
                                 }
                             }];
    } else {
        [self performSegueWithIdentifier:@"modalToCover2" sender:self];
    }
#endif
#ifdef SKIPREQUEST
    GInstance().caseNumber = CaseNumberTwo;
    [GInstance() loadData];
    NSString *subjectid = [[NSDate date] description];
    if (![subjectid isEqualToString:GInstance().globalData.subjectId]) {
        if (GInstance().globalData.subjectId) {
            [GInstance() backupData];
        }
        [GInstance() initData];
        GInstance().globalData.subjectId = subjectid;
        GInstance().globalData.subjectName = @"TestName";
        GInstance().globalData.groupNumber = @"Test";
        [GInstance() savaData];
    }
//    [self performSegueWithIdentifier:@"modalToCover2" sender:self];

    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Case2" bundle:nil];
    UIViewController* case2mainViewController = [secondStoryBoard instantiateViewControllerWithIdentifier:@"Case2MainViewController"];
    GInstance().globalData.groupNumber = @"G1";
    [self presentViewController:case2mainViewController animated:YES completion:^{}];
#endif
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _validationCodeAlertView) {
        if (buttonIndex == 1) {
            UITextField *textField = [alertView textFieldAtIndex:0];
            if ([textField.text isEqualToString:_validationCode]) {
                GInstance().validatedCode = YES;
                [GInstance() showInfoMessage:@"验证码正确!"];
            } else {
                GInstance().validatedCode = NO;
                [GInstance() showErrorMessage:@"验证码错误，请点击重新输入!"];
                self.validationCode = nil;
            }
        }
    }
}

@end
