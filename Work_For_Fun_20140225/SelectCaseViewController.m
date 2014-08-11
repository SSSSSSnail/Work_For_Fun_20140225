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

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
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
    if (GInstance().caseNumber == CaseNumberOne) {
        _bgImageView.image = [UIImage imageNamed:@"selectCase"];
    }
    if (GInstance().caseNumber == CaseNumberTwo) {
        _bgImageView.image = [UIImage imageNamed:@"selectCase2"];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickCaseButton:(UIButton *)sender {
    if (sender.tag == GInstance().caseNumber) {
        sender.selected = YES;
        _selectedCase = sender.tag;
    }
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
                                 if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
                                     globalData.hasAddtoGroup = @"Y";
                                     [GInstance() savaData];
                                     [self performSegueWithIdentifier:@"modalToMain" sender:self];
                                 } else {
                                     [GInstance() showErrorMessage:@"初始化失败，请选择其他组名 !"];
                                 }
                             }];
    } else if (_selectedCase == 2) {
        LLGlobalData *globalData = GInstance().globalData;
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Case2" bundle:nil];
        UIViewController* case2mainViewController = [secondStoryBoard instantiateViewControllerWithIdentifier:@"Case2MainViewController"];
        
        if ([globalData.hasAddtoGroup isEqualToString:@"Y"]) {
            [self presentViewController:case2mainViewController animated:YES completion:^{}];
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
                                 if ([(NSString *)jsonDic[@"result"] isEqualToString:@"true"]){
        globalData.hasAddtoGroup = @"Y";
        [GInstance() savaData];
        [self presentViewController:case2mainViewController animated:YES completion:^{}];
    } else {
                                     [GInstance() showErrorMessage:@"初始化失败，请选择其他组名 !"];
                                 }
                             }];
    } else {
        [GInstance() showInfoMessage:@"请先选择本次讨论Case!"];
    }
}
@end
