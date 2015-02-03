//
//  c0_Agent_Login.m
//  myPota
//
//  Created by Rodrigo Pimentel on 08/09/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "c0_Agent_Login.h"

@implementation c0_Agent_Login

#pragma mark - configScreen
- (void)configScreen
{
    [txtLogin     setAccessibilityValue:@"Login"];
    [txtPassword  setAccessibilityValue:@"Senha"];
    [AppFunctions TEXT_FIELD_CONFIG:txtLogin    rect:CGRectMake(0,0,10,0)];
    [AppFunctions TEXT_FIELD_CONFIG:txtPassword rect:CGRectMake(0,0,10,0)];
    txtLogin.tintColor    = [UIColor colorWithRed:255 green:191 blue:191 alpha:255];
    txtPassword.tintColor = [UIColor colorWithRed:255 green:191 blue:191 alpha:255];
    
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
    
    [AppFunctions KEYBOARD_ADD_BAR:@[txtLogin, txtPassword]
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
        if ([txtSelect.accessibilityValue isEqualToString:@"Login"])
            txtSelect.text = @"Login";
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
    
    if ([textView.accessibilityValue isEqualToString:@"Login"])
        if ([textView.text isEqualToString:@"Login"])
            textView.text = @"";
    if ([textView.accessibilityValue isEqualToString:@"Senha"])
        if ([textView.text isEqualToString:@"Senha"])
            textView.text = @"";
    
    txtSelect = (UITextField *)textView;
    
    [AppFunctions TEXT_SCREEN_UP:self textView:textView frame:frame];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""])
    {
        if ([textField.accessibilityValue isEqualToString:@"Login"])
            textField.text = @"Login";
        else
            textField.text = @"Senha";
    }
    
    [self setLogin:textField];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""])
    {
        if ([textField.accessibilityValue isEqualToString:@"Login"])
            textField.text = @"Login";
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
    if ([login objectForKey:@"Login"] != NULL && ![[login objectForKey:@"Login"] isEqualToString:@""] && ![[login objectForKey:@"Login"] isEqualToString:@"Login"] &&
        [login objectForKey:@"Senha"]  != NULL && ![[login objectForKey:@"Senha"]  isEqualToString:@""])
        [btnOtlConfigApp setEnabled:YES];
    else
        [btnOtlConfigApp setEnabled:NO];
}

#pragma mark - Configurações de Web Service
- (void)login_stepI //get seller Data
{
    user = [NSMutableDictionary new];
    
    NSString *link;
    NSString *wsComplement = [NSString stringWithFormat:WS_c0_CADASTRE_SELLER,
                              TAG_BASE_WS_LOGIN,txtLogin.text,txtPassword.text,
                              TAG_BASE_WS_ACESS_KEY,TAG_BASE_WS_TYPE_RETURN];
    link = [NSString stringWithFormat:WS_URL, WS_c0_CADASTRE, wsComplement];
    
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
            NSDictionary *error = [AzParser xmlDictionary:result tagNode:@"retorno"];
            BOOL logIn = YES;
            for (NSDictionary *tmp in [error objectForKey:@"retorno"]) {
                if ([tmp objectForKey:@"retorno"])
                {
                    [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                                      message:[tmp objectForKey:@"retorno"]
                                       cancel:ERROR_BUTTON_CANCEL];
                    logIn = NO;
                    return;
                }
            }
            if (logIn)
            {
                NSDictionary *info = [AzParser xmlDictionary:result tagNode:TAG_C0_USER_PERFIL_OPEN];
                for (NSDictionary *tmp in [info objectForKey:TAG_C0_USER_PERFIL_OPEN])
                {
                    fetch = nil;
                    fetch = [AppFunctions DATA_BASE_ENTITY_GET:fetch
                                                      delegate:self
                                                        entity:TAG_USER_PERFIL
                                                          sort:TAG_USER_PERFIL_NAME];
                    
                    NSManagedObject *dataBD = [AppFunctions DATA_BASE_ENTITY_ADD:fetch];
                    [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_COD]           forKey:TAG_USER_PERFIL_CODE];
                    [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_COD_MD5]       forKey:TAG_USER_PERFIL_CODE_MD5];
                    [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_NAME]          forKey:TAG_USER_PERFIL_NAME];
                    [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_CPF]           forKey:TAG_USER_PERFIL_CPF];
                    //                [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_TYPE_PERSON]   forKey:TAG_USER_PERFIL_TYPE_PERSON];
                    [dataBD setValue:@"" forKey:TAG_USER_PERFIL_TYPE_PERSON];
                    [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_ADRESS]        forKey:TAG_USER_PERFIL_ADRESS];
                    //                [dataBD setValue:@"" forKey:TAG_USER_PERFIL_ADRESS];
                    [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_QUARTER]       forKey:TAG_USER_PERFIL_QUARTER];
                    [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_CEP]           forKey:TAG_USER_PERFIL_CEP];
                    //                [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_DDD]           forKey:TAG_USER_PERFIL_DDD];
                    [dataBD setValue:@"" forKey:TAG_USER_PERFIL_DDD];
                    [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_FONE]          forKey:TAG_USER_PERFIL_FONE];
                    [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_MAIL]          forKey:TAG_USER_PERFIL_MAIL];
                    //                [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_ADRESS_NUMBER] forKey:TAG_USER_PERFIL_ADRESS_NUMBER];
                    [dataBD setValue:@"" forKey:TAG_USER_PERFIL_ADRESS_NUMBER];
                    //                [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_COMPLEMENT]    forKey:TAG_USER_PERFIL_COMPLEMENT];
                    [dataBD setValue:@"" forKey:TAG_USER_PERFIL_COMPLEMENT];
                    //                [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_DDD_CELL]      forKey:TAG_USER_PERFIL_DDD_CELL];
                    [dataBD setValue:@"" forKey:TAG_USER_PERFIL_DDD_CELL];
                    [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_CELL]          forKey:TAG_USER_PERFIL_CELL];
                    [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_BIRTH]         forKey:TAG_USER_PERFIL_BIRTH];
                    //                [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_COD_CITY]      forKey:TAG_USER_PERFIL_CODE_CITY];
                    [dataBD setValue:@"" forKey:TAG_USER_PERFIL_CODE_CITY];
                    //                [dataBD setValue:[tmp objectForKey:TAG_C0_USER_PERFIL_NAME_CITY]     forKey:TAG_USER_PERFIL_NAME_CITY];
                    [dataBD setValue:@"" forKey:TAG_USER_PERFIL_NAME_CITY];
                    [dataBD setValue:[AppFunctions GET_TOKEN_DEVICE]                     forKey:TAG_USER_PERFIL_CODE_TOKEN];
                }
                [self login_stepII];
            }
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
            [self login_step_III];
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
    [dataBD setValue:[NSNumber numberWithBool:YES] forKey:TAG_USER_TYPE_BOOL];
    
    if ([AppFunctions DATA_BASE_ENTITY_SAVE:fetch])
    {
        return YES;
    } else
        [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                          message:ERROR_1000_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
    return NO;
}

- (void)login_step_III
{
    NSString *link;
    NSString *wsComplement = [NSString stringWithFormat:WS_c0_CADASTRE_SELLER_DETAIL,@"1",TAG_BASE_WS_ACESS_KEY,
                              [user objectForKey:TAG_USER_PERFIL_CODE], TAG_BASE_WS_TYPE_RETURN];
    
    link = [NSString stringWithFormat:WS_URL, WS_c0_CADASTRE_DETAIL, wsComplement];
    
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
    }];
}

- (void)setSeller
{
    fetch = nil;
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
    [AppFunctions GO_TO_SCREEN:self destiny:SEGUE_C0_TO_C1];
}

@end
