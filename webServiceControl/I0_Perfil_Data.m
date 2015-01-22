//
//  I0_Perfil_Data.m
//  myPota
//
//  Created by Rodrigo Pimentel on 05/06/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "I0_Perfil_Data.h"

@interface I0_Perfil_Data ()

@end

@implementation I0_Perfil_Data

- (void)configScreen
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PERFIL
                                     title:@"Meu "
                                superTitle:@"Perfil"
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_INIT
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:nil
                                backButton:YES];
}

- (IBAction)btnBackScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configPerfil
{
    dataPerfil = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_PERFIL];
    
    [lblName  setText:[dataPerfil objectForKey:TAG_USER_PERFIL_NAME]];
    [lblMail  setText:[dataPerfil objectForKey:TAG_USER_PERFIL_MAIL]];
    [lblCPF   setText:[dataPerfil objectForKey:TAG_USER_PERFIL_CPF]];
    [lblCEP   setText:[dataPerfil objectForKey:TAG_USER_PERFIL_CEP]];
    [lblBirth setText:[dataPerfil objectForKey:TAG_USER_PERFIL_BIRTH]];
    [lblCode  setText:[dataPerfil objectForKey:TAG_USER_PERFIL_CODE]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configScreen];
    [self configPerfil];
    [super viewWillAppear:animated];
}

@end
