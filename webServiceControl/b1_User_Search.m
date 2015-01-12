//
//  codePOTA.m
//  myPota
//
//  Created by Rodrigo Pimentel on 07/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "b1_User_Search.h"

@implementation b1_User_Search

- (void)initComponents
{
    [self->lblCode  setDelegate:self];
    self->listState = [States new];
}

- (void)viewDidLoad
{
    [self initComponents];
    [super viewDidLoad];
}

#pragma mark - keyBoard Notifications
- (void)keyboardWillShowNotification:(NSNotification*)notification
{
    [AppFunctions MOVE_SET_DATA:self notification:notification scrollView:scrollViewData textField:keyboardField goCenter:YES];
}

- (void)keyboardWillHideNotification:(NSNotification*)notification
{
    [AppFunctions MOVE_SET_DATA:self notification:notification scrollView:scrollViewData textField:keyboardField goCenter:NO];
}

#pragma mark -configNavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PERFIL
                                     title:@""
                                superTitle:@""
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_BACK
                                buttonBack:nil
                             openSplitMenu:nil
                                backButton:NO];
    [AppFunctions KEYBOARD_ADD_BAR:@[lblCode]
                          delegate:self
                            change:@selector(textFieldDidChange:)
                              done:@selector(keyboardDone:)
                            cancel:@selector(keyboardClear:)];
}

#pragma mark - Numeric keyboard Clear
- (IBAction)keyboardClear:(UIBarButtonItem *)sender
{
    [keyboardField setText:@""];
    [self->outCodePota setEnabled:NO];
}

#pragma mark - Numeric keyboard Done
- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    [keyboardField resignFirstResponder];
}

#pragma mark - configNavBar and keyboard
- (void)viewWillAppear:(BOOL)animated
{
    [AppFunctions INIT_KEYBOARD_CENTER:self
                              willShow:@selector(keyboardWillShowNotification:)
                              willHide:@selector(keyboardWillHideNotification:)];
    [self configNavBar];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [AppFunctions FINISH_KEYBOARD_CENTER:self];
    [self.navigationController.navigationBar setHidden:NO];
    [super viewWillAppear:animated];
}

#pragma mark - textFieldBeginEdit
-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    keyboardField = sender;
}

#pragma mark - textField
- (IBAction)txtCodePotaChange:(id)sender
{
    if ([self->lblCode.text length] > 0)
        [self->outCodePota setEnabled:YES];
    else
        [self->outCodePota setEnabled:NO];
}

- (void)textFieldDidChange:(UITextField *)theTextField
{
    if ([self->lblCode.text length] > 0)
        [self->outCodePota setEnabled:YES];
    else
        [self->outCodePota setEnabled:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - Buttons
- (IBAction)btnCodePota:(id)sender
{
    [self.view endEditing:YES];
    if ([AppFunctions VALID_NUMBER:self->lblCode.text])
        [self connection:YES];
    else
        [self connection:NO];
}

- (IBAction)btnSearchPota:(id)sender
{
    [self.view endEditing:YES];
    [AppFunctions GO_TO_SCREEN:self destiny:STORY_BOARD_CODE_SEARCH];
}

- (void)connection:(BOOL)CODE
{
    NSString *link;
    NSString *wsComplement;
    if (CODE)
        wsComplement = [NSString stringWithFormat:WS_URL_SELLER_CODE, KEY_CODE_SITE, KEY_CODE_AGENCY, KEY_EMPTY,
                        KEY_ACCESS_KEY, lblCode.text, KEY_EMPTY, KEY_TYPE_RETURN];
    else
        wsComplement = [NSString stringWithFormat:WS_URL_SELLER_CODE, KEY_CODE_SITE, KEY_CODE_AGENCY, KEY_EMPTY,
                        KEY_ACCESS_KEY, KEY_EMPTY, lblCode.text, KEY_TYPE_RETURN];
    
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
                NSDictionary *idsWs = [AzParser xmlDictionary:result tagNode:@"idWsPorSite"];
                agenteInfoIdWs = [NSMutableArray new];
                for (NSDictionary *tmp in [idsWs objectForKey:@"idWsPorSite"]) {
                    [agenteInfoIdWs addObject:tmp];
                }
                [self sellectSeller];
            }
        }
    }];
}

- (void)sellectSeller
{
    NSLog(@"%@\n%@",agenteInfo, agenteInfoIdWs);
//    [AppFunctions GO_TO_SCREEN:self destiny:STORY_BOARD_CODE_PERFIL];
}

- (NSMutableDictionary *)getInfoData
{
    return agenteInfo;
}

- (IBAction)btnInvite:(id)sender
{
    [AppFunctions GO_TO_SCREEN:self destiny:STORY_BOARD_CODE_INVITE];
}

- (IBAction)btnLogoff:(id)sender
{
    [AppFunctions DATA_BASE_ENTITY_REMOVE:TAG_DATA_USER_TRAVELLER];
    [AppFunctions POP_SCREEN:self identifier:STORYBOARD_ID_A1 animated:YES];
}

@end
