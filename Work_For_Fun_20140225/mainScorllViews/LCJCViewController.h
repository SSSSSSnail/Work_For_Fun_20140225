//
//  LCJCViewController.h
//  Work_For_Fun_20140225
//
//  Created by Snail on 15/3/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "ScrollViewControllerDelegate.h"

@interface LCJCViewController : UIViewController

@property (weak, nonatomic) id<ScrollViewControllerDelegate> scrollViewDelegate;
@property (assign, nonatomic) BOOL isLocked;

- (void)reloadViewDataForR2;

@end
