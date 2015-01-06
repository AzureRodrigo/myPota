//
//  AppMenuView.h
//  myPota
//
//  Created by Rodrigo Pimentel on 18/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFSlideNavigationViewController.h"
#import "splitViewPota.h"

@interface AppMenuView : NSObject <MWFSlideNavigationViewControllerDelegate, MWFSlideNavigationViewControllerDataSource>

@property (strong, nonatomic) UIViewController *superView;
+ (void)openMenu:(UIViewController *)_superView sender:(id)sender;
+ (AppMenuView *)getMenuView;
+ (splitViewPota *)getMenuController;

@end
