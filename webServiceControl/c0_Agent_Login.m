//
//  c0_Agent_Login.m
//  myPota
//
//  Created by Rodrigo Pimentel on 08/09/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "c0_Agent_Login.h"

@implementation c0_Agent_Login

#pragma mark - configScreen
- (void)configScreen
{
    [txtLogin     setAccessibilityValue:@"Login"];
    [txtPassword setAccessibilityValue:@"Senha"];
    login        = [NSMutableDictionary new];
}

- (void)configComponents
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PERFIL
                                     title:@""
                                superTitle:@""
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_BACK
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:nil
                                backButton:YES];
    
    [AppFunctions KEYBOARD_ADD_BAR:@[txtLogin, txtPassword]
                          delegate:self
                            change:@selector(textFieldDidChange:)
                              done:@selector(keyboardDone:)
                            cancel:@selector(keyboardClear:)];
}

#pragma mark - IBAction's
- (IBAction)btnBackScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)keyboardClear:(UIBarButtonItem *)sender
{
    [txtSelect setText:@""];
    [self setLogin:txtSelect];
}

- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    [txtSelect resignFirstResponder];
    [self setLogin:txtSelect];
}

#pragma mark - Textfield Functions
- (void)textFieldDidChange :(UITextField *)textField
{
    [self setLogin:textField];
}

- (BOOL)textFieldShouldBeginEditing:(UITextView *)textView
{
    if ([textView.accessibilityValue isEqualToString:@"Login"])
        if ([textView.text isEqualToString:@"Login"])
            textView.text = @"";
    if ([textView.accessibilityValue isEqualToString:@"Senha"])
        if ([textView.text isEqualToString:@"Senha"])
            textView.text = @"";
    
    txtSelect = (UITextField *)textView;
    
    [AppFunctions TEXT_SCREEN_UP:self
                        textView:textView
                           frame:frame];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""])
    {
        if ([textField.accessibilityValue isEqualToString:@"Login"])
            textField.text = @"Login";
        else
            textField.text = @"Senha";
    }
    
    [self setLogin:textField];
    [AppFunctions TEXT_SCREEN_DOWN:self textField:textField frame:frame];
    
    return YES;
}

#pragma mark - View Actions
- (void)viewDidLoad
{
    [self configScreen];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configComponents];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    frame = self.view.frame;
    [super viewDidAppear:animated];
}

- (IBAction)btnConfigApp:(id)sender
{
    [self login_stepI];
}

#pragma mark - Functions
- (void)setLogin:(UITextField *)textField
{
    if (textField != NULL)
        [login setObject:textField.text
                  forKey:textField.accessibilityValue];
    if ([login objectForKey:@"Login"] != NULL && ![[login objectForKey:@"Login"] isEqualToString:@""] && ![[login objectForKey:@"Login"] isEqualToString:@"Login"] &&
        [login objectForKey:@"Senha"]  != NULL && ![[login objectForKey:@"Senha"]  isEqualToString:@""])
        [btnOtlConfigApp setEnabled:YES];
    else
        [btnOtlConfigApp setEnabled:NO];
}

#pragma mark - Configurações de Web Service
- (void)login_stepI
{
    user = [NSMutableDictionary new];
    
    NSString *link;
    NSString *wsComplement = [NSString stringWithFormat:WS_c0_CADASTRE_SELLER,
                              TAG_B0_C0_CADASTRE_LOGIN,txtLogin.text,txtPassword.text,TAG_BASE_WS_ACESS_KEY,TAG_BASE_WS_TYPE_RETURN];
    link = [NSString stringWithFormat:WS_URL, WS_c0_CADASTRE, wsComplement];
    
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : CODE_POTA_LABEL_CONNECTION_START,
                                       APP_CONNECTION_TAG_WAIT   : CODE_POTA_LABEL_CONNECTION_WAIT,
                                       APP_CONNECTION_TAG_RECIVE : CODE_POTA_LABEL_CONNECTION_RECIVE,
                                       APP_CONNECTION_TAG_FINISH : CODE_POTA_LABEL_CONNECTION_FINISH,
                                       APP_CONNECTION_TAG_ERROR  : CODE_POTA_LABEL_CONNECTION_ERROR };
    
    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:labelConnections showView:YES block:^(NSData *result) {
        if (result == nil) {
            [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                              message:ERROR_1000_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
        } else {
         NSDictionary *info = [AzParser xmlDictionary:result tagNode:TAG_C0_CADASTRE_OPEN];
            for (NSDictionary *tmp in [info objectForKey:TAG_C0_CADASTRE_OPEN])
            {
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_NAME]            forKey:TAG_C0_CADASTRE_NAME];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_COD]             forKey:TAG_C0_CADASTRE_COD];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_COD_MD5]         forKey:TAG_C0_CADASTRE_COD_MD5];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_MAIL]            forKey:TAG_C0_CADASTRE_MAIL];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_CPF]             forKey:TAG_C0_CADASTRE_CPF];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_FONE]            forKey:TAG_C0_CADASTRE_FONE];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_CEL]             forKey:TAG_C0_CADASTRE_CEL];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_AGE]             forKey:TAG_C0_CADASTRE_AGE];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_SEX]             forKey:TAG_C0_CADASTRE_SEX];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_FACEBOOK]        forKey:TAG_C0_CADASTRE_FACEBOOK];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_SKYPE]           forKey:TAG_C0_CADASTRE_SKYPE];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_WHATSAPP]        forKey:TAG_C0_CADASTRE_WHATSAPP];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_GTALK]           forKey:TAG_C0_CADASTRE_GTALK];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_DATA_CADASTRE]   forKey:TAG_C0_CADASTRE_DATA_CADASTRE];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_NAME_AGENCY]     forKey:TAG_C0_CADASTRE_NAME_AGENCY];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_SITE_AGENCY]     forKey:TAG_C0_CADASTRE_SITE_AGENCY];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_ADRESS_AGENCY]   forKey:TAG_C0_CADASTRE_ADRESS_AGENCY];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_QUARTER_AGENCY]  forKey:TAG_C0_CADASTRE_QUARTER_AGENCY];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_CEP_AGENCY]      forKey:TAG_C0_CADASTRE_CEP_AGENCY];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_FACEBOOK_AGENCY] forKey:TAG_C0_CADASTRE_FACEBOOK_AGENCY];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_TWITTER_AGENCY]  forKey:TAG_C0_CADASTRE_TWITTER_AGENCY];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_YOUTUBE_AGENCY]  forKey:TAG_C0_CADASTRE_YOUTUBE_AGENCY];
                [user setObject:[tmp objectForKey:TAG_C0_CADASTRE_GOOGLE_AGENCY]   forKey:TAG_C0_CADASTRE_GOOGLE_AGENCY];
                [user setObject:[AppFunctions GET_TOKEN_DEVICE]                    forKey:TAG_B0_C0_REGISTER_COD_TOKEN];
            }
            [self login_stepII];
        }
    }];
}

- (void)login_stepII
{
    NSString *link;
    NSString *wsComplement = [NSString stringWithFormat:WS_b0_c0_REGISTER_FONE,
                              [user objectForKey:TAG_C0_CADASTRE_COD_MD5],
                              [user objectForKey:TAG_B0_C0_REGISTER_COD_TOKEN],
                              @"I",@"appMobile", @"XML"];
    link = [NSString stringWithFormat:WS_URL, WS_b0_c0_REGISTER, wsComplement];
    
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : CODE_POTA_LABEL_CONNECTION_START,
                                       APP_CONNECTION_TAG_WAIT   : CODE_POTA_LABEL_CONNECTION_WAIT,
                                       APP_CONNECTION_TAG_RECIVE : CODE_POTA_LABEL_CONNECTION_RECIVE,
                                       APP_CONNECTION_TAG_FINISH : CODE_POTA_LABEL_CONNECTION_FINISH,
                                       APP_CONNECTION_TAG_ERROR  : CODE_POTA_LABEL_CONNECTION_ERROR };
    
    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:labelConnections showView:YES block:^(NSData *result) {
        if (result == nil) {
            [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                              message:ERROR_1000_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
        } else {
            NSDictionary *info = [AzParser xmlDictionary:result tagNode:TAG_B0_C0_REGISTER];
            for (NSDictionary *tmp in [info objectForKey:TAG_B0_C0_REGISTER])
                if ([[tmp objectForKey:TAG_B0_C0_REGISTER] isEqualToString:@"OK"])
                    [self saveData];
        }
    }];
}

- (void)saveData
{
    fetch = [AppFunctions DATA_BASE_ENTITY_GET:fetch
                                      delegate:self
                                        entity:TAG_DATA_USER_SELLER
                                          sort:TAG_C0_CADASTRE_NAME];
    
    NSManagedObject *dataBD = [AppFunctions DATA_BASE_ENTITY_ADD:fetch];
    
    //set data in BD
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_NAME]            forKey:TAG_C0_CADASTRE_NAME];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_COD]             forKey:TAG_C0_CADASTRE_COD];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_COD_MD5]         forKey:TAG_C0_CADASTRE_COD_MD5];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_MAIL]            forKey:TAG_C0_CADASTRE_MAIL];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_CPF]             forKey:TAG_C0_CADASTRE_CPF];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_FONE]            forKey:TAG_C0_CADASTRE_FONE];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_CEL]             forKey:TAG_C0_CADASTRE_CEL];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_AGE]             forKey:TAG_C0_CADASTRE_AGE];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_SEX]             forKey:TAG_C0_CADASTRE_SEX];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_FACEBOOK]        forKey:TAG_C0_CADASTRE_FACEBOOK];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_SKYPE]           forKey:TAG_C0_CADASTRE_SKYPE];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_WHATSAPP]        forKey:TAG_C0_CADASTRE_WHATSAPP];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_GTALK]           forKey:TAG_C0_CADASTRE_GTALK];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_DATA_CADASTRE]   forKey:TAG_C0_CADASTRE_DATA_CADASTRE];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_NAME_AGENCY]     forKey:TAG_C0_CADASTRE_NAME_AGENCY];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_SITE_AGENCY]     forKey:TAG_C0_CADASTRE_SITE_AGENCY];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_ADRESS_AGENCY]   forKey:TAG_C0_CADASTRE_ADRESS_AGENCY];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_QUARTER_AGENCY]  forKey:TAG_C0_CADASTRE_QUARTER_AGENCY];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_CEP_AGENCY]      forKey:TAG_C0_CADASTRE_CEP_AGENCY];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_FACEBOOK_AGENCY] forKey:TAG_C0_CADASTRE_FACEBOOK_AGENCY];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_TWITTER_AGENCY]  forKey:TAG_C0_CADASTRE_TWITTER_AGENCY];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_YOUTUBE_AGENCY]  forKey:TAG_C0_CADASTRE_YOUTUBE_AGENCY];
    [dataBD setValue:[user objectForKey:TAG_C0_CADASTRE_GOOGLE_AGENCY]   forKey:TAG_C0_CADASTRE_GOOGLE_AGENCY];
    
    if ([AppFunctions DATA_BASE_ENTITY_SAVE:fetch])
        [self nextScreen];
    else
        [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                          message:ERROR_1000_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
}

- (void)nextScreen
{
    [AppFunctions GO_TO_SCREEN:self destiny:SEGUE_C0_TO_C1];
}

@end
