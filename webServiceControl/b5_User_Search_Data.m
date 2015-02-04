//
//  searchPOTA.m
//  myPota
//
//  Created by Rodrigo Pimentel on 08/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "b5_User_Search_Data.h"


@implementation b5_User_Search_Data

- (void)initLists
{
    NSString *path          = [[NSBundle mainBundle] pathForResource:PLIST_STATE_NAME ofType:@"plist"];
    pList                   = [[NSMutableDictionary alloc]  initWithContentsOfFile:path];
    self->listEstadosSigla  = [pList objectForKey:PLIST_STATE_TAG_SIGLAS];
    self->listEstadosNomes  = [pList objectForKey:PLIST_STATE_TAG_NAMES];
}

- (void)initVariables
{
    [AppFunctions TEXT_FIELD_CONFIG:otlTxtName rect:CGRectMake(0,0,10,0)];
    otlTxtName.tintColor     = [UIColor colorWithRed:255 green:255 blue:255 alpha:255];
    self->listStateData = [States new];
    self->lblBairro     = @"";
    self->lblAgencia    = @"";
    self->lblEmail      = @"";
}

- (void)viewDidLoad
{
    [self initLists];
    [self initVariables];
    [super viewDidLoad];
}

#pragma mark -configNavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PERFIL
                                     title:nil
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_BACK
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:nil
                                backButton:YES];
    [AppFunctions KEYBOARD_ADD_BAR:@[otlTxtName]
                          delegate:self
                            change:@selector(textFieldDidChange:)
                              done:@selector(keyboardDone:)
                            cancel:@selector(keyboardClear:)];
}

- (IBAction)btnBackScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Numeric keyboard Clear
- (IBAction)keyboardClear:(UIBarButtonItem *)sender
{
    [keyboardField setText:@""];
    if ([otlState.titleLabel.text isEqualToString:@"Selecione o Estado"]) {
        [otlCity setEnabled:NO];
        if ( [keyboardField.text length] < 3 )
            [otlSearch setEnabled:NO];
    } else if ([otlCity.titleLabel.text isEqualToString:@"Selecione a Cidade"]) {
        if ( [keyboardField.text length] < 3 )
            [otlSearch setEnabled:NO];
    }
}

#pragma mark - Numeric keyboard Done
- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    [self unClearText:keyboardField];
    [keyboardField resignFirstResponder];
}

#pragma mark - keyboard Change Content
- (void)textFieldDidChange:(UITextField *)theTextField
{
    if ([keyboardField.text length] > 3 ) {
        [self->otlSearch setEnabled:YES];
        lblAgencia = theTextField.text;
    } else {
        [self->otlSearch setEnabled:NO];
        lblAgencia = @"";
    }
}

#pragma mark -configNavBar
- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [self.navigationController.navigationBar setHidden:NO];
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

#pragma mark -selectState and City
- (IBAction)textNameAgencia:(id)sender {
}

- (BOOL)getStateSelect
{
    return self->stateSelect;
}

- (void)setStateName:(id)data
{
    if (self->stateSelect){
        if (![otlState.titleLabel.text isEqualToString:(NSString *)data])
        {
            [otlState setTitle:(NSString *)data forState:UIControlStateNormal];
            [otlCity setTitle:@"Selecione a Cidade" forState:UIControlStateNormal];
            NSInteger ID = [self->listEstadosNomes indexOfObject:(NSString *)data];
            self->stateSigla = [self->listEstadosSigla objectAtIndex:ID];
            self->saveState  = [self->listEstadosNomes objectAtIndex:ID];
            [self reciveData:1];
            [otlCity setEnabled:YES];
            if ( [keyboardField.text length] < 3 )
                [otlSearch setEnabled:NO];
        }
    }
    else
    {
        NSInteger ID = [self->listStateData.listCitys indexOfObject:(NSString *)data];
        self->saveCity = [[self->listStateData.listCitys objectAtIndex:ID]nome];
        self->codCity  = [[self->listStateData.listCitys objectAtIndex:ID]codigo];
        [otlCity setTitle:self->saveCity forState:UIControlStateNormal];
        [self->otlSearch setEnabled:YES];
    }
}

- (IBAction)btnState:(id)sender
{
    self->stateSelect = YES;
    [self performSegueWithIdentifier:STORY_BOARD_SEARCH_CITY sender:self];
}

- (IBAction)btnCity:(id)sender
{
    self->stateSelect = NO;
    [self performSegueWithIdentifier:STORY_BOARD_SEARCH_CITY sender:self];
}

- (IBAction)btnSearch:(id)sender
{
    [self reciveData:2];
}

#pragma mark -functions
- (NSMutableArray *)getStateData
{
    if (self->stateSelect)
        return self->listEstadosNomes;
    else
        return self->listStateData.listCitys;
}

- (void)selectNewState
{
    [self->listStateData resetList];
}

#pragma mark -connection
- (void)reciveData:(int)type
{
    [self->listStateData resetListAgencia];
    [self->listStateData resetListVendedor];
    
    
    NSString *wsComplement;
    NSString *link;
    
    if (type == 1){
        wsComplement = [NSString stringWithFormat:WS_URL_CITY_SEARCH, KEY_CODE_SITE, KEY_CODE_COUNTRY,
                        self->stateSigla, KEY_ACCESS_KEY, KEY_TYPE_RETURN];
        link = [NSString stringWithFormat:WS_URL, WS_URL_CITY, wsComplement];
    }else{
        if (codCity    == nil) codCity    = @"";
        if (lblBairro  == nil) lblBairro  = @"";
        if (lblAgencia == nil) lblAgencia = @"";
        
        wsComplement = [NSString stringWithFormat:WS_URL_AGENCY_SEARCH, KEY_CODE_SITE, self->codCity,
                        self->lblBairro, self->lblAgencia, KEY_EMPTY, KEY_ACCESS_KEY, KEY_TYPE_RETURN];
        link = [NSString stringWithFormat:WS_URL, WS_URL_AGENCY, wsComplement];
    }
    
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : SEARCH_POTA_LABEL_CONNECTION_START_AGENCY,
                                       APP_CONNECTION_TAG_WAIT 	 : SEARCH_POTA_LABEL_CONNECTION_WAIT_AGENCY,
                                       APP_CONNECTION_TAG_RECIVE : SEARCH_POTA_LABEL_CONNECTION_RECIVE_AGENCY,
                                       APP_CONNECTION_TAG_FINISH : SEARCH_POTA_LABEL_CONNECTION_FINISH_AGENCY,
                                       APP_CONNECTION_TAG_ERROR  : SEARCH_POTA_LABEL_CONNECTION_ERROR_AGENCY };
    
    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:labelConnections showView:YES block:^(NSData *result) {
        if (result == nil) {
            if (type == 1) {
                [otlCity setEnabled:NO];
                [otlState setTitle:@"Selecione o Estado" forState:UIControlStateNormal];
                
                [AppFunctions LOG_MESSAGE:ERROR_1003_TITLE
                                  message:ERROR_1003_MESSAGE
                                   cancel:ERROR_BUTTON_CANCEL];
            }
            else if (type == 2)
                [AppFunctions LOG_MESSAGE:ERROR_1003_TITLE
                                  message:ERROR_1003_MESSAGE
                                   cancel:ERROR_BUTTON_CANCEL];
        }
        else {
            if (type == 1) {
                NSDictionary *allCitys = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:TAG_CITY];
                for (NSDictionary *tmp in [allCitys objectForKey:TAG_CITY])
                    [self->listStateData addCity:tmp];
            }
            else if (type == 2) {
                NSDictionary   *allCitys = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:TAG_AGENCY];
                for (NSDictionary *tmp in [allCitys objectForKey:TAG_AGENCY])
                    [self->listStateData addAgencia:tmp];
                [self nextScreen];
            }
        }
    }];
}

#pragma mark -saveData
- (NSString *)dataFilePath {
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:PLIST_STATE_NAME];
}

- (void)saveData
{
    NSMutableDictionary *data = [[NSMutableDictionary alloc]initWithDictionary:pList];
    
    if (saveState == nil) saveState = @"";
    if (saveCity  == nil) saveCity  = @"";
    [[data objectForKey:PLIST_STATE_TAG_LOCAL]setObject:self->saveState forKey:PLIST_STATE_TAG_STATES];
    [[data objectForKey:PLIST_STATE_TAG_LOCAL]setObject:self->saveCity  forKey:PLIST_STATE_TAG_CITYS];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

#pragma mark -next Screen
- (void)nextScreen
{
    [self saveData];
    [self performSegueWithIdentifier:STORY_BOARD_SEARCH_AGENCY sender:self];
}

#pragma mark -functions
- (States *)getStatesData
{
    return self->listStateData;
}

#pragma mark - text Views
- (BOOL)textFieldShouldBeginEditing:(UITextView *)textView
{
    [self clearText:textView];
    return YES;
}

- (void)clearText:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Nome da Agência"])
        textView.text = @"";
}

- (void)unClearText:(UITextField *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Nome da Agência";
        lblAgencia = @"";
    } else
        lblAgencia = textView.text;
    
    NSLog(@"%@", lblAgencia);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    lblAgencia = textField.text;
    [self unClearText:textField];
    [textField resignFirstResponder];
    
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    lblAgencia = textField.text;
    return YES;
}


@end
