//
//  b3_User_Chat.m
//  myPota
//
//  Created by Rodrigo Pimentel on 15/12/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "b3_User_Chat.h"


@implementation b3_User_Chat

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"Warning Memory int chat User");
}

- (void)configNavBar
{
    frame = self.view.frame;
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

#pragma mark -configNavBar
- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [super viewWillAppear:animated];
}

- (void)configData
{
    seller    = [AppFunctions PLIST_LOAD:PLIST_SELLER_NAME];
    codSeller = [[seller objectForKey:PURCHASE_INFO_SELLER]objectForKey:SELLER_DATA_CODE];
    codUser   = @"7579";//[[seller objectForKey:PURCHASE_INFO_SELLER]objectForKey:SELLER_DATA_CODE];
}

- (void)configMessageBox
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc]initWithTitle:@"Cancelar"
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:self
                                                                action:@selector(keyboardClear:)];
    
    UIBarButtonItem *btnConfirm = [[UIBarButtonItem alloc]initWithTitle:@"Enviar"
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(keyboardDone:)];
    
    numberToolbar.items = [NSArray arrayWithObjects:
                           btnCancel,
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                        target:nil
                                                                        action:nil],
                           btnConfirm,
                           nil];
    [numberToolbar sizeToFit];
    [menssageBox setInputAccessoryView:numberToolbar];
}

#pragma mark - DidLoad
- (void)viewDidLoad
{
    [self configMessageBox];
    [self configData];
    [super viewDidLoad];
}

#pragma mark - TEXT FIELD FUNCTIONS
- (IBAction)keyboardClear:(UIBarButtonItem *)sender
{
    [menssageBox resignFirstResponder];
}

- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    if ([menssageBox.text length] > 0)
    {
        [menssageBox resignFirstResponder];
        [self sendMessage:menssageBox.text];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextView *)textView
{
    if ([menssageBox.text isEqualToString:@"Digite uma mensagem..."])
        [menssageBox setText:@""];
    [AppFunctions TEXT_SCREEN_UP:self
                        textView:textView
                           frame:frame];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([menssageBox.text isEqualToString:@""])
        [menssageBox setText:@"Digite uma mensagem..."];
    [AppFunctions TEXT_SCREEN_DOWN:self
                         textField:textField
                             frame:frame];
    return YES;
}

#pragma mark - Send Message
- (void)sendMessage:(NSString *)message
{
    link = [NSString stringWithFormat:WS_URL_CHAT_SEND_MESSAGE_INFO,
            codSeller, codUser, CHAT_TYPE_USER, message];
    link = [NSString stringWithFormat:WS_URL, WS_URL_CHAT_SEND_MESSAGE, link];
    
    
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : @"Estamos enviando sua menssagem.",
                                       APP_CONNECTION_TAG_WAIT 	 : @"Estamos enviando sua menssagem..",
                                       APP_CONNECTION_TAG_RECIVE : @"Estamos enviando sua menssagem...",
                                       APP_CONNECTION_TAG_FINISH : @"Menssagem Enviada com Sucesso!",
                                       APP_CONNECTION_TAG_ERROR  : @"Ops..." };
    
    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:labelConnections showView:YES block:^(NSData *result) {
        if (result == nil)
            [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                              message:@"Não conseguimos enviar sua menssagem."
                               cancel:ERROR_BUTTON_CANCEL];
        else {
            NSDictionary *allInfo = [AzParser xmlDictionary:result tagNode:@"retorno"];
            for (NSDictionary *tmp in [allInfo objectForKey:@"retorno"])
                if([[tmp objectForKey:@"retorno"] isEqualToString:@"ok"])
                {
                    [menssageBox setText:@"Digite uma mensagem..."];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"PushNotificationMessageReceivedNotification" object:self];
//                    [[NSNotificationCenter defaultCenter] addObserver:self
//                                                             selector:@selector(remoteNotificationReceived:) name:@"PushNotificationMessageReceivedNotification"
//                                                               object:nil];
                }else
                    NSLog(@"Não Enviado!");
        }
    }];
}

@end
