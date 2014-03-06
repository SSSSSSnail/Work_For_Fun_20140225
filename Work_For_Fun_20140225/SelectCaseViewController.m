//
//  SelectCaseViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 26/2/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "SelectCaseViewController.h"

@interface SelectCaseViewController ()

@property (assign, nonatomic) NSInteger selectedCase;

- (IBAction)clickCaseButton:(UIButton *)sender;
- (IBAction)clickStartButton:(UIButton *)sender;

@end

@implementation SelectCaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickCaseButton:(UIButton *)sender {
    sender.selected = YES;
    _selectedCase = 1;
}

- (IBAction)clickStartButton:(UIButton *)sender {
    // 1. check group in settings


    if (_selectedCase == 1) {
        [GInstance() httprequestWithHUD:self.view
                         withRequestURL:SERVERURL
                         withParameters:@{@"step":@"0", @"action":@"getsubject"}
                             completion:^(NSDictionary *jsonDic) {
                                 NSLog(@"responseJson: %@", jsonDic);
                                 if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                     [GInstance() loadData];
                                     NSString *subjectid = (NSString *)jsonDic[@"subject_id"];
                                     if (![subjectid isEqualToString:GInstance().globalData.subjectName]) {
                                         [GInstance() backupData];
                                         GInstance().globalData.subjectName = subjectid;
                                         GInstance().globalData.groupNumber = @"1";
                                         [GInstance() savaData];
                                     }
                                      //[self performSegueWithIdentifier:@"modalToMain" sender:self];
                                 } else {
                                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"服务器结果异常!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                     [alertView show];
                                 }
                             }];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先选择本次讨论Case!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
}
@end
