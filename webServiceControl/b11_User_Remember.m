//
//  b11_User_Remember.m
//  mypota
//
//  Created by Rodrigo Pimentel on 28/01/15.
//  Copyright (c) 2015 web. All rights reserved.
//

#import "b11_User_Remember.h"

@interface b11_User_Remember ()

@end

@implementation b11_User_Remember

#pragma mark - configScreen
- (void)configScreen
{
    oltMail.tintColor = [UIColor colorWithRed:255 green:191 blue:191 alpha:255];
    [AppFunctions TEXT_FIELD_CONFIG:oltMail rect:CGRectMake(0,0,10,0)];
    
    [AppFunctions KEYBOARD_ADD_BAR:@[oltMail]
                          delegate:self
                            change:@selector(textFieldDidChange:)
                              done:@selector(keyboardDone:)
                            cancel:@selector(keyboardClear:)];
    
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PERFIL
                                     title:@""
                                superTitle:@""
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_BACK
                                buttonBack:@selector(backScreen:)
                             openSplitMenu:nil
                                backButton:YES];
}


- (IBAction)backScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configScreen];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    frame = self.view.frame;
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - keyboardAction
- (BOOL)textFieldShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqual:@"E-Mail"])
        textView.text = @"";
    keyboardField = (UITextField *)textView;
    [AppFunctions TEXT_SCREEN_UP:self textView:textView frame:frame];
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    [self cadastre:textField down:NO];
}

- (IBAction)keyboardClear:(UIBarButtonItem *)sender
{
    [keyboardField setText:@""];
    [self cadastre:keyboardField down:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self cadastre:textField down:YES];
    return NO;
}

- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    [self cadastre:keyboardField down:YES];
}

- (void)cadastre:(UITextField *)textField down:(BOOL)_down
{
    if (_down) {
        [AppFunctions TEXT_SCREEN_DOWN:self textField:keyboardField frame:frame];
        [textField resignFirstResponder];
        if ([textField.text isEqualToString:@""])
            textField.text = @"E-Mail";
    }
    
    if (![oltMail.text isEqualToString:@""] && [AppFunctions VALID_MAIL:oltMail.text])
        [otlSend setEnabled:YES];
    else
        [otlSend setEnabled:NO];
}

- (IBAction)btnSend:(id)sender
{
    NSString *wsComplement = [NSString stringWithFormat:WS_b0_CADASTRE_USER, oltMail.text, @"",
                              @"", @"", TAG_BASE_WS_REMEMBER, @"", @"", @"", @"",
                              TAG_BASE_WS_ACESS_KEY, TAG_BASE_WS_TYPE_RETURN, TAG_BASE_WS_TYPE_ACESS];
    
    NSString *link         = [NSString stringWithFormat:WS_URL, WS_b0_CADASTRE, wsComplement];
    
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
            {
                [AppFunctions LOG_MESSAGE:@"Aviso!"
                                  message:[tmp objectForKey:TAG_BASE_WS_REGISTER]
                                   cancel:ERROR_BUTTON_CANCEL];
                break;
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
