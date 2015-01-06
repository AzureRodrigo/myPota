//
//  splitViewMenu.m
//  myPota
//
//  Created by Rodrigo Pimentel on 18/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "AppMenuView.h"

@implementation AppMenuView

static AppMenuView   *menuView       = nil;
static splitViewPota *menuController = nil;

@synthesize superView;

+ (AppMenuView *)getMenuView
{
    return menuView;
}

+ (splitViewPota *)getMenuController
{
    return menuController;
}

+ (void)openMenu:(UIViewController *)_superView sender:(id)sender
{
    if (menuView == nil) {
        menuView = [[AppMenuView alloc] initMenu:_superView];
    } else {
        [menuView newSuperView:_superView];
    }
    
    [menuView openMenu:sender];
}

- (id)initMenu:(UIViewController *)_superView
{
    if (self = [super init])
    {
        self->superView = _superView;
        superView.slideNavigationViewController.delegate   = self;
        superView.slideNavigationViewController.dataSource = self;
    }
    return self;
}

- (void)newSuperView:(UIViewController *)_superView
{
    self->superView = _superView;
    superView.slideNavigationViewController.delegate   = self;
    superView.slideNavigationViewController.dataSource = self;
}

- (IBAction)openMenu:(id)sender
{
    [self splitLeft:sender];
}

#pragma mark Actions
- (void) _slide:(MWFSlideDirection)direction {
    [superView.slideNavigationViewController slideWithDirection:direction];
}

- (void) splitLeft:(id)sender
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    [superView.navigationController.navigationBar setHidden:YES];
    [self _slide:MWFSlideDirectionLeft];
}

- (void) splitClose:(id)sender
{
    [self _slide:MWFSlideDirectionNone];
}

#define VIEWTAG_ID 5000
#pragma mark - SplitView Define Start
- (void) slideNavigationViewController:(MWFSlideNavigationViewController *)controller willPerformSlideFor:(UIViewController *)targetController withSlideDirection:(MWFSlideDirection)slideDirection distance:(CGFloat)distance orientation:(UIInterfaceOrientation)orientation {
    
    if (slideDirection == MWFSlideDirectionNone) {
        UIView * overlay = [superView.navigationController.view viewWithTag:VIEWTAG_ID];
        [overlay removeFromSuperview];
    } else {
        UIView * overlay = [[UIView alloc] initWithFrame:superView.navigationController.view.bounds];
        overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        overlay.tag = VIEWTAG_ID;
        UITapGestureRecognizer * gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(splitClose:)];
        [overlay addGestureRecognizer:gr];
        overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [superView.navigationController.view addSubview:overlay];
    }
}

#pragma mark - SplitView Shadow View
- (void) slideNavigationViewController:(MWFSlideNavigationViewController *)controller animateSlideFor:(UIViewController *)targetController withSlideDirection:(MWFSlideDirection)slideDirection distance:(CGFloat)distance orientation:(UIInterfaceOrientation)orientation
{
    UIView * overlay = [superView.navigationController.view viewWithTag:VIEWTAG_ID];
    if (slideDirection == MWFSlideDirectionNone)
        overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    else
        overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
}

#pragma mark - SplitView Slide Distance Controll
- (NSInteger) slideNavigationViewController:(MWFSlideNavigationViewController *)controller distanceForSlideDirecton:(MWFSlideDirection)direction portraitOrientation:(BOOL)portraitOrientation
{
    if (portraitOrientation)
        return 260;
    else
        return 100;
}

#pragma mark - Adiciona UIView que será chamada
- (UIViewController *) slideNavigationViewController:(MWFSlideNavigationViewController *)controller viewControllerForSlideDirecton:(MWFSlideDirection)direction
{
    if (menuController == nil) {
        menuController = [[splitViewPota alloc] init];
    }
    
    menuController.container = [[UIView alloc] initWithFrame:superView.view.bounds];
    [menuController.container addSubview:[[UIScreen mainScreen] snapshotViewAfterScreenUpdates:NO]];
    [superView.view addSubview:menuController.container];
    [superView setNeedsStatusBarAppearanceUpdate];
    
    return menuController;
}

@end