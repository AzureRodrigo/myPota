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

- (void)viewWillAppear:(BOOL)animated
{
    [self initScreenData];
    [self configNavBar];
    [super viewWillAppear:animated];
}

#pragma mark - Init Screen Data
- (void)initScreenData
{
    backScreen     = (p2_Package_Info *)[AppFunctions BACK_SCREEN:self number:1];
    typeScreen     = [backScreen getSelected];
    typeLink       = [backScreen getSelectedLink];
    
    NSString *tag = @"string";
    
    [appConnection START_CONNECT:typeLink timeForOu:15.F labelConnection:nil showView:NO block:^(NSData *result) {
        NSDictionary *allInfo = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:tag];
        
        for (NSDictionary *tmp in [allInfo objectForKey:tag])
        {
            [webView loadHTMLString:[tmp objectForKey:tag]baseURL:nil];
            [webView setScalesPageToFit:YES];
        }

    }];
}

@end
