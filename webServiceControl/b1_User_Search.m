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
    lblCode.tintColor     = [UIColor colorWithRed:255 green:255 blue:255 alpha:255];
    [AppFunctions TEXT_FIELD_CONFIG:lblCode rect:CGRectMake(0,0,10,0)];
    otlBtnSearch.titleLabel.numberOfLines = 3;
    otlBtnInvite.titleLabel.numberOfLines = 3;
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
                for (NSDictionary *tmp in [idsWs objectForKey:@"idWsPorSite"]){
                    [agenteInfoIdWs addObject:tmp];
                }
                [self setSeller];
            }
        }
    }];
}

- (void)setSeller
{
    fetch = [AppFunctions DATA_BASE_ENTITY_GET:fetch
                                      delegate:self
                                        entity:TAG_USER_SELLER
                                          sort:TAG_USER_SELLER_NAME];
    
    NSManagedObject *dataBD = [AppFunctions DATA_BASE_ENTITY_ADD:fetch];
    
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_CITY] 			forKey:TAG_USER_SELLER_CITY];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_CODE] 			forKey:TAG_USER_SELLER_CODE];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_CODE_AGENCY] 	forKey:TAG_USER_SELLER_CODE_AGENCY];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_CODE_CITY] 	forKey:TAG_USER_SELLER_CODE_CITY];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_CODE_SITE] 	forKey:TAG_USER_SELLER_CODE_SITE];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_DDD] 			forKey:TAG_USER_SELLER_DDD];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_DDD_CELL]  	forKey:TAG_USER_SELLER_DDD_CELL];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_MAIL] 			forKey:TAG_USER_SELLER_MAIL];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_FACEBOOK] 		forKey:TAG_USER_SELLER_FACEBOOK];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_FONE]  		forKey:TAG_USER_SELLER_FONE];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_CELL]  		forKey:TAG_USER_SELLER_CELL];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_FOTO]  		forKey:TAG_USER_SELLER_FOTO];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_GTALK] 		forKey:TAG_USER_SELLER_GTALK];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_NAME] 			forKey:TAG_USER_SELLER_NAME];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_UF_NAME] 		forKey:TAG_USER_SELLER_UF_NAME];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_GENDER]  		forKey:TAG_USER_SELLER_GENDER];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_UF] 			forKey:TAG_USER_SELLER_UF];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_SKYPE] 		forKey:TAG_USER_SELLER_SKYPE];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_TWITTER] 		forKey:TAG_USER_SELLER_TWITTER];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_WHATSAPP] 		forKey:TAG_USER_SELLER_WHATSAPP];
    [dataBD setValue:@"" forKey:TAG_USER_SELLER_YOUTUBE];
    
    if ([AppFunctions DATA_BASE_ENTITY_SAVE:fetch])
        [self setAgency];
    else
        [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                          message:ERROR_1000_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
    
}

- (void)setAgency
{
    fetch = nil;
    fetch = [AppFunctions DATA_BASE_ENTITY_GET:fetch
                                      delegate:self
                                        entity:TAG_USER_AGENCY
                                          sort:TAG_USER_AGENCY_NAME];
    NSManagedObject *dataBD = [AppFunctions DATA_BASE_ENTITY_ADD:fetch];
    
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_CELL]            forKey:TAG_USER_AGENCY_CELL];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_CEP]             forKey:TAG_USER_AGENCY_CEP];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_CODE]            forKey:TAG_USER_AGENCY_CODE];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_COMPLEMENT]      forKey:TAG_USER_AGENCY_COMPLEMENT];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_CONTACT]         forKey:TAG_USER_AGENCY_CONTACT];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_QUARTER]         forKey:TAG_USER_AGENCY_QUARTER];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_DDD]             forKey:TAG_USER_AGENCY_DDD];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_DDD_CELL]        forKey:TAG_USER_AGENCY_DDD_CELL];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_MAIL]            forKey:TAG_USER_AGENCY_MAIL];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_ADRESS]          forKey:TAG_USER_AGENCY_ADRESS];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_IDWS]            forKey:TAG_USER_AGENCY_IDWS];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_FONE]            forKey:TAG_USER_AGENCY_FONE];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_LATITUDE]        forKey:TAG_USER_AGENCY_LATITUDE];
    [dataBD setValue:agenteInfoIdWs                                               forKey:TAG_USER_AGENCY_LIST_ID_WS];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_LOGOTYPE]        forKey:TAG_USER_AGENCY_LOGOTYPE];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_LONGITUDE]       forKey:TAG_USER_AGENCY_LONGITUDE];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_NAME]            forKey:TAG_USER_AGENCY_NAME];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_NAME_FANTASY]    forKey:TAG_USER_AGENCY_NAME_FANTASY];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_NUMBER_ADRESS]   forKey:TAG_USER_AGENCY_NUMBER_ADRESS];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_URL]             forKey:TAG_USER_AGENCY_URL];
    
    if ([AppFunctions DATA_BASE_ENTITY_SAVE:fetch])
        [self nextScreen];
    else
        [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                          message:ERROR_1000_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
}

- (void)nextScreen
{
    [AppFunctions GO_TO_SCREEN:self destiny:SEGUE_B1_TO_B2];
}

- (IBAction)btnInvite:(id)sender
{
    [AppFunctions GO_TO_SCREEN:self destiny:STORY_BOARD_CODE_INVITE];
}

- (IBAction)btnLogoff:(id)sender
{
    [AppFunctions APP_LOGOFF:self identifier:STORYBOARD_ID_A1];
}

@end
