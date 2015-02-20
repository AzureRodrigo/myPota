//
//  b9_User_Cadastre.m
//  mypota
//
//  Created by Rodrigo Pimentel on 20/01/15.
//  Copyright (c) 2015 web. All rights reserved.
//

#import "b9_User_Cadastre.h"

@implementation b9_User_Cadastre

#pragma mark - configScreen
- (void)configScreen
{
    [lblMail     setAccessibilityValue:@"E-Mail"];
    [lblPassword setAccessibilityValue:@"Senha"];
    [lblName     setAccessibilityValue:@"Nome"];
    [lblCpf      setAccessibilityValue:@"Cpf"];
    [lblCep      setAccessibilityValue:@"Cep"];
    [lblBirth    setAccessibilityValue:@"Birth"];
    
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PERFIL
                                     title:nil
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_BACK
                                buttonBack:@selector(backScreen:)
                             openSplitMenu:nil
                                backButton:YES];
    
    [AppFunctions KEYBOARD_ADD_BAR:@[lblName, lblMail, lblPassword, lblCpf, lblCep, lblBirth]
                          delegate:self
                            change:@selector(textFieldDidChange:)
                              done:@selector(keyboardDone:)
                            cancel:@selector(keyboardClear:)];
    
    lblName.tintColor = [UIColor colorWithRed:255 green:191 blue:191 alpha:255];
    lblMail.tintColor = [UIColor colorWithRed:255 green:191 blue:191 alpha:255];
    lblPassword.tintColor = [UIColor colorWithRed:255 green:191 blue:191 alpha:255];
    lblCpf.tintColor   = [UIColor colorWithRed:255 green:191 blue:191 alpha:255];
    lblCep.tintColor   = [UIColor colorWithRed:255 green:191 blue:191 alpha:255];
    lblBirth.tintColor = [UIColor colorWithRed:255 green:191 blue:191 alpha:255];
    [AppFunctions TEXT_FIELD_CONFIG:lblName rect:CGRectMake(0,0,10,0)];
    [AppFunctions TEXT_FIELD_CONFIG:lblMail rect:CGRectMake(0,0,10,0)];
    [AppFunctions TEXT_FIELD_CONFIG:lblPassword rect:CGRectMake(0,0,10,0)];
    [AppFunctions TEXT_FIELD_CONFIG:lblCpf rect:CGRectMake(0,0,10,0)];
    [AppFunctions TEXT_FIELD_CONFIG:lblCep rect:CGRectMake(0,0,10,0)];
    [AppFunctions TEXT_FIELD_CONFIG:lblBirth rect:CGRectMake(0,0,10,0)];
    
}

- (IBAction)backScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Textfield Functions
- (BOOL)textFieldShouldBeginEditing:(UITextView *)textView
{
    [self textFiedEditEnd:keyboardField];
    if ([textView.accessibilityValue isEqualToString:@"Birth"])
    {
        datePicker = [UIDatePicker new];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(incidentDateValueChanged:) forControlEvents:UIControlEventValueChanged];
        textView.inputView = datePicker;
        keyboardField = (UITextField *)textView;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        keyboardField.text = [dateFormatter stringFromDate:[datePicker date]];
        [AppFunctions TEXT_SCREEN_UP:self
                            textView:textView
                               frame:frame];
        [self cadastre:keyboardField];
        
    } else {
        keyboardField = (UITextField *)textView;
        [self textFiedEditStart:textView];
        [AppFunctions TEXT_SCREEN_UP:self
                            textView:textView
                               frame:frame];
    }
    return YES;
}

- (IBAction) incidentDateValueChanged:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    lblBirth.text = [dateFormatter stringFromDate:[datePicker date]];
    [self cadastre:lblBirth];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    keyboardField = textField;
    [self cadastre:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self setTextInfo:textField];
    [self textFiedEditEnd:textField];
    [AppFunctions TEXT_SCREEN_DOWN:self textField:textField frame:frame];
    [self cadastre:textField];
    return NO;
}

- (IBAction)keyboardClear:(UIBarButtonItem *)sender
{
    [keyboardField setText:@""];
    [self cadastre:keyboardField];
}

- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    [self textFiedEditEnd:keyboardField];
    [self setTextInfo:keyboardField];
    [AppFunctions TEXT_SCREEN_DOWN:self textField:keyboardField frame:frame];
    [self cadastre:keyboardField];
}

- (void)setTextInfo:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (void)textFiedEditStart:(UITextView *)textView
{
    if ([textView.accessibilityValue isEqualToString:@"E-Mail"])
        if ([textView.text isEqualToString:@"E-Mail"])
            textView.text = @"";
    if ([textView.accessibilityValue isEqualToString:@"Senha"])
        if ([textView.text isEqualToString:@"Senha"])
            textView.text = @"";
    if ([textView.accessibilityValue isEqualToString:@"Nome"])
        if ([textView.text isEqualToString:@"Nome"])
            textView.text = @"";
    if ([textView.accessibilityValue isEqualToString:@"Cpf"])
        if ([textView.text isEqualToString:@"CPF"])
            textView.text = @"";
    if ([textView.accessibilityValue isEqualToString:@"Cep"])
        if ([textView.text isEqualToString:@"CEP"])
            textView.text = @"";
    if ([textView.accessibilityValue isEqualToString:@"Birth"])
        if ([textView.text isEqualToString:@"Data de Nascimento"])
            textView.text = @"";
}

- (void)textFiedEditEnd:(UITextField *)textView
{
    if ([textView.accessibilityValue isEqualToString:@"E-Mail"])
        if ([textView.text isEqualToString:@""])
            textView.text = @"E-Mail";
    if ([textView.accessibilityValue isEqualToString:@"Senha"])
        if ([textView.text isEqualToString:@""])
            textView.text = @"Senha";
    if ([textView.accessibilityValue isEqualToString:@"Nome"])
        if ([textView.text isEqualToString:@""])
            textView.text = @"Nome";
    if ([textView.accessibilityValue isEqualToString:@"Cpf"])
        if ([textView.text isEqualToString:@""])
            textView.text = @"CPF";
    if ([textView.accessibilityValue isEqualToString:@"Cep"])
        if ([textView.text isEqualToString:@""])
            textView.text = @"CEP";
    if ([textView.accessibilityValue isEqualToString:@"Birth"])
        if ([textView.text isEqualToString:@""])
            textView.text = @"Data de Nascimento";
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configScreen];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    frame = self.view.frame;
    [super viewDidAppear:animated];
}

- (void)cadastre:(UITextField *)textField
{
    if (![lblMail.text isEqualToString:@""] 	&& ![lblMail.text isEqualToString:@"E-Mail"] &&
        ![lblPassword.text isEqualToString:@""] && ![lblPassword.text isEqualToString:@"Senha"] &&
        ![lblName.text isEqualToString:@""]     && ![lblName.text isEqualToString:@"Nome"] &&
        ![lblCpf.text isEqualToString:@""]      && ![lblCpf.text isEqualToString:@"CPF"] &&
        ![lblCep.text isEqualToString:@""]      && ![lblCep.text isEqualToString:@"CEP"] &&
        ![lblBirth.text isEqualToString:@""]    && ![lblBirth.text isEqualToString:@"Data de Nascimento"])
        
        [otlCadastre setEnabled:YES];
    else
        [otlCadastre setEnabled:NO];
}

- (BOOL)verifyData
{
    if(![AppFunctions VALID_MAIL:lblMail.text]) {
        [AppFunctions LOG_MESSAGE:@"Dados Incorretos!"
                          message:@"O E-Mail informado está incorreto!"
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    if([lblPassword.text length] < 3) {
        [AppFunctions LOG_MESSAGE:@"Dados Incorretos!"
                          message:@"A Senha informado é curta de mais"
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    
    if([lblName.text length] < 3) {
        [AppFunctions LOG_MESSAGE:@"Dados Incorretos!"
                          message:@"O Nome informado é curto de mais"
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    
    if(![AppFunctions VALID_CPF:lblCpf.text]){
        [AppFunctions LOG_MESSAGE:@"Dados Incorretos!"
                          message:@"O CPF informado está incorreto!"
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:LINK_CEP_VALIDATION, lblCep.text]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSDictionary *allData = (NSDictionary *)[[AzParser alloc] xmlDictionary:data tagNode:@"cep"];
    for (NSDictionary *tmp in [allData objectForKey:@"cep"]) {
        if (![[tmp objectForKey:@"status"] isEqualToString:@"1"])
        {
            [AppFunctions LOG_MESSAGE:@"Dados Incorretos!"
                              message:@"O Cep informado está incorreto!"
                               cancel:ERROR_BUTTON_CANCEL];
            
            return NO;
        }
    }
    
    return YES;
}

- (IBAction)btnCadastre:(id)sender
{
    if ([self verifyData])
        [self stepI];
}

- (void)stepI
{
    NSString *wsComplement = [NSString stringWithFormat:WS_b0_CADASTRE_USER, lblMail.text, lblPassword.text,
                              @"", @"", TAG_BASE_WS_INCLUDE, lblName.text, lblCpf.text, lblCep.text, lblBirth.text,
                              TAG_BASE_WS_ACESS_KEY, TAG_BASE_WS_TYPE_RETURN, TAG_BASE_WS_TYPE_ACESS];
    
    NSString *link = [NSString stringWithFormat:WS_URL, WS_b0_CADASTRE, wsComplement];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.dimBackground = YES;
    HUD.delegate      = self;
    [HUD show:YES];
    HUD.labelText = @"Logando aguarde.";
    
    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:nil showView:NO block:^(NSData *result) {
        if (result == nil) {
            [HUD hide:YES];
            [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                              message:ERROR_1000_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
        } else {
            NSDictionary *info = [AzParser xmlDictionary:result tagNode:TAG_B0_USER_PERFIL_OPEN];
            for (NSDictionary *tmp in [info objectForKey:TAG_B0_USER_PERFIL_OPEN])
            {
                fetch = nil;
                fetch = [AppFunctions DATA_BASE_ENTITY_GET:fetch
                                                  delegate:self
                                                    entity:TAG_USER_PERFIL
                                                      sort:TAG_USER_PERFIL_NAME];
                
                NSManagedObject *dataBD = [AppFunctions DATA_BASE_ENTITY_ADD:fetch];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_COD]           forKey:TAG_USER_PERFIL_CODE];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_COD_MD5]       forKey:TAG_USER_PERFIL_CODE_MD5];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_NAME]          forKey:TAG_USER_PERFIL_NAME];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_CPF]           forKey:TAG_USER_PERFIL_CPF];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_TYPE_PERSON]   forKey:TAG_USER_PERFIL_TYPE_PERSON];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_ADRESS]        forKey:TAG_USER_PERFIL_ADRESS];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_QUARTER]       forKey:TAG_USER_PERFIL_QUARTER];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_CEP]           forKey:TAG_USER_PERFIL_CEP];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_DDD]           forKey:TAG_USER_PERFIL_DDD];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_FONE]          forKey:TAG_USER_PERFIL_FONE];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_MAIL]          forKey:TAG_USER_PERFIL_MAIL];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_ADRESS_NUMBER] forKey:TAG_USER_PERFIL_ADRESS_NUMBER];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_COMPLEMENT]    forKey:TAG_USER_PERFIL_COMPLEMENT];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_DDD_CEL]       forKey:TAG_USER_PERFIL_DDD_CELL];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_CEL]           forKey:TAG_USER_PERFIL_CELL];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_BIRTH]         forKey:TAG_USER_PERFIL_BIRTH];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_COD_CITY]      forKey:TAG_USER_PERFIL_CODE_CITY];
                [dataBD setValue:[tmp objectForKey:TAG_B0_USER_PERFIL_NAME_CITY]     forKey:TAG_USER_PERFIL_NAME_CITY];
                [dataBD setValue:[AppFunctions GET_TOKEN_DEVICE]                     forKey:TAG_USER_PERFIL_CODE_TOKEN];
            }
            [self login_stepII];
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
    
    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:nil showView:NO block:^(NSData *result) {
        if (result == nil) {
            [HUD hide:YES];
            [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                              message:ERROR_1000_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
        } else {
            NSDictionary *info = [AzParser xmlDictionary:result tagNode:TAG_BASE_WS_REGISTER];
            for (NSDictionary *tmp in [info objectForKey:TAG_BASE_WS_REGISTER])
                if ([[tmp objectForKey:TAG_BASE_WS_REGISTER] isEqualToString:@""])
                    [self saveData];
                else{
                    [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                                      message:@"Email já cadastrado"
                                       cancel:ERROR_BUTTON_CANCEL];
                    [HUD hide:YES];
                }
        }
    }];
}

- (void)saveData
{
    if ([AppFunctions DATA_BASE_ENTITY_SAVE:fetch])
    {
        if ([self registerTypeUser:NO])
            [self nextScreen];
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
    [dataBD setValue:[NSNumber numberWithBool:NO] forKey:TAG_USER_TYPE_BOOL];
    
    if ([AppFunctions DATA_BASE_ENTITY_SAVE:fetch])
    {
        return YES;
    } else
        [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                          message:ERROR_1000_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
    return NO;
}

- (void)nextScreen
{
    [HUD hide:YES];
    [AppFunctions GO_TO_SCREEN:self destiny:SEGUE_B9_TO_B1];
}

@end
