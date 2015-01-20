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
    [self initData];
//    [self initButtons];
    [super viewDidLoad];
}

#pragma mark - config Screen
- (void)initData
{
    dataSeller = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_SELLER];
    dataAgency = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_AGENCY];
    
    [self initScreen];
}

- (void)initScreen
{
    [AppFunctions LOAD_IMAGE_ASYNC:[dataSeller objectForKey:TAG_USER_SELLER_FOTO] completion:^(UIImage *image) {
        [imgPerfil setImage:image];
    }];
    
    NSString *newName  = @"";
    NSString *lastName = @"";
    for (int i = 0; i < [[dataSeller objectForKey:TAG_USER_SELLER_NAME] length]; i++) {
        NSString *tmp = [[dataSeller objectForKey:TAG_USER_SELLER_NAME] substringWithRange:NSMakeRange(i, 1)];
        if ([tmp isEqualToString:@" "]) {
            newName = [[dataSeller objectForKey:TAG_USER_SELLER_NAME] substringWithRange:NSMakeRange(0, i)];
            break;
        }
    }
    
    if ([newName length] <=0 ) {
        newName = [dataSeller objectForKey:TAG_USER_SELLER_NAME];
    }
    
    for (int i = (int)[[dataSeller objectForKey:TAG_USER_SELLER_NAME] length]-1; i > 0 ; i--) {
        NSString *tmp = [[dataSeller objectForKey:TAG_USER_SELLER_NAME]substringWithRange:NSMakeRange(i, 1)];
        if ([tmp isEqualToString:@" "]) {
            int size = (int)[[dataSeller objectForKey:TAG_USER_SELLER_NAME] length] - i;
            lastName = [[dataSeller objectForKey:TAG_USER_SELLER_NAME] substringWithRange:NSMakeRange(i, size)];
            break;
        }
    }
    
    [self->lblName       setText:[NSString stringWithFormat:@"%@%@",newName,lastName]];
    [self->lblNameAgency setText:[NSString stringWithFormat:@"%@",[dataAgency objectForKey:TAG_USER_AGENCY_NAME]]];
    [self->lblMail       setText:[NSString stringWithFormat:@"%@",[dataAgency objectForKey:TAG_USER_AGENCY_MAIL]]];
    
    self->mapState = [[self->listState objectForKey:PLIST_STATE_TAG_LOCAL]objectForKey:PLIST_STATE_TAG_STATES];
    self->mapCity  = [[self->listState objectForKey:PLIST_STATE_TAG_LOCAL]objectForKey:PLIST_STATE_TAG_CITYS];
    
    if (self->mapState == NULL)
        self->mapState = [dataSeller objectForKey:TAG_USER_SELLER_UF_NAME];
    if (self->mapCity == NULL)
        self->mapCity = [dataSeller objectForKey:TAG_USER_SELLER_CITY];
}

- (void)initButtons
{
    //btnMail
    if ([[dataAgency objectForKey:TAG_USER_AGENCY_ADRESS] isEqualToString:@""] && [[dataAgency objectForKey:TAG_USER_AGENCY_CEP] isEqualToString:@""]
        && self->mapState != NULL && self->mapCity != NULL)
        [self->otlMap setEnabled:NO];
    //btnFone and btnWhats
    if ([[dataSeller objectForKey:TAG_USER_SELLER_CELL] isEqualToString:@""])
    {
        [self->otlFone setEnabled:NO];
        [self->otlMessenge setEnabled:NO];
    }
    //btnMail
    if ([[dataSeller objectForKey:TAG_USER_SELLER_MAIL] isEqualToString:@""])
        [self->otlMail setEnabled:NO];
    //btnFace
    if ([[dataSeller objectForKey:TAG_USER_SELLER_FACEBOOK] isEqualToString:@""])
        [self->otlFace setEnabled:NO];
    //btnSkype
    if ([[dataSeller objectForKey:TAG_USER_SELLER_SKYPE] isEqualToString:@""])
        [self->otlSkype setEnabled:NO];
    //btnWhatsApp
    if ([[dataSeller objectForKey:TAG_USER_SELLER_WHATSAPP] isEqualToString:@""])
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
                         [dataAgency objectForKey:TAG_USER_AGENCY_ADRESS],
                         self->mapCity,
                         self->mapState,
                         [dataAgency objectForKey:TAG_USER_AGENCY_CEP]];
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

- (IBAction)btnFone:(id)sender
{
    NSString *fone = [dataSeller objectForKey:TAG_USER_SELLER_CELL];
    if (![[dataSeller objectForKey:TAG_USER_SELLER_DDD_CELL] isEqualToString:@""])
        fone = [NSString stringWithFormat:@"+55 %@ %@", [dataSeller objectForKey:TAG_USER_SELLER_DDD_CELL], [dataSeller objectForKey:TAG_USER_SELLER_CELL]];
    NSString *cleanedString = [[fone componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    BOOL result = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:cleanedString]]];
    if (!result)
        [AppFunctions LOG_MESSAGE:ERROR_1005_TITLE
                          message:ERROR_1005_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
}

- (IBAction)btnMail:(id)sender
{
    NSArray *toRecipients = [NSArray arrayWithObjects:[dataSeller objectForKey:TAG_USER_SELLER_MAIL], nil];
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
    NSString *infoFace = [dataSeller objectForKey:TAG_USER_SELLER_FACEBOOK];
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
        BOOL result = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"skype://%@?call", [dataSeller objectForKey:TAG_USER_SELLER_SKYPE]]]];
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
    NSString *fone = [dataSeller objectForKey:TAG_USER_SELLER_CELL];
    if (![[dataSeller objectForKey:TAG_USER_SELLER_DDD_CELL] isEqualToString:@""])
        fone = [NSString stringWithFormat:@"%@ %@", [dataSeller objectForKey:TAG_USER_SELLER_DDD_CELL], fone];
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
        NSDictionary *contact = @{WHATSAPP_CONTACT_NAME  : [dataSeller objectForKey:TAG_USER_SELLER_NAME],
                                  WHATSAPP_CONTACT_FONE  : [dataSeller objectForKey:TAG_USER_SELLER_WHATSAPP],
                                  WHATSAPP_CONTACT_IMAGE : imgPerfil.image };
        [WhatsAppKit CALL_WHATSAPP:contact
                           message:@""];
    }
}

@end
