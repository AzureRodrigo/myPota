//
//  b0_User_Login.m
//  myPota
//
//  Created by Rodrigo Pimentel on 18/09/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "b0_User_Login.h"

@implementation b0_User_Login

#pragma mark - readPlist
- (NSString *)dataFilePath:(NSString *)path
{
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:path];
}

#pragma mark - configScreen
- (void)configScreen
{
    appDelegate  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [txtMail     setAccessibilityValue:@"E-Mail"];
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
    
    [AppFunctions KEYBOARD_ADD_BAR:@[txtMail, txtPassword]
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
    if ([textView.accessibilityValue isEqualToString:@"E-Mail"])
        if ([textView.text isEqualToString:@"E-Mail"])
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
        if ([textField.accessibilityValue isEqualToString:@"E-Mail"])
            textField.text = @"E-Mail";
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
    if ([login objectForKey:@"E-Mail"] != NULL && ![[login objectForKey:@"E-Mail"] isEqualToString:@""] && ![[login objectForKey:@"E-Mail"] isEqualToString:@"E-Mail"] &&
        [login objectForKey:@"Senha"]  != NULL && ![[login objectForKey:@"Senha"]  isEqualToString:@""])
        [btnOtlConfigApp setEnabled:YES];
    else
        [btnOtlConfigApp setEnabled:NO];
}

- (void)login_stepI
{
    user = [NSMutableDictionary new];
    
    NSString *link;
    NSString *wsComplement = [NSString stringWithFormat:WS_b0_CADASTRE_USER,
                              txtMail.text,txtPassword.text,
                              @"",@"",@"C",@"",@"",@"",@"",@"appMobile",@"XML",@"M"];
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
            NSDictionary *info = [AzParser xmlDictionary:result tagNode:TAG_B0_CADASTRE_OPEN];
            for (NSDictionary *tmp in [info objectForKey:TAG_B0_CADASTRE_OPEN])
            {
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_COD]           forKey:TAG_B0_CADASTRE_COD];
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_COD_MD5]       forKey:TAG_B0_CADASTRE_COD_MD5];
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_NAME]          forKey:TAG_B0_CADASTRE_NAME];
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_CPF]           forKey:TAG_B0_CADASTRE_CPF];
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_TYPE_PERSON]   forKey:TAG_B0_CADASTRE_TYPE_PERSON];
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_ADRESS]        forKey:TAG_B0_CADASTRE_ADRESS];
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_QUARTER]       forKey:TAG_B0_CADASTRE_QUARTER];
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_CEP]           forKey:TAG_B0_CADASTRE_CEP];
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_DDD]           forKey:TAG_B0_CADASTRE_DDD];
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_FONE]          forKey:TAG_B0_CADASTRE_FONE];
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_MAIL]          forKey:TAG_B0_CADASTRE_MAIL];
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_ADRESS_NUMBER] forKey:TAG_B0_CADASTRE_ADRESS_NUMBER];
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_COMPLEMENT]    forKey:TAG_B0_CADASTRE_COMPLEMENT];
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_DDD_CEL]       forKey:TAG_B0_CADASTRE_DDD_CEL];
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_CEL]           forKey:TAG_B0_CADASTRE_CEL];
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_BIRTH]         forKey:TAG_B0_CADASTRE_BIRTH];
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_COD_CITY]      forKey:TAG_B0_CADASTRE_COD_CITY];
                [user setObject:[tmp objectForKey:TAG_B0_CADASTRE_NAME_CITY]     forKey:TAG_B0_CADASTRE_NAME_CITY];
                [user setObject:appDelegate.tokenPhone                           forKey:TAG_B0_C0_REGISTER_COD_TOKEN];
            }
            
            [self login_stepII];
        }
    }];
}

- (void)login_stepII
{
    NSString *link;
    NSString *wsComplement = [NSString stringWithFormat:WS_b0_c0_REGISTER_FONE,
                              [user objectForKey:TAG_B0_CADASTRE_COD_MD5],
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
    
}

- (void)nextScreen
{
    
}

@end
