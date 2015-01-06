//
//  gearPOTA.m
//  myPota
//
//  Created by Rodrigo Pimentel on 11/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "gearPOTA.h"

@interface gearPOTA ()

@end

@implementation gearPOTA

#pragma mark - screenConfigure
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_CLEAN
                                     title:@"Ferramentas"
                                superTitle:@""
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_INIT
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:@selector(menuOpen:)
                                backButton:YES];
}

- (IBAction)menuOpen:(id)sender
{
//    [menuView openMenu:sender];
}

- (IBAction)btnBackScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initScroll
{
    [AppFunctions SET_SCROLL:scrollViewData
                       frame:gearMapa.frame
                      center:gearMapa.center];
}

#pragma mark -configNavBar
- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [self initScroll];
    self->backScreen = (b2_User_Pefil_Pota *)[AppFunctions BACK_SCREEN:self number:1];
    [super viewWillAppear:animated];
}

- (IBAction)btnFuso:(id)sender
{
}

- (IBAction)btnCambio:(id)sender
{
}

- (IBAction)btnConversor:(id)sender
{
}

- (IBAction)btnFones:(id)sender
{
}

- (IBAction)btnGuia:(id)sender
{
}

- (IBAction)btnMapa:(id)sender
{
}

@end
