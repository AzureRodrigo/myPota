//
//  infoPota.m
//  myPota
//
//  Created by Rodrigo Pimentel on 08/12/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "d0_Info_Pota.h"

@interface d0_Info_Pota ()

@end

@implementation d0_Info_Pota


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"packCircuits contem Warnings");
}

#pragma mark - configNavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_APP_VERSION
                                     title:nil
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
    [_lblVersion setText:[NSString stringWithFormat:@"Versão: %@",[[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey]]];
    [_lblContact setText:@"Suporte: atendimento@tzsystems.com.br"];
    
    [super viewDidLoad];
}

#pragma mark - willAppear
- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [super viewWillAppear:animated];
}

@end
