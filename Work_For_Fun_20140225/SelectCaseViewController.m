//
//  SelectCaseViewController.m
//  Work_For_Fun_20140225
//
//  Created by Snail on 26/2/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "SelectCaseViewController.h"
#import "AppDelegate.h"
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
    // 1. 检查设置中是否已经选择了组
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *groupNumber = [defaults objectForKey:GroupNo];
    NSLog(@"Settings groupNumber : %@", groupNumber);
    if (!groupNumber) {
        [GInstance() showErrorMessage:@"首次启动应用请先到设置分组!"];
        return;
    } else {
        GInstance().globalData.groupNumber = groupNumber;
    }
    // 2. 请求Server拿到课题号, 并创建本次的plist。
    if (_selectedCase == 1) {
        /*
         subject.do?step=0&action=addgroup&subject_id=1&group_id=g1
         */
    
        LLGlobalData *globalData = GInstance().globalData;
        if ([globalData.hasAddtoGroup isEqualToString:@"Y"]) {
            [self performSegueWithIdentifier:@"modalToMain" sender:self];
            return;
        }
        NSDictionary *parameterDictionary = @{@"step": @"0",
                                              @"action": @"addgroup",
                                              @"subject_id": globalData.subjectId,
                                              @"group_id": groupNumber};
        [GInstance() httprequestWithHUD:self.view
                         withRequestURL:SERVERURL
                         withParameters:parameterDictionary
                             completion:^(NSDictionary *jsonDic) {
                                 NSLog(@"responseJson: %@", jsonDic);
#warning TODO: 请求服务器创建分组
                                 if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                     globalData.hasAddtoGroup = @"Y";
                                     [GInstance() savaData];
                                     [self performSegueWithIdentifier:@"modalToMain" sender:self];
                                 } else {
                                     [GInstance() showErrorMessage:@"初始化失败，请检查组名 !"];
                                 }
                             }];
    } else {
        [GInstance() showInfoMessage:@"请先选择本次讨论Case!"];
    }
}
@end
