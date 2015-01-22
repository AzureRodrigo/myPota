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

- (void)configScreen
{
    tableFrame = tableViewData.frame;
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    
    
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PERFIL
                                     title:@""
                                superTitle:@""
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_BACK
                                buttonBack:@selector(backScreen:)
                             openSplitMenu:nil
                                backButton:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)configTextView
{
    containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, 320, 40)];
    
    textView                    = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 3, 240, 40)];
    textView.isScrollable       = NO;
    textView.contentInset       = UIEdgeInsetsMake(0, 5, 0, 5);
    textView.minNumberOfLines   = 1;
    textView.maxNumberOfLines   = 6;
    textView.font               = [UIFont fontWithName:FONT_NAME_BOLD size:12.0];
    textView.delegate           = self;
    textView.backgroundColor    = [UIColor whiteColor];
    textView.placeholder        = @"Digite sua menssagem";
    textView.returnKeyType      = UIReturnKeyDefault;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    
    [self.view addSubview:containerView];
    
    UIImage *entryBackground        = [[UIImage imageNamed:@"MessageEntryInputField.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *entryImageView     = [[UIImageView alloc] initWithImage:entryBackground];
    entryImageView.frame            = CGRectMake(5, 0, 248, 40);
    entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UIImage *background             = [[UIImage imageNamed:@"MessageEntryBackground.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *imageView          = [[UIImageView alloc] initWithImage:background];
    imageView.frame                 = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
    imageView.autoresizingMask      = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    textView.autoresizingMask       = UIViewAutoresizingFlexibleWidth;
    
    [containerView addSubview:imageView];
    [containerView addSubview:textView];
    [containerView addSubview:entryImageView];
    
    doneBtn                  = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame            = CGRectMake(containerView.frame.size.width - 69, 8, 63, 27);
    doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    doneBtn.titleLabel.font  = [UIFont fontWithName:FONT_NAME_BOLD size:12.0];
    [doneBtn setTitle:@"Enviar" forState:UIControlStateNormal];
    [doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
    doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(resignTextView) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setBackgroundImage:[[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0] forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:[[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0] forState:UIControlStateSelected];
    
    [containerView addSubview:doneBtn];
    
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    textView.text = [backScreen getMessage];
    [self configTableView];
}

- (void)configTableView
{
    [tableViewData setFrame:CGRectMake(tableViewData.frame.origin.x, tableViewData.frame.origin.y,
                                       tableViewData.frame.size.width,
                                       tableFrame.size.height - textView.frame.size.height - 5)];
    [tableViewData reloadData];
}

- (IBAction)backScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -configScreen
- (void)viewWillAppear:(BOOL)animated
{
    [self configScreen];
    [self configTextView];
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)configData
{
    backScreen = (b10_User_Messages *)[AppFunctions BACK_SCREEN:self number:1];
}

#pragma mark - configData
- (void)viewDidLoad
{
    [self configData];
    [super viewDidLoad];
}

#pragma mark - keyboard controll
-(void)keyboardWillShow:(NSNotification *)note
{
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    containerView.frame = containerFrame;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)note
{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    containerView.frame = containerFrame;
    [UIView commitAnimations];
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    CGRect r = containerView.frame;
    r.size.height -= diff;
    r.origin.y    += diff;
    containerView.frame = r;
}

- (void)resignTextView
{
    [self sendMessage];
}

#pragma mark - tableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listMessages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    b10_Cell_Message *cell = [tableView dequeueReusableCellWithIdentifier:@"messageModel" forIndexPath:indexPath];
//    
//    [cell.lblText setText:[messageList objectAtIndex:[indexPath row]]];
//    [cell.lblText setAdjustsFontSizeToFitWidth:YES];
//    [cell setBackgroundColor:[UIColor clearColor]];
    
    return nil;
}

#pragma mark - Send Message
- (void)sendMessage
{
    textView.text = @"";
    [self configTableView];
    [textView resignFirstResponder];
    //    link = [NSString stringWithFormat:WS_URL_CHAT_SEND_MESSAGE_INFO,
    //            codSeller, codUser, CHAT_TYPE_USER, message];
    //    link = [NSString stringWithFormat:WS_URL, WS_URL_CHAT_SEND_MESSAGE, link];
    //
    //
    //    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : @"Estamos enviando sua menssagem.",
    //                                       APP_CONNECTION_TAG_WAIT 	 : @"Estamos enviando sua menssagem..",
    //                                       APP_CONNECTION_TAG_RECIVE : @"Estamos enviando sua menssagem...",
    //                                       APP_CONNECTION_TAG_FINISH : @"Menssagem Enviada com Sucesso!",
    //                                       APP_CONNECTION_TAG_ERROR  : @"Ops..." };
    //
    //    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:labelConnections showView:YES block:^(NSData *result) {
    //        if (result == nil)
    //            [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
    //                              message:@"Não conseguimos enviar sua menssagem."
    //                               cancel:ERROR_BUTTON_CANCEL];
    //        else {
    //            NSDictionary *allInfo = [AzParser xmlDictionary:result tagNode:@"retorno"];
    //            for (NSDictionary *tmp in [allInfo objectForKey:@"retorno"])
    //                if([[tmp objectForKey:@"retorno"] isEqualToString:@"ok"])
    //                {
    //                    [menssageBox setText:@"Digite uma mensagem..."];
    //                    [[NSNotificationCenter defaultCenter] postNotificationName:@"PushNotificationMessageReceivedNotification" object:self];
    ////                    [[NSNotificationCenter defaultCenter] addObserver:self
    ////                                                             selector:@selector(remoteNotificationReceived:) name:@"PushNotificationMessageReceivedNotification"
    ////                                                               object:nil];
    //                }else
    //                    NSLog(@"Não Enviado!");
    //        }
    //    }];
}

@end
