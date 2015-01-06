//
//  b2_User_Pefil_Pota.m
//  myPota
//
//  Created by Rodrigo Pimentel on 07/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "b2_User_Pefil_Pota.h"

@implementation b2_User_Pefil_Pota

- (void)viewDidLoad
{
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setDelaysContentTouches:NO];
    [self initMemory];
    [self initScreenInfo];
    [self initButtons];
    [super viewDidLoad];
}

- (void)initMemory
{
    
    contactInfo = @[@{@"txt" : @"Telefone", @"img" : @"perfilBtnChamada"},
                    @{@"txt" : @"E-mail", 	@"img" : @"perfilBtnMail"},
                    @{@"txt" : @"Facebook", @"img" : @"perfilBtnFace"},
                    @{@"txt" : @"Mensagem", @"img" : @"perfilBtnMessage"},
                    @{@"txt" : @"Skype", 	@"img" : @"perfilBtnSkype"},
                    @{@"txt" : @"Whatsapp", @"img" : @"perfilBtnWhatsapp"}];
    
    NSMutableDictionary *list = [AppFunctions PLIST_LOAD:PLIST_SELLER_NAME];
    if ([[list objectForKey:@"Chosen"] boolValue]) {
        listInfos = [list objectForKey:@"Agencia"];
        [listInfos addEntriesFromDictionary:[list objectForKey:@"Vendedor"]];
        [listInfos setObject:USER_TYPE forKey:[list objectForKey:USER_TYPE]];
    } else {
        backScreen = (b1_User_Search *)[AppFunctions BACK_SCREEN:self number:1];
        listInfos  = [backScreen getInfoData];
        [self saveData];
    }
}

#pragma mark -configureScreen
- (void)initScreenInfo
{
    [AppFunctions LOAD_IMAGE_ASYNC:[listInfos objectForKey:@"fotoVendedor"] completion:^(UIImage *image) {
        [imgPerfil setImage:image];
    }];
    
    NSString *newName  = @"";
    NSString *lastName = @"";
    for (int i = 0; i < [[listInfos objectForKey:@"nomeVendedor"] length]; i++) {
        NSString *tmp = [[listInfos objectForKey:@"nomeVendedor"] substringWithRange:NSMakeRange(i, 1)];
        if ([tmp isEqualToString:@" "]) {
            newName = [[listInfos objectForKey:@"nomeVendedor"] substringWithRange:NSMakeRange(0, i)];
            break;
        }
    }
    
    if ([newName length] <=0 ) {
        newName = [listInfos objectForKey:@"nomeVendedor"];
    }
    
    for (int i = (int)[[listInfos objectForKey:@"nomeVendedor"] length]-1; i > 0 ; i--) {
        NSString *tmp = [[listInfos objectForKey:@"nomeVendedor"] substringWithRange:NSMakeRange(i, 1)];
        if ([tmp isEqualToString:@" "]) {
            int size = (int)[[listInfos objectForKey:@"nomeVendedor"] length] - i;
            lastName = [[listInfos objectForKey:@"nomeVendedor"] substringWithRange:NSMakeRange(i, size)];
            break;
        }
    }
    [self->lblName       setText:[NSString stringWithFormat:@"%@%@",newName,lastName]];
    [self->lblNameAgency setText:[NSString stringWithFormat:@"%@",[listInfos objectForKey:@"nomeAgenciaVendedor"]]];
    [self->lblMail       setText:[NSString stringWithFormat:@"%@",
                                  [listInfos objectForKey:@"emailAgenciaVendedor"]]];
    
    self->mapState = [[self->listState objectForKey:PLIST_STATE_TAG_LOCAL]objectForKey:PLIST_STATE_TAG_STATES];
    self->mapCity  = [[self->listState objectForKey:PLIST_STATE_TAG_LOCAL]objectForKey:PLIST_STATE_TAG_CITYS];
    
    if (self->mapState == NULL)
        self->mapState = [listInfos objectForKey:@"nomeUfVendedor"];
    if (self->mapCity == NULL)
        self->mapCity = [listInfos objectForKey:@"cidadeVendedor"];
}

#pragma mark -buttonScreen
- (void)initButtons
{
    //btnMail
    if ([[listInfos objectForKey:@"enderecoAgenciaVendedor"] isEqualToString:@""] && [[listInfos objectForKey:@"cepAgenciaVendedor"] isEqualToString:@""]
        && self->mapState != NULL && self->mapCity != NULL)
        [self->otlMap setEnabled:NO];
    //btnFone and btnWhats
    if ([[listInfos objectForKey:@"foneCelularVendedor"] isEqualToString:@""] || [listInfos objectForKey:@"foneCelularVendedor"] == NULL)
    {
        [self->otlFone setEnabled:NO];
        [self->otlMessenge setEnabled:NO];
    }
    //btnMail
    if ([[listInfos objectForKey:@"emailVendedor"] isEqualToString:@""] || [listInfos objectForKey:@"emailVendedor"] == NULL)
        [self->otlMail setEnabled:NO];
    //btnFace
    if ([[listInfos objectForKey:@"facebookVendedor"] isEqualToString:@""]  || [listInfos objectForKey:@"facebookVendedor"] == NULL)
        [self->otlFace setEnabled:NO];
    //btnSkype
    if ([[listInfos objectForKey:@"skypeVendedor"] isEqualToString:@""] || [listInfos objectForKey:@"skypeVendedor"] == NULL)
        [self->otlSkype setEnabled:NO];
    //btnWhatsApp
    if ([[listInfos objectForKey:@"whatsupVendedor"] isEqualToString:@""] || [listInfos objectForKey:@"whatsupVendedor"] == NULL)
        [self->otlWhatsapp setEnabled:NO];
}

- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PERFIL
                                     title:@""
                                superTitle:@""
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_BACK
                                buttonBack:nil
                             openSplitMenu:@selector(menuOpen:)
                                backButton:NO];
}

- (IBAction)menuOpen:(id)sender
{
    [AppMenuView openMenu:self
                   sender:sender];
}

#pragma mark -configNavBar
- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [super viewWillAppear:animated];
}

- (IBAction)btnMap:(id)sender
{
    NSString *address = [NSString stringWithFormat:@"%@ %@ %@ %@",
                         [listInfos objectForKey:@"enderecoAgenciaVendedor"],
                         self->mapCity,
                         self->mapState,
                         [listInfos objectForKey:@"cepAgenciaVendedor"]];
    NSString *mapAddress = [@"http://maps.apple.com/?q=" stringByAppendingString:[address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    BOOL result = [[UIApplication sharedApplication] openURL: [NSURL URLWithString: mapAddress]];
    if (!result)
        [AppFunctions LOG_MESSAGE:ERROR_1004_TITLE
                          message:ERROR_1004_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
}

- (IBAction)btnGoMenu:(id)sender
{
    [AppFunctions POP_SCREEN:self
                  identifier:STORYBOARD_ID_A2
                    animated:YES];
}

- (IBAction)btnChat:(id)sender
{
    //    [AppFunctions POP_SCREEN:self
    //                  identifier:@"menuPOTA"
    //                    animated:YES];
}

- (IBAction)btnFone:(id)sender
{
    NSString *fone = [listInfos objectForKey:@"foneCelularVendedor"];
    if (![[listInfos objectForKey:@"dddCelularVendedor"] isEqualToString:@""])
        fone = [NSString stringWithFormat:@"+55 %@ %@", [listInfos objectForKey:@"dddCelularVendedor"], [listInfos objectForKey:@"foneCelularVendedor"]];
    NSString *cleanedString = [[fone componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    BOOL result = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:cleanedString]]];
    if (!result)
        [AppFunctions LOG_MESSAGE:ERROR_1005_TITLE
                          message:ERROR_1005_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
}

- (IBAction)btnMail:(id)sender
{
    NSArray *toRecipients = [NSArray arrayWithObjects:[listInfos objectForKey:@"emailVendedor"], nil];
    NSString *subject     = @"aplicativo myPota";
    NSString *body        = @"Enviado via myPota";
    
    MFMailComposeViewController *mailView = [MFMailComposeViewController new];
    [mailView prefersStatusBarHidden];
    mailView.mailComposeDelegate = self;
    [mailView setToRecipients:toRecipients];
    [mailView setSubject:subject];
    [mailView setMessageBody:body isHTML:YES];
    
    [self.navigationController presentViewController:mailView animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    [self.parentViewController dismissViewControllerAnimated:YES completion:^{
        if (result > 0) {
            if (result == 1)
                [AppFunctions LOG_MESSAGE:LOG_TITLE_MAIL_FILED
                                  message:LOG_TEXT_MAIL_FILED
                                   cancel:LOG_BUTTON_CANCEL];
            else if (result == 2)
                [AppFunctions LOG_MESSAGE:LOG_TITLE_MAIL_SUCCESS
                                  message:LOG_TEXT_MAIL_SUCCESS
                                   cancel:LOG_BUTTON_CANCEL];
            else
                [AppFunctions LOG_MESSAGE:ERROR_1002_TITLE
                                  message:ERROR_1002_MESSAGE
                                   cancel:ERROR_BUTTON_CANCEL];
        }
    }];
}

- (IBAction)btnFace:(id)sender
{
    NSString *infoFace = [listInfos objectForKey:@"facebookVendedor"];
    infoFace           = [infoFace stringByReplacingOccurrencesOfString:@"https://" withString:@""];
    infoFace           = [infoFace stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    infoFace           = [infoFace stringByReplacingOccurrencesOfString:@"www.facebook.com/" withString:@""];
    NSString *link     = [NSString stringWithFormat:@"http://graph.facebook.com/%@", infoFace];
    
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : PERFIL_POTA_CONNECTION_START,
                                       APP_CONNECTION_TAG_WAIT 	 : PERFIL_POTA_CONNECTION_WAIT,
                                       APP_CONNECTION_TAG_RECIVE : PERFIL_POTA_CONNECTION_RECIVE,
                                       APP_CONNECTION_TAG_FINISH : PERFIL_POTA_CONNECTION_FINISH,
                                       APP_CONNECTION_TAG_ERROR  : PERFIL_POTA_CONNECTION_ERROR };
    
    [appConnection START_CONNECT:link timeForOu:15.F labelConnection:labelConnections showView:NO block:^(NSData *result) {
        if (result == nil)
            [AppFunctions LOG_MESSAGE:ERROR_1006_TITLE
                              message:ERROR_1006_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
        else{
            NSString* newStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
            if ([[newStr substringWithRange:NSMakeRange(0,7)]isEqualToString:@"{\"id\":\""]) {
                newStr = [newStr substringWithRange:NSMakeRange(7,[newStr length]-7)];
                for (int i = 0; i < [newStr length]; i++)
                    if ([[newStr substringWithRange:NSMakeRange(i, 1)]isEqualToString:@"\""]) {
                        NSString *myID = [newStr substringWithRange:NSMakeRange(0, i)];
                        NSURL *fanPageURL = [NSURL URLWithString:[NSString stringWithFormat:@"fb://profile/%@",myID]];
                        if (![[UIApplication sharedApplication] openURL: fanPageURL]) {
                            NSURL *webURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.facebook.com/%@",infoFace]];
                            BOOL result = [[UIApplication sharedApplication] openURL: webURL];
                            if (!result)
                                [AppFunctions LOG_MESSAGE:ERROR_1007_TITLE
                                                  message:ERROR_1007_MESSAGE
                                                   cancel:ERROR_BUTTON_CANCEL];
                        }
                        break;
                    }
            }
        }
    }];
}

- (IBAction)btnSkype:(id)sender
{
    BOOL installed = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"skype:"]];
    if(installed){
        BOOL result = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"skype://%@?call", [listInfos objectForKey:@"skypeVendedor"]]]];
        if (!result)
            [AppFunctions LOG_MESSAGE:ERROR_1008_TITLE
                              message:ERROR_1008_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
    }else{
        BOOL result = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/br/app/skype/id304878510?mt=8"]];
        if (!result)
            [AppFunctions LOG_MESSAGE:ERROR_1009_TITLE
                              message:ERROR_1009_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
    }
}

- (IBAction)btnMenssage:(id)sender
{
    NSString *fone = [listInfos objectForKey:@"foneCelularVendedor"];
    if (![[listInfos objectForKey:@"dddCelularVendedor"] isEqualToString:@""])
        fone = [NSString stringWithFormat:@"%@ %@", [listInfos objectForKey:@"dddCelularVendedor"], fone];
    NSString *cleanedString = [[fone componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSString *stringURL = [NSString stringWithFormat:@"sms:+%@", cleanedString];
    
    BOOL result = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringURL]];
    if (!result)
        [AppFunctions LOG_MESSAGE:ERROR_1036_TITLE
                          message:ERROR_1036_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
}

#pragma mark - whatsApp
- (IBAction)btnWhatsapp:(id)sender
{
    BOOL installed = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"whatsapp://"]];
    if (installed) {
        [AppFunctions SHOW_OPTIONS:self
                             title:@"Caso seu agente não exista na sua lista de contatos, \"myPota\" irá adicioná-lo."
                           message:nil
                            cancel:@"Cancelar"
                           confirm:@"Confirmar"];
        
    }else
        [AppFunctions LOG_MESSAGE:ERROR_1011_TITLE
                          message:ERROR_1011_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSDictionary *contact = @{WHATSAPP_CONTACT_NAME  : [listInfos objectForKey:@"nomeVendedor"],
                                  WHATSAPP_CONTACT_FONE  : [listInfos objectForKey:@"whatsupVendedor"],
                                  WHATSAPP_CONTACT_IMAGE : imgPerfil.image };
        [WhatsAppKit CALL_WHATSAPP:contact
                           message:@""];
    }
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self->menuOption close];
}

- (IBAction)btnMyPerfil:(id)sender
{
    [self->menuOption close];
}

- (IBAction)btnStoryBuy:(id)sender
{
    [self->menuOption close];
}

- (IBAction)btnChangePota:(id)sender
{
    listInfos = [[NSMutableDictionary alloc] initWithContentsOfFile:
                 [AppFunctions PLIST_SAVE:PLIST_STATE_TAG_SELLER]];
    [listInfos setObject:@NO forKey:PLIST_STATE_TAG_CHOSEN];
    [listInfos writeToFile:[AppFunctions PLIST_SAVE:PLIST_STATE_TAG_SELLER] atomically:YES];
    [self->menuOption close];
    [self performSegueWithIdentifier:STORY_BOARD_PERFIL_SEARCH sender:self];
}

#pragma mark - savePlist
-(void)saveData
{
    NSMutableDictionary *listSellInfo = [AppFunctions PLIST_PATH:PLIST_SELLER_NAME type:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc]initWithDictionary: listSellInfo];
    [data setObject:USER_CLIENT forKey:USER_TYPE];
    
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_URL_SITE]
                                      forKey:AGENCY_DATA_URL_SITE];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_BAIRRO]
                                      forKey:AGENCY_DATA_BAIRRO];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_CELULAR]
                                      forKey:AGENCY_DATA_CELULAR];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_CODE]
                                      forKey:AGENCY_DATA_CODE];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_CODE_SITE]
                                      forKey:AGENCY_DATA_CODE_SITE];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_COMPLEMENTO]
                                      forKey:AGENCY_DATA_COMPLEMENTO];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_CONTATO]
                                      forKey:AGENCY_DATA_CONTATO];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_DDD]
                                      forKey:AGENCY_DATA_DDD];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_DDD_CELULAR]
                                      forKey:AGENCY_DATA_DDD_CELULAR];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_MAIL]
                                      forKey:AGENCY_DATA_MAIL];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_ADRESS]
                                      forKey:AGENCY_DATA_ADRESS];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_FANTASY_NAME]
                                      forKey:AGENCY_DATA_FANTASY_NAME];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_FONE]
                                      forKey:AGENCY_DATA_FONE];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_IDWS]
                                      forKey:AGENCY_DATA_IDWS];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_IDWS_SITE]
                                      forKey:AGENCY_DATA_IDWS_SITE];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_LATITUDE]
                                      forKey:AGENCY_DATA_LATITUDE];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_LOGO]
                                      forKey:AGENCY_DATA_LOGO];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_LONGITUDE]
                                      forKey:AGENCY_DATA_LONGITUDE];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_NAME]
                                      forKey:AGENCY_DATA_NAME];
    [[data objectForKey:@"Agencia"]setObject:[listInfos objectForKey:AGENCY_DATA_MUBER]
                                      forKey:AGENCY_DATA_MUBER];
    
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_CITY]         forKey:SELLER_DATA_CITY];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_CEP]          forKey:SELLER_DATA_CEP];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_CITY_CODE]    forKey:SELLER_DATA_CITY_CODE];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_CODE]         forKey:SELLER_DATA_CODE];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_DDD_CELULAR]  forKey:SELLER_DATA_DDD_CELULAR];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_DDD]          forKey:SELLER_DATA_DDD];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_MAIL]         forKey:SELLER_DATA_MAIL];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_FACE]         forKey:SELLER_DATA_FACE];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_FONE_CELULAR] forKey:SELLER_DATA_FONE_CELULAR];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_FONE]         forKey:SELLER_DATA_FONE];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_FOTO]         forKey:SELLER_DATA_FOTO];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_GTALK]        forKey:SELLER_DATA_GTALK];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_UF_NAME]      forKey:SELLER_DATA_UF_NAME];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_NAME]         forKey:SELLER_DATA_NAME];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_GENDER]       forKey:SELLER_DATA_GENDER];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_UF]           forKey:SELLER_DATA_UF];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_SKYPE]        forKey:SELLER_DATA_SKYPE];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_TWIITER]      forKey:SELLER_DATA_TWIITER];
    [[data objectForKey:@"Vendedor"]setObject:[listInfos objectForKey:SELLER_DATA_WHATSAPP]     forKey:SELLER_DATA_WHATSAPP];
    
    [data setObject:@YES forKey:PLIST_STATE_TAG_CHOSEN];
    
    listSellInfo = data;
    
    BOOL result = [data writeToFile:[AppFunctions PLIST_SAVE:PLIST_STATE_TAG_SELLER] atomically:YES];
    
    if (!result)
        NSLog(@"Save fail");
    
    NSLog(@"%@",data);
}


//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [contactInfo count]+2;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([indexPath row] < [contactInfo count])
//        return [self configCell1:_tableView index:indexPath];
//    else
//        return [self configCell2:_tableView index:indexPath];
//}
//
//#pragma mark - Cell Size
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//        return 50;
//}
//
//- (UITableViewCell *)configCell1:(UITableView *)_tableView index:(NSIndexPath *)indexPath
//{
//    myPerfilRessourcesCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CellRessource" forIndexPath:indexPath];
//    [cell setBackgroundColor:[UIColor clearColor]];
//    [cell.imgIcon setImage:[UIImage imageNamed:
//                            [[contactInfo objectAtIndex:[indexPath row]]objectForKey:@"img"]]];
//    [cell.lblRessource setText:[[contactInfo objectAtIndex:[indexPath row]]objectForKey:@"txt"]];
//
//    return cell;
//}
//
//- (UITableViewCell *)configCell2:(UITableView *)_tableView index:(NSIndexPath *)indexPath
//{
//    myPerfilRessourcesCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CellRessource" forIndexPath:indexPath];
//    [cell setBackgroundColor:[UIColor clearColor]];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    [cell.imgIcon setHidden:YES];
//    [cell.lblRessource setHidden:YES];
//    [cell.imgDotLine setHidden:YES];
//    return cell;
//}
//
//#pragma mark - Table Cell Select
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([indexPath row] == 0)
//        [self btnFone];
//    else if ([indexPath row] == 1)
//        [self btnMail];
//    else if ([indexPath row] == 2)
//        [self btnFace];
//    else if ([indexPath row] == 3)
//        [self btnMessenge];
//    else if ([indexPath row] == 4)
//        [self btnSkype];
//    else if ([indexPath row] == 5)
//        [self btnWhats];
//}

@end
