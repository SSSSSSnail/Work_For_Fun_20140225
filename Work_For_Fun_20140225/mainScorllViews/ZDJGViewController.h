//
//  ZDJGViewController.h
//  Work_For_Fun_20140225
//
//  Created by Snail on 15/3/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "ScrollViewControllerDelegate.h"

@interface ZDJGViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) id<ScrollViewControllerDelegate> scrollViewDelegate;

- (void)loadDataFromGlobalData;

- (void)reloadViewDataForR2;


@end
