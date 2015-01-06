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
    [self connection];
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

- (void)connection
{
    NSString *link;
    NSString *wsComplement;
    
    link = [NSString stringWithFormat:WS_URL, WS_URL_CADASTRO, wsComplement];
    
//    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : CODE_POTA_LABEL_CONNECTION_START,
//                                       APP_CONNECTION_TAG_WAIT   : CODE_POTA_LABEL_CONNECTION_WAIT,
//                                       APP_CONNECTION_TAG_RECIVE : CODE_POTA_LABEL_CONNECTION_RECIVE,
//                                       APP_CONNECTION_TAG_FINISH : CODE_POTA_LABEL_CONNECTION_FINISH,
//                                       APP_CONNECTION_TAG_ERROR  : CODE_POTA_LABEL_CONNECTION_ERROR };
//    
//    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:labelConnections showView:YES block:^(NSData *result) {
//        if (result == nil) {
//            [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
//                              message:ERROR_1000_MESSAGE
//                               cancel:ERROR_BUTTON_CANCEL];
//        } else {
//            
//            NSDictionary *allInfo = [AzParser xmlDictionary:result tagNode:@"consumidor"];
//            for (NSDictionary *tmp in [allInfo objectForKey:@"consumidor"])
//            {
////                code = [tmp objectForKey:@"CodConsumidor"];
//                break;
//            }
//
//            [self saveData];
//        }
//    }];
}

- (void)saveData
{
}

- (void)nextScreen
{
}

@end
