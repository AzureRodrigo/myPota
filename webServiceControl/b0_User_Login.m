//
//  b0_User_Login.m
//  myPota
//
//  Created by Rodrigo Pimentel on 18/09/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "b0_User_Login.h"

@implementation b0_User_Login

#pragma mark - configScreen
- (void)configScreen
{
    [txtMail     setAccessibilityValue:@"E-Mail"];
    [txtPassword setAccessibilityValue:@"Senha"];
    [AppFunctions TEXT_FIELD_CONFIG:txtMail     rect:CGRectMake(0,0,10,0)];
    [AppFunctions TEXT_FIELD_CONFIG:txtPassword rect:CGRectMake(0,0,10,0)];
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
    
    [AppFunctions KEYBOARD_ADD_BAR:@[txtMail, txtPassword]
                          delegate:self
                            change:@selector(textFieldDidChange:)
                              done:@selector(keyboardDone:)
                            cancel:@selector(keyboardClear:)];
    
    txtMail.tintColor     = [UIColor colorWithRed:255 green:191 blue:191 alpha:255];
    txtPassword.tintColor = [UIColor colorWithRed:255 green:191 blue:191 alpha:255];
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
    if ([txtSelect.text isEqualToString:@""])
    {
        if ([txtSelect.accessibilityValue isEqualToString:@"E-Mail"])
            txtSelect.text = @"E-Mail";
        else {
            txtSelect.text = @"Senha";
            txtSelect.secureTextEntry = NO;
        }
    } else
        if ([txtSelect.accessibilityValue isEqualToString:@"Senha"])
            txtSelect.secureTextEntry = YES;
    
    [txtSelect resignFirstResponder];
    
    [self setLogin:txtSelect];
    [AppFunctions TEXT_SCREEN_DOWN:self textField:txtSelect frame:frame];
}

#pragma mark - Textfield Functions
- (void)textFieldDidChange :(UITextField *)textField
{
    [self setLogin:textField];
}

- (BOOL)textFieldShouldBeginEditing:(UITextView *)textView
{
    if ([txtSelect.text isEqualToString:@""])
    {
        if ([txtSelect.accessibilityValue isEqualToString:@"E-Mail"])
            txtSelect.text = @"E-Mail";
        else {
            txtSelect.text = @"Senha";
            txtSelect.secureTextEntry = NO;
        }
    } else
        if ([txtSelect.accessibilityValue isEqualToString:@"Senha"])
            txtSelect.secureTextEntry = YES;
    
    if ([textView.accessibilityValue isEqualToString:@"Senha"])
    {
        if ([textView.text isEqualToString:@""])
            textView.secureTextEntry = NO;
        else
            textView.secureTextEntry = YES;
    }
    
    if ([textView.accessibilityValue isEqualToString:@"E-Mail"])
        if ([textView.text isEqualToString:@"E-Mail"])
            textView.text = @"";
    if ([textView.accessibilityValue isEqualToString:@"Senha"])
        if ([textView.text isEqualToString:@"Senha"])
            textView.text = @"";
    
    txtSelect = (UITextField *)textView;
    
    [AppFunctions TEXT_SCREEN_UP:self textView:textView frame:frame];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""])
    {
        if ([textField.accessibilityValue isEqualToString:@"E-Mail"])
            textField.text = @"E-Mail";
        else {
            textField.text = @"Senha";
            txtSelect.secureTextEntry = NO;
        }
    } else
        if ([txtSelect.accessibilityValue isEqualToString:@"Senha"])
            txtSelect.secureTextEntry = YES;
    
    [self setLogin:textField];
    
    [txtSelect resignFirstResponder];
    [AppFunctions TEXT_SCREEN_DOWN:self textField:textField frame:frame];
    return NO;
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
    if ([login objectForKey:@"E-Mail"] != NULL && ![[login objectForKey:@"E-Mail"] isEqualToString:@""] && ![[login objectForKey:@"E-Mail"] isEqualToString:@"E-Mail"] &&
        [login objectForKey:@"Senha"]  != NULL && ![[login objectForKey:@"Senha"]  isEqualToString:@""])
        [btnOtlConfigApp setEnabled:YES];
    else
        [btnOtlConfigApp setEnabled:NO];
}

#pragma mark - Configurações de Web Service
- (void)login_stepI
{
    NSString *link;
    NSString *wsComplement = [NSString stringWithFormat:WS_b0_CADASTRE_USER,
                              txtMail.text,txtPassword.text,
                              @"",@"",TAG_BASE_WS_LOGIN,@"",@"",@"",@"",TAG_BASE_WS_ACESS_KEY,TAG_BASE_WS_TYPE_RETURN,TAG_BASE_WS_TYPE_ACESS];
    link = [NSString stringWithFormat:WS_URL, WS_b0_CADASTRE, wsComplement];
    
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
            NSDictionary *info = [AzParser xmlDictionary:result tagNode:TAG_B0_USER_PERFIL_OPEN];
            for (NSDictionary *tmp in [info objectForKey:TAG_B0_USER_PERFIL_OPEN])
            {
                fetch = nil;
                fetch = [AppFunctions DATA_BASE_ENTITY_GET:fetch
                                                  delegate:self
                                                    entity:TAG_USER_PERFIL
                                                      sort:TAG_USER_PERFIL_NAME];
                
                NSManagedObject *dataBD = [AppFunctions DATA_BASE_ENTITY_ADD:fetch];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_COD]           forKey:TAG_USER_PERFIL_CODE];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_COD_MD5]       forKey:TAG_USER_PERFIL_CODE_MD5];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_NAME]          forKey:TAG_USER_PERFIL_NAME];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_CPF]           forKey:TAG_USER_PERFIL_CPF];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_TYPE_PERSON]   forKey:TAG_USER_PERFIL_TYPE_PERSON];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_ADRESS]        forKey:TAG_USER_PERFIL_ADRESS];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_QUARTER]       forKey:TAG_USER_PERFIL_QUARTER];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_CEP]           forKey:TAG_USER_PERFIL_CEP];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_DDD]           forKey:TAG_USER_PERFIL_DDD];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_FONE]          forKey:TAG_USER_PERFIL_FONE];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_MAIL]          forKey:TAG_USER_PERFIL_MAIL];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_ADRESS_NUMBER] forKey:TAG_USER_PERFIL_ADRESS_NUMBER];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_COMPLEMENT]    forKey:TAG_USER_PERFIL_COMPLEMENT];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_DDD_CEL]       forKey:TAG_USER_PERFIL_DDD_CELL];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_CEL]           forKey:TAG_USER_PERFIL_CELL];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_BIRTH]         forKey:TAG_USER_PERFIL_BIRTH];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_COD_CITY]      forKey:TAG_USER_PERFIL_CODE_CITY];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_NAME_CITY]     forKey:TAG_USER_PERFIL_NAME_CITY];
                [dataBD setValue:[AppFunctions GET_TOKEN_DEVICE]                     forKey:TAG_USER_PERFIL_CODE_TOKEN];
            }
            [self login_stepII];
        }
    }];
}

- (void)login_stepII
{
    NSString *link;
    user = [[AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_PERFIL] mutableCopy];
    NSString *wsComplement = [NSString stringWithFormat:WS_b0_c0_REGISTER_FONE,
                              [user objectForKey:TAG_USER_PERFIL_CODE_MD5],
                              [user objectForKey:TAG_USER_PERFIL_CODE_TOKEN],
                              TAG_BASE_WS_INCLUDE,TAG_BASE_WS_ACESS_KEY, TAG_BASE_WS_TYPE_RETURN];
    
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
            NSDictionary *info = [AzParser xmlDictionary:result tagNode:TAG_BASE_WS_REGISTER];
            for (NSDictionary *tmp in [info objectForKey:TAG_BASE_WS_REGISTER])
                if ([[tmp objectForKey:TAG_BASE_WS_REGISTER] isEqualToString:@""])
                    [self saveData];
                else
                    [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                                      message:[tmp objectForKey:TAG_BASE_WS_REGISTER]
                                       cancel:ERROR_BUTTON_CANCEL];
        }
    }];
}

- (void)saveData
{
    if ([AppFunctions DATA_BASE_ENTITY_SAVE:fetch])
    {
        if ([self registerTypeUser:NO])
            [self nextScreen];
    } else
        [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                          message:ERROR_1000_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
}

- (BOOL)registerTypeUser:(BOOL)type
{
    fetch = nil;
    fetch = [AppFunctions DATA_BASE_ENTITY_GET:fetch
                                      delegate:self
                                        entity:TAG_USER_TYPE
                                          sort:TAG_USER_TYPE_BOOL];
    
    NSManagedObject *dataBD = [AppFunctions DATA_BASE_ENTITY_ADD:fetch];
    [dataBD setValue:[NSNumber numberWithBool:NO] forKey:TAG_USER_TYPE_BOOL];
    
    if ([AppFunctions DATA_BASE_ENTITY_SAVE:fetch])
    {
        return YES;
    } else
        [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                          message:ERROR_1000_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
    return NO;
}

- (void)nextScreen
{
    [AppFunctions GO_TO_SCREEN:self destiny:SEGUE_B0_TO_B1];
}

@end
