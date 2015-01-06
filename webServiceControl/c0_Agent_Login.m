//
//  c0_Agent_Login.m
//  myPota
//
//  Created by Rodrigo Pimentel on 08/09/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "c0_Agent_Login.h"

@implementation c0_Agent_Login

- (void)viewDidLoad
{
    [txtLogin    setAccessibilityValue:@"Login"];
    [txtPassword setAccessibilityValue:@"Senha"];
    login        = [NSMutableDictionary new];
    agenteInfo   = [NSMutableDictionary new];
    [super viewDidLoad];
}

#pragma mark - willAppear
- (void)viewWillAppear:(BOOL)animated
{
    [self configScreen];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    frame = self.view.frame;
    [super viewDidAppear:animated];
}

#pragma mark -configNavBar
- (void)configScreen
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_RESERVA
                                     title:@""
                                superTitle:@""
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_CLEAR
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:nil
                                backButton:YES];
    
    [AppFunctions KEYBOARD_ADD_BAR:@[txtLogin, txtPassword]
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
    [self setInfoTextView:txtViewSelected];
}

#pragma mark - Numeric keyboard Done
- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    [self setInfoTextView:txtViewSelected];
    [txtViewSelected resignFirstResponder];
}

#pragma mark - keyboard Change Content
- (void)textFieldDidChange :(UITextField *)theTextField
{
    [login setObject:theTextField.text
              forKey:theTextField.accessibilityValue];
    if ([login objectForKey:@"Login"] != NULL && ![[login objectForKey:@"Login"] isEqualToString:@""] &&
        [login objectForKey:@"Senha"] != NULL && ![[login objectForKey:@"Senha"] isEqualToString:@""])
        [btnConfirm setEnabled:YES];
    else
        [btnConfirm setEnabled:NO];
}

#pragma mark - Textfield BEGIN
- (BOOL)textFieldShouldBeginEditing:(UITextView *)textView
{
    if ([textView.accessibilityValue isEqualToString:@"Login"])
        if ([textView.text isEqualToString:@"Login"])
            textView.text = @"";
    if ([textView.accessibilityValue isEqualToString:@"Senha"])
        if ([textView.text isEqualToString:@"Senha"])
            textView.text = @"";
    
    
    [self setInfoTextView:txtViewSelected];
    txtViewSelected = (UITextField *)textView;
    [AppFunctions TEXT_SCREEN_UP:self
                         textView:textView
                           frame:frame];
    return YES;
}

#pragma mark - Textfield FINISH
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""])
    {
        if ([textField.accessibilityValue isEqualToString:@"Login"])
            textField.text = @"Login";
        else
            textField.text = @"Senha";
    }
    
    if ([login objectForKey:@"Login"] != NULL && ![[login objectForKey:@"Login"] isEqualToString:@""] &&
        [login objectForKey:@"Senha"] != NULL && ![[login objectForKey:@"Senha"] isEqualToString:@""])
        [btnConfirm setEnabled:YES];
    else
        [btnConfirm setEnabled:NO];
    
    [self setInfoTextView:txtViewSelected];
    [AppFunctions TEXT_SCREEN_DOWN:self textField:textField frame:frame];
    return YES;
}

#pragma mark - TextBoxField end edit
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    [self setInfoTextView:txtViewSelected];
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound )
        return YES;
    
    [textView resignFirstResponder];
    return NO;
}

#pragma mark - Textfield open
-(BOOL)textViewDidBeginEditing:(UITextView *)textView
{
    [self setInfoTextView:txtViewSelected];
    txtViewSelected = (UITextField *)textView;
    return YES;
    
}

#pragma mark - Textfield close
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self setInfoTextView:txtViewSelected];
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - textViewFunction Switch fild
- (void)setInfoTextView:(UITextField *)textField
{
    if (textField != NULL)
        [login setObject:textField.text
                  forKey:textField.accessibilityValue];
}

- (IBAction)btnConfirm:(id)sender
{
    [self connection];
}

- (NSMutableDictionary *)getSellerInfo
{
    return agenteInfo;
}

#pragma mark - Configurações de Web Service
- (void)connection
{
    NSString *link;
    NSString *wsComplement;
    wsComplement = [NSString stringWithFormat:WS_URL_SELLER_CODE, KEY_CODE_SITE, KEY_CODE_AGENCY, KEY_EMPTY,
                    KEY_ACCESS_KEY, txtLogin.text, KEY_EMPTY, KEY_TYPE_RETURN];
    
    link = [NSString stringWithFormat:WS_URL, WS_URL_SELLER, wsComplement];
    
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : CODE_POTA_LABEL_CONNECTION_START,
                                       APP_CONNECTION_TAG_WAIT 	 : CODE_POTA_LABEL_CONNECTION_WAIT,
                                       APP_CONNECTION_TAG_RECIVE : CODE_POTA_LABEL_CONNECTION_RECIVE,
                                       APP_CONNECTION_TAG_FINISH : CODE_POTA_LABEL_CONNECTION_FINISH,
                                       APP_CONNECTION_TAG_ERROR  : CODE_POTA_LABEL_CONNECTION_ERROR };
    
    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:labelConnections showView:YES block:^(NSData *result) {
        if (result == nil)
            [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                              message:ERROR_1000_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
        else {
            NSDictionary *erro = [AzParser xmlDictionary:result tagNode:TAG_ERRO];
            BOOL          error = NO;
            for (NSDictionary *tmp in [erro objectForKey:TAG_ERRO])
                if ([tmp objectForKey:TAG_ERRO]) {
                    error = YES;
                    NSLog(@"%@",[tmp objectForKey:TAG_ERRO]);
                }
            if (error)
                [AppFunctions LOG_MESSAGE:ERROR_1001_TITLE
                                  message:ERROR_1001_MESSAGE
                                   cancel:ERROR_BUTTON_CANCEL];
            else {
                NSDictionary *allInfo = [AzParser xmlDictionary:result tagNode:TAG_SELLER];
                for (NSDictionary *tmp in [allInfo objectForKey:TAG_SELLER])
                    agenteInfo = [tmp mutableCopy];
                
                NSDictionary *idsWs   = [AzParser xmlDictionary:result tagNode:@"idWsPorSite"];
                for (NSDictionary *tmp in [idsWs objectForKey:@"idWsPorSite"]) {
                    if ([[tmp objectForKey:@"codigoSite"]isEqualToString:@"1"])
                        [agenteInfo setObject:[tmp objectForKey:@"idWsSite"] forKey:@"idWS"];
                    else
                        [agenteInfo setObject:[tmp objectForKey:@"idWsSite"] forKey:@"idWsSite"];
                }
                [AppFunctions GO_TO_SCREEN:self destiny:STORY_BOARD_LOGIN_PERFIL_AGENTE];
            }
        }
    }];
}

@end
