//
//  p3_1_Package_Conditions.m
//  mypota
//
//  Created by Rodrigo Pimentel on 02/04/15.
//  Copyright (c) 2015 web. All rights reserved.
//

#import "p3_1_Package_Conditions.h"

@interface p3_1_Package_Conditions ()

@end

@implementation p3_1_Package_Conditions

#pragma mark -configNavBar
- (void)configNavBar
{
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:@"Condições Gerais"
                                                               attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                            NSFontAttributeName: [UIFont fontWithName:FONT_NAME_BOLD size:18]}];
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_GENERIC
                                     title:title
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_CLEAR
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:nil
                                backButton:YES];
}

- (IBAction)btnBackScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.dimBackground = YES;
    HUD.delegate  = self;
    HUD.labelText = @"Carregando Condições.";
    [HUD show:YES];
    [self initScreenData];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [super viewWillAppear:animated];
}

#pragma mark - Init Screen Data
- (void)initScreenData
{
    backScreen     = (p3_Package_Detail *)[AppFunctions BACK_SCREEN:self number:1];
    typeScreen     = [backScreen getLink];
    NSString *tag = @"string";
    [appConnection START_CONNECT:typeScreen timeForOu:15.F labelConnection:nil showView:NO block:^(NSData *result) {
        NSDictionary *allInfo = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:tag];
        for (NSDictionary *tmp in [allInfo objectForKey:tag]) {
            [webView loadHTMLString:[tmp objectForKey:tag] baseURL:nil];
            [webView setScalesPageToFit:YES];
        }
        
        [HUD hide:YES];
    }];
}

@end
