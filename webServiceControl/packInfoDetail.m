//
//  packInfoDetail.m
//  myPota
//
//  Created by Rodrigo Pimentel on 03/11/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "packInfoDetail.h"

@interface packInfoDetail ()

@end

@implementation packInfoDetail

#pragma mark -configNavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PACKAGE
                                     title:@""
                                superTitle:@""
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
    [self configNavBar];
    [self initScreenData];
    [super viewWillAppear:animated];
}

#pragma mark - Init Screen Data
- (void)initScreenData
{
    backScreen     = (packInfo *)[AppFunctions BACK_SCREEN:self number:1];
    typeScreen     = [backScreen getSelected];
    typeLink       = [backScreen getSelectedLink];
    
    NSLog(@"%@", typeLink);
    
    NSString *tag = @"string";
    
    [appConnection START_CONNECT:typeLink timeForOu:15.F labelConnection:nil showView:NO block:^(NSData *result) {
        NSDictionary *allInfo = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:tag];
        
        for (NSDictionary *tmp in [allInfo objectForKey:tag])
        {
            [webView loadHTMLString:[tmp objectForKey:tag]baseURL:nil];
            [webView setScalesPageToFit:YES];
        }

    }];
    
    [lblTitle setText:typeScreen];


}

@end
