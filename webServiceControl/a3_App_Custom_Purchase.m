//
//  a3_App_Custom_Purchase.m
//  mypota
//
//  Created by Rodrigo Pimentel on 27/02/15.
//  Copyright (c) 2015 web. All rights reserved.
//

#import "a3_App_Custom_Purchase.h"

@implementation a3_App_Custom_Purchase

#pragma mark -Config NavBar
- (void)configNavBar
{
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:@"Orçamento Personalizado"
                                                               attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                            NSFontAttributeName: [UIFont fontWithName:FONT_NAME_BOLD size:18]}];
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_GENERIC
                                     title:title
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_CLEAR
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:@selector(menuOpen:)
                                backButton:YES];
}

- (IBAction)menuOpen:(id)sender
{
    [AppMenuView openMenu:self
                   sender:sender];
}

- (IBAction)btnBackScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configScreen
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameDidChange:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [AppFunctions ENABLE_SCROLL_VIEW:ScrollView offset:150];
    
    [AppFunctions KEYBOARD_ADD_BAR:@[txtDestiny, txtData, txtTravellers, txtChildrens, txtDetails]
                          delegate:self
                            change:nil
                              done:@selector(keyboardDone:)
                            cancel:@selector(keyboardClear:)];
    txtDestiny.tintColor      = [UIColor colorWithRed:255 green:191 blue:191 alpha:255];
    txtData.tintColor         = [UIColor colorWithRed:255 green:191 blue:191 alpha:255];
    txtTravellers.tintColor   = [UIColor colorWithRed:255 green:191 blue:191 alpha:255];
    txtChildrens.tintColor    = [UIColor colorWithRed:255 green:191 blue:191 alpha:255];
    txtDetails.tintColor      = [UIColor colorWithRed:255 green:191 blue:191 alpha:255];
    
    float round = 10.0f;
    txtDestiny.layer.cornerRadius    = round;
    txtDestiny.clipsToBounds         = YES;
    txtData.layer.cornerRadius       = round;
    txtData.clipsToBounds            = YES;
    txtTravellers.layer.cornerRadius = round;
    txtTravellers.clipsToBounds      = YES;
    txtChildrens.layer.cornerRadius  = round;
    txtChildrens.clipsToBounds       = YES;
    txtDetails.layer.cornerRadius    = round;
    txtDetails.clipsToBounds         = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configScreen];
    [self configNavBar];
    [super viewWillAppear:animated];
}

#pragma mark - TextView Configs
- (void)keyboardFrameDidChange:(NSNotification *)notification
{
    switch (scrollState) {
        case 1:
            scrollState = 2;
            scrollPoint = [AppFunctions SCROLL_TEXT_TO_CENTER_VIEW:notification
                                                         textField:txtViewSelected
                                                            scroll:ScrollView];
            break;
        case 3:
            [ScrollView setContentOffset:scrollPoint animated:YES];
            scrollState = 0;
            break;
        default:
            [AppFunctions SCROLL_TEXT_CHANGE_VIEW:notification
                                        textField:txtViewSelected
                                           scroll:ScrollView];
            break;
    }
}

- (IBAction)keyboardClear:(UIBarButtonItem *)sender
{
    [txtViewSelected setText:@""];
}

- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    [self configBudget];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (txtDestiny.text.length > 0 && txtData.text.length > 0 && txtTravellers.text.length > 0)
        [btnSend setEnabled:YES];
    
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    txtViewSelected = (UITextField *)textView;
    scrollState = 1;
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self configBudget];
}

- (void)configBudget
{
    scrollState = 3;
    [txtViewSelected resignFirstResponder];
}

#pragma mark -Btns Configs
- (IBAction)btnSend:(id)sender
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.delegate  = self;
    HUD.dimBackground = YES;
    
    [HUD show:YES];
    HUD.labelText = @"Enviando E-Mail.";
    
    NSDictionary *seller = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_SELLER];
    NSDictionary *user = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_PERFIL];
    for (NSDictionary *info in [[AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_AGENCY] objectForKey:TAG_USER_AGENCY_LIST_ID_WS])
        if ([[info objectForKey:TAG_USER_AGENCY_CODE_SITE] isEqualToString:@"4"])
            IDWS = [info objectForKey:@"idWsSite"];
    if (IDWS == nil)
        IDWS = KEY_ID_WS_TRAVEL;
    NSString *hotel;
    NSString *travel;
    NSString *fly;
    if (swipperHotel.isOn  == YES) hotel = @"Sim";  else hotel = @"Não";
    if (swipperTravel.isOn == YES) travel = @"Sim"; else travel = @"Não";
    if (swipperFly.isOn    == YES) fly = @"Sim";    else fly = @"Não";
    
    NSString *mail = [NSString stringWithFormat:MAIL_BUDGET_CUSTOM,
                      [user objectForKey:TAG_USER_PERFIL_NAME],
                      [user objectForKey:TAG_USER_PERFIL_NAME],
                      [user objectForKey:TAG_USER_PERFIL_MAIL],
                      txtDestiny.text,
                      txtData.text,
                      txtTravellers.text,
                      txtChildrens.text,
                      hotel,
                      travel,
                      fly,
                      txtDetails.text];
    
    NSString *wsComplement = [NSString stringWithFormat:WS_URL_MAIL_SENDER,
                              IDWS,@"4",
                              [user objectForKey:TAG_USER_PERFIL_MAIL],
                              [seller objectForKey:TAG_USER_SELLER_MAIL],
                              @"MyPota - Solicitação de Orçamento Personalizado",
                              mail,@"",@"" ];
    
    NSString *link = [NSString stringWithFormat:WS_URL, WS_URL_MAIL, wsComplement];
    
    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:nil showView:NO block:^(NSData *result) {
        [HUD hide:YES];
        [self btnBackScreen:nil];
        [AppFunctions LOG_MESSAGE:LOG_TITLE_MAIL_SUCCESS
                          message:[NSString stringWithFormat:LOG_TEXT_MAIL_BUDGET_CUSTOM, [seller objectForKey:TAG_USER_SELLER_MAIL]]
                           cancel:LOG_BUTTON_CANCEL];
    }];
}

@end
