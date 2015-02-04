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
    thisScreen = YES;
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
    textView.font               = [UIFont fontWithName:FONT_NAME size:18];
    textView.delegate           = self;
    textView.backgroundColor    = [UIColor whiteColor];
    textView.placeholder        = @"Digite sua mensagem";
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
    [doneBtn setBackgroundImage:[[UIImage imageNamed:@"btnGeneric.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0] forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:[[UIImage imageNamed:@"btnGeneric.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0] forState:UIControlStateSelected];
    
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
    thisScreen = NO;
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
    frame = self.view.frame;
    [super viewDidAppear:animated];
}

- (void)configData
{
    //vazio tudo
    //0 sem ler
    //1 lidas
    
    backScreen   = [AppFunctions BACK_SCREEN:self number:1];
    dataSeller   = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_SELLER];
    dataUser     = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_PERFIL];
    myType       = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_TYPE];
    mycode       = [backScreen getClientCode];
    lblName.text = [backScreen getClientName];
    
    [self reciveMessage:@"" animate:NO alert:YES];
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
    CGRect containerFrame = frame;
    containerFrame.origin.y -= (keyboardBounds.size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    self.view.frame = containerFrame;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)note
{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    CGRect containerFrame = frame;
    containerFrame.origin.y = frame.origin.y;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    self.view.frame = containerFrame;
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

#pragma mark - tableview controll
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listMessages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    b3_User_Chat_Cell *cell = [[b3_User_Chat_Cell alloc] initMessagingCellWithReuseIdentifier:@"messagingCell"];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize messageSize = [b3_User_Chat_Cell messageSize:[[listMessages objectAtIndex:indexPath.row] objectForKey:@"msg"]];
    return messageSize.height + 2 * [b3_User_Chat_Cell textMarginVertical] + 40.0f;
}

- (void)configureCell:(b3_User_Chat_Cell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[myType objectForKey:TAG_USER_TYPE_BOOL] boolValue]) {
        if ([[[listMessages objectAtIndex:indexPath.row] objectForKey:@"sender"] isEqualToString:CHAT_TYPE_SELLER]) {
            cell.sent = YES;
        } else {
            cell.sent = NO;
        }
    } else {
        if ([[[listMessages objectAtIndex:indexPath.row] objectForKey:@"sender"] isEqualToString:CHAT_TYPE_USER]) {
            cell.sent = YES;
        } else {
            cell.sent = NO;
        }
    }
    cell.messageLabel.text = [[listMessages objectAtIndex:indexPath.row] objectForKey:@"msg"];
    cell.timeLabel.text    = [[listMessages objectAtIndex:indexPath.row] objectForKey:@"timer"];
}

- (void)scrollDown:(BOOL)type
{
    if (tableViewData.contentSize.height > tableViewData.frame.size.height)
    {
        CGPoint offset = CGPointMake( 0, tableViewData.contentSize.height - tableViewData.frame.size.height);
        [tableViewData setContentOffset:offset animated:type];
    }
}

#pragma mark - Recive Menssage
- (void)reciveMessage:(NSString *)type animate:(BOOL)roll alert:(BOOL)alert
{
    link = [NSString stringWithFormat:WS_URL_CHAT_RECIVE_MESSAGE_INFO,
            [dataSeller objectForKey:TAG_USER_SELLER_CODE], mycode, type];
    link = [NSString stringWithFormat:WS_URL, WS_URL_CHAT_RECIVE_MESSAGE, link];
    
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : @"Carregando Menssagens!",
                                       APP_CONNECTION_TAG_WAIT 	 : @"Carregando Menssagens!",
                                       APP_CONNECTION_TAG_RECIVE : @"Carregando Menssagens!",
                                       APP_CONNECTION_TAG_FINISH : @"Menssagens Carregadas!",
                                       APP_CONNECTION_TAG_ERROR  : @"Não foi possivel carregar suas menssagens"};
    
    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:labelConnections showView:alert block:^(NSData *result) {
        if (result == nil)
            [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                              message:@"Não conseguimos carregar suas menssagens."
                               cancel:ERROR_BUTTON_CANCEL];
        else {
            if ([type isEqualToString:@""])
            {
                listMessages = [NSMutableArray new];
                NSDictionary *allInfo = [AzParser xmlDictionary:result tagNode:@"chat"];
                for (NSDictionary *tmp in [allInfo objectForKey:@"chat"])
                {
                    [listMessages addObject:@{ @"msg"    : [tmp objectForKey:@"descricaoMensagem"],
                                               @"sender" : [tmp objectForKey:@"tipoMensagem"],
                                               @"timer"  : [tmp objectForKey:@"dataHoraFormatada"] }];
                }
                [tableViewData reloadData];
                [self scrollDown:roll];
                [self performSelector:@selector(updateMessage) withObject:nil afterDelay:1.0];
                
            }
            else if ([type isEqualToString:@"0"])
            {
                NSDictionary *allInfo = [AzParser xmlDictionary:result tagNode:@"chat"];
                int count = [listMessages count];
                for (NSDictionary *tmp in [allInfo objectForKey:@"chat"])
                {
                    if (![[myType objectForKey:TAG_USER_TYPE_BOOL] boolValue])
                    {
                        if ([[tmp objectForKey:@"tipoMensagem"] isEqualToString:CHAT_TYPE_SELLER])
                            [listMessages addObject:@{ @"msg"    : [tmp objectForKey:@"descricaoMensagem"],
                                                       @"sender" : [tmp objectForKey:@"tipoMensagem"],
                                                       @"timer"  : [tmp objectForKey:@"dataHoraFormatada"] }];
                    } else {
                        if ([[tmp objectForKey:@"tipoMensagem"] isEqualToString:CHAT_TYPE_USER])
                            [listMessages addObject:@{ @"msg"    : [tmp objectForKey:@"descricaoMensagem"],
                                                       @"sender" : [tmp objectForKey:@"tipoMensagem"],
                                                       @"timer"  : [tmp objectForKey:@"dataHoraFormatada"] }];
                    }
                }
                [tableViewData reloadData];
                if ([listMessages count] > count)
                    [self scrollDown:roll];
            }
            
        }
    }];
}

#pragma mark - Send Message
- (void)sendMessage
{
    if ([textView.text length] > 0)
    {
        NSString *message = textView.text;
        textView.text = @"";
        
        if (![[myType objectForKey:TAG_USER_TYPE_BOOL] boolValue])
        {
            link = [NSString stringWithFormat:WS_URL_CHAT_SEND_MESSAGE_INFO,
                    [dataSeller objectForKey:TAG_USER_SELLER_CODE], mycode, CHAT_TYPE_USER, message];
        } else if([[myType objectForKey:TAG_USER_TYPE_BOOL] boolValue]) {
            link = [NSString stringWithFormat:WS_URL_CHAT_SEND_MESSAGE_INFO,
                    [dataSeller objectForKey:TAG_USER_SELLER_CODE], mycode, CHAT_TYPE_SELLER, message];
        }
        link = [NSString stringWithFormat:WS_URL, WS_URL_CHAT_SEND_MESSAGE, link];
        
        NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : @"Carregando Menssagens!",
                                           APP_CONNECTION_TAG_WAIT 	 : @"Carregando Menssagens!",
                                           APP_CONNECTION_TAG_RECIVE : @"Carregando Menssagens!",
                                           APP_CONNECTION_TAG_FINISH : @"Menssagens Carregadas!",
                                           APP_CONNECTION_TAG_ERROR  : @"Não foi possivel carregar suas menssagens"};
        
        [appConnection START_CONNECT:link timeForOu:15.f labelConnection:labelConnections showView:NO block:^(NSData *result) {
            if (result == nil)
                [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                                  message:@"Não conseguimos carregar suas menssagens."
                                   cancel:ERROR_BUTTON_CANCEL];
            else {
                BOOL sending = NO;
                NSDictionary *allInfo = [AzParser xmlDictionary:result tagNode:@"retorno"];
                for (NSDictionary *tmp in [allInfo objectForKey:@"retorno"])
                {
                    if ([[tmp objectForKey:@"retorno"] isEqualToString:@"ok"])
                    {
                        sending = YES;
                        break;
                    }
                }
                
                if (sending)
                {
                    NSDate *today = [NSDate date];
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm:ss"];
                    NSString *currentTime = [dateFormatter stringFromDate:today];
                    
                    if ([[myType objectForKey:TAG_USER_TYPE_BOOL] boolValue])
                    {
                        [listMessages addObject:@{ @"msg"    : message,
                                                   @"sender" : CHAT_TYPE_SELLER,
                                                   @"timer"  : currentTime }];
                    } else {
                        [listMessages addObject:@{ @"msg"    : message,
                                                   @"sender" : CHAT_TYPE_USER,
                                                   @"timer"  : currentTime }];
                    }
                    [textView resignFirstResponder];
                    [tableViewData reloadData];
                    [self scrollDown:YES];
                }
            }
        }];
        
    }
}

- (void)updateMessage
{
    if(thisScreen)
    {
        [self performSelector:@selector(updateMessage) withObject:nil afterDelay:5.0];
        [self reciveMessage:@"0" animate:YES alert:NO];
    }
}

@end
