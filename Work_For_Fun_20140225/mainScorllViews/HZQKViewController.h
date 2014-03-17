//
//  HZQKViewController.h
//  Work_For_Fun_20140225
//
//  Created by Snail on 14/3/14.
//  Copyright (c) 2014 Snail. All rights reserved.
//

#import "ScrollViewControllerDelegate.h"

@interface HZQKViewController : UIViewController

@property (weak, nonatomic) id<ScrollViewControllerDelegate> scrollViewDelegate;

- (void)reloadViewDataForR2;
@end
