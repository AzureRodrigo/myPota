//
//  sendInvitePota.m
//  myPota
//
//  Created by Rodrigo Pimentel on 30/06/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "b4_User_Invite_Pota.h"

@implementation b4_User_Invite_Pota

- (void)viewDidLoad
{
    [btnName setDelegate:self];
    [btnName setTag:1];
    [btnMail setDelegate:self];
    [btnMail setTag:2];
    [super viewDidLoad];
}

#pragma mark -configNavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PERFIL
                                     title:@""
                                superTitle:@""
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_BACK
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:nil
                                backButton:YES];
    [AppFunctions KEYBOARD_ADD_BAR:@[btnName, btnMail]
                          delegate:self
                            change:@selector(textFieldDidChange:)
                              done:@selector(keyboardDone:)
                            cancel:@selector(keyboardClear:)];
}

- (IBAction)btnBackScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Numeric keyboard Clear
- (IBAction)keyboardClear:(UIBarButtonItem *)sender
{
    [txtViewSelected setText:@""];
    [self->otlMail setEnabled:NO];
}

#pragma mark - Numeric keyboard Done
- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    [self setInfoTextView:txtViewSelected];
    [txtViewSelected resignFirstResponder];
}

#pragma mark - keyboard Change Content
- (void)textFieldDidChange:(UITextField *)theTextField
{
    if ([self sendInvite])
        [self->otlMail setEnabled:YES];
    else
        [self->otlMail setEnabled:NO];
}

#pragma mark - configNavBar and keyboard
- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [super viewWillAppear:animated];
}

- (IBAction)btnMail:(id)sender
{
    NSString *message = [NSString stringWithFormat:WS_MAIL_INVITE, btnName.text, WS_MAIL_LOGO];
    NSString *wsComplement = [NSString stringWithFormat:WS_URL_MAIL_SENDER, KEY_ID_WS,  KEY_CODE_SITE, WS_MAIL_FROM, btnMail.text,  WS_MAIL_SUBJECT,  message,  KEY_EMPTY,  KEY_EMPTY];
    NSString *link = [NSString stringWithFormat:WS_URL, WS_URL_MAIL, wsComplement];
    
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : SEARCH_POTA_LABEL_CONNECTION_START_CITY,
                                       APP_CONNECTION_TAG_WAIT 	 : SEARCH_POTA_LABEL_CONNECTION_WAIT_CITY,
                                       APP_CONNECTION_TAG_RECIVE : SEARCH_POTA_LABEL_CONNECTION_RECIVE_CITY,
                                       APP_CONNECTION_TAG_FINISH : SEARCH_POTA_LABEL_CONNECTION_FINISH_CITY,
                                       APP_CONNECTION_TAG_ERROR  : SEARCH_POTA_LABEL_CONNECTION_ERROR_CITY };
    
    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:labelConnections showView:YES block:^(NSData *result) {
        NSDictionary *allCitys = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:TAG_SEND_MAIL];
        if (allCitys == NULL)
            [AppFunctions LOG_MESSAGE:ERROR_1002_TITLE
                              message:ERROR_1002_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
        else {
            for (NSDictionary *tmp in [allCitys objectForKey:TAG_SEND_MAIL])
                if ([[tmp objectForKey:TAG_SEND_MAIL] isEqualToString:TAG_SEND_MAIL_SUCCESS]) {
                    [AppFunctions LOG_MESSAGE:LOG_TITLE_MAIL_SUCCESS
                                      message:LOG_TEXT_MAIL_SUCCESS
                                       cancel:LOG_BUTTON_CANCEL];
                    break;
                }
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}

#pragma mark - text Views
- (BOOL)textFieldShouldBeginEditing:(UITextView *)textView
{
    [self setInfoTextView:txtViewSelected];
    txtViewSelected = (UITextField *)textView;
    if (textView.tag == 1)
        [self unClearText:btnName];
    else
        [self unClearText:btnMail];
    [self clearText:textView];
    return YES;
}

- (void)clearText:(UITextView *)textView
{
    if (textView.tag == 1){
        if ([textView.text isEqualToString:@"Nome da Agência"])
            textView.text = @"";
    }
    else
        if ([textView.text isEqualToString:@"E-mail"])
            textView.text = @"";
}

- (void)unClearText:(UITextField *)textView
{
    [self setInfoTextView:txtViewSelected];
    
}

#pragma mark - textViewFunction Switch fild
- (void)setInfoTextView:(UITextField *)textView
{
    if (textView.tag == 1){
        if ([textView.text isEqualToString:@""])
            textView.text = @"Nome da Agência";
    }
    else
        if ([textView.text isEqualToString:@""])
            textView.text = @"E-mail";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 1)
        btnName.text = textField.text;
    else
        if ([AppFunctions VALID_MAIL:textField.text])
            btnMail.text = textField.text;
    
    if ([self sendInvite])
        [self->otlMail setEnabled:YES];
    else
        [self->otlMail setEnabled:NO];
    
    [self unClearText:textField];
    [textField resignFirstResponder];
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self sendInvite])
        [self->otlMail setEnabled:YES];
    else
        [self->otlMail setEnabled:NO];
    return YES; 
}

- (BOOL)sendInvite
{
    if (![btnName.text isEqualToString:@""] && [AppFunctions VALID_MAIL:btnMail.text])
        return YES;
    return NO;
}


@end
