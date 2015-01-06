//
//  agentePerfilPota.m
//  myPota
//
//  Created by Rodrigo Pimentel on 08/09/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "c1_Agent_Perfil_Pota.h"

@implementation c1_Agent_Perfil_Pota

- (void)viewDidLoad
{
    NSMutableDictionary *list = [AppFunctions PLIST_LOAD:PLIST_SELLER_NAME];
    if ([[list objectForKey:@"Chosen"] boolValue])
    {
        listInfos = [list objectForKey:@"Agencia"];
        [listInfos addEntriesFromDictionary:[list objectForKey:@"Vendedor"]];
        [listInfos setObject:USER_TYPE forKey:[list objectForKey:USER_TYPE]];
    }else {
        backScreen = (c0_Agent_Login *)[AppFunctions BACK_SCREEN:self number:1];
        listInfos  = [backScreen getSellerInfo];
        [self saveData];
    }
    [tableView setBackgroundColor:[UIColor clearColor]];
    [self setStartInfo];
    [super viewDidLoad];
}

- (void)setStartInfo
{
    [AppFunctions LOAD_IMAGE_ASYNC:[listInfos objectForKey:@"fotoVendedor"] completion:^(UIImage *image) {
        [SellerImage setImage:image];
    }];
    
    [SellerName   setText:[listInfos objectForKey:@"nomeVendedor"]];
    [SellerAgency setText:[listInfos objectForKey:@"nomeAgenciaVendedor"]];
    [SellerMail   setText:[listInfos objectForKey:@"emailVendedor"]];
    
    listContact = [@{@"Skype"    : [listInfos objectForKey:@"skypeVendedor"],
                     @"Whatsapp" : [listInfos objectForKey:@"whatsupVendedor"],
                     @"Face"     : [listInfos objectForKey:@"facebookVendedor"],
                     @"Chamada"  : [NSString stringWithFormat:@"%@ %@",[listInfos objectForKey:@"dddCelularVendedor"], [listInfos objectForKey:@"foneCelularVendedor"]],
                     @"Message" : [NSString stringWithFormat:@"%@ %@",[listInfos objectForKey:@"dddCelularVendedor"], [listInfos objectForKey:@"foneCelularVendedor"]],
                     @"Mail" : [listInfos objectForKey:@"emailAgenciaVendedor"]
                     } mutableCopy];
    
    if ([[listInfos objectForKey:@"enderecoAgenciaVendedor"] isEqualToString:@""] && [[listInfos objectForKey:@"cepAgenciaVendedor"] isEqualToString:@""] &&
        self->mapState != NULL && self->mapCity != NULL)
        [self->otlMap setEnabled:NO];
}

#pragma mark - willAppear
- (void)viewWillAppear:(BOOL)animated
{
    [self configScreen];
    [super viewWillAppear:animated];
}

#pragma mark -configNavBar
- (void)configScreen
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

- (IBAction)btnClients:(id)sender {
}

- (IBAction)btnEditInfo:(id)sender {
}

- (IBAction)btnMenu:(id)sender
{
    [AppFunctions POP_SCREEN:self
                  identifier:@"menuPOTA"
                    animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listContact count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] < [listContact count]) {
        return [self configCell1:_tableView index:indexPath];
    } else {
        return [self configCell2:_tableView index:indexPath];
    }
}

- (UITableViewCell *)configCell1:(UITableView *)_tableView index:(NSIndexPath *)indexPath
{
    agentePerfilPotaCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CellIcon" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSString *icon = @"Skype";
    if ([indexPath row] == 1)
        icon = @"Whatsapp";
    else if ([indexPath row] == 2)
        icon = @"Face";
    else if ([indexPath row] == 3)
        icon = @"Chamada";
    else if ([indexPath row] == 4)
        icon = @"Mail";
    else if ([indexPath row] == 5)
        icon = @"Message";
    NSString *stg = [[listContact objectForKey:icon] stringByReplacingOccurrencesOfString:@"https://www.facebook.com/" withString:@""];
    
    [cell.imgIcon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"perfilBtn%@",icon]]];
    if ([stg length] <= 0 || [stg isEqualToString:@"0 "])
        stg = @"Não informado";
    [cell.lblIcon setText:stg];
    
    return cell;
}

- (UITableViewCell *)configCell2:(UITableView *)_tableView index:(NSIndexPath *)indexPath
{
    agentePerfilPotaCellConfirm *cell = [_tableView dequeueReusableCellWithIdentifier:@"CellConfirm" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma mark - savePlist
-(void)saveData
{
    NSMutableDictionary *listSellInfo = [AppFunctions PLIST_PATH:PLIST_SELLER_NAME type:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc]initWithDictionary: listSellInfo];
    [data setObject:USER_SELLER forKey:USER_TYPE];
    
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

@end