//
//  packInfoDetail.m
//  myPota
//
//  Created by Rodrigo Pimentel on 03/11/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "p3_Package_Detail.h"

@implementation p3_Package_Detail

#pragma mark -configNavBar
- (void)configNavBar
{
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:typeScreen
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
    HUD.labelText = @"Carregando Informações.";
    [HUD show:YES];
    
    backScreen     = (p2_Package_Info *)[AppFunctions BACK_SCREEN:self number:1];
    typeScreen     = [backScreen getSelected];
    typeLinkInfo   = [backScreen getSelectedLink:1];
    typeLinkDay    = [backScreen getSelectedLink:2];
    typeLinkCondictions = [backScreen getSelectedLink:3];

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
    NSString *tag = @"string";
    
    [appConnection START_CONNECT:typeLinkInfo timeForOu:15.F labelConnection:nil showView:NO block:^(NSData *result) {
        NSDictionary *allInfo = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:tag];
        for (NSDictionary *tmp in [allInfo objectForKey:tag]) {
            typeLinkInfo = [tmp objectForKey:tag];
        }
        [appConnection START_CONNECT:typeLinkDay timeForOu:15.F labelConnection:nil showView:NO block:^(NSData *result) {
            NSDictionary *allInfo = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:tag];
            for (NSDictionary *tmp in [allInfo objectForKey:tag]) {
                typeLinkDay = [tmp objectForKey:tag];
            }
            

            [webView loadHTMLString:[NSString stringWithFormat:@"%@ %@",typeLinkInfo, typeLinkDay] baseURL:nil];
            [webView setScalesPageToFit:YES];

            [webView setBackgroundColor:[UIColor clearColor]];
            [HUD hide:YES];
        }];
    }];
}

- (NSString *)getLink
{
    return typeLinkCondictions;
}

@end