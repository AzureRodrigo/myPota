//
//  c2_Agent_Chat.m
//  myPota
//
//  Created by Rodrigo Pimentel on 15/12/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "c2_Agent_Chat.h"

@implementation c2_Agent_Chat

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"Warning Memory int chat User");
}

- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PERFIL
                                     title:@""
                                superTitle:@""
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_BACK
                                buttonBack:@selector(backScreen:)
                             openSplitMenu:nil
                                backButton:YES];
}

- (IBAction)backScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadData
{
    dataSeller   = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_SELLER];
    dataUser     = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_PERFIL];
}

- (void)loadClients
{
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setSeparatorColor:[UIColor clearColor]];
    [lblStatus  setHidden:NO];
    [loadView   setHidden:NO];
    [loadView   startAnimating];
    
    link = [NSString stringWithFormat:WS_URL_CHAT_RECIVE_MESSAGE_INFO,
            [dataUser objectForKey:TAG_USER_PERFIL_CODE], @"", @""];
    link = [NSString stringWithFormat:WS_URL, WS_URL_CHAT_RECIVE_MESSAGE, link];
    
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : @"Carregando Mensagens!",
                                       APP_CONNECTION_TAG_WAIT 	 : @"Carregando Mensagens!",
                                       APP_CONNECTION_TAG_RECIVE : @"Carregando Mensagens!",
                                       APP_CONNECTION_TAG_FINISH : @"Menssagens Carregadas!",
                                       APP_CONNECTION_TAG_ERROR  : @"Não foi possivel carregar suas mensagens"};
    
    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:labelConnections showView:NO block:^(NSData *result) {
        if (result == nil)
            [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                              message:@"Não conseguimos carregar suas mensagens."
                               cancel:ERROR_BUTTON_CANCEL];
        else {
            clients = [NSMutableArray new];
            NSDictionary *allInfo = [AzParser xmlDictionary:result tagNode:@"chats"];
            for (NSDictionary *chats in [allInfo objectForKey:@"chats"])
            {
                [clients addObject:@{ @"codigoConsumidor" : [chats objectForKey:@"codigoConsumidor"],
                                      @"codigoVendedor"   : [chats objectForKey:@"codigoVendedor"],
                                      @"numberMessages"   : @"0",
                                      @"nameConsumidor"   : @"Astolfo"
                                      }];
            }
            [loadView  stopAnimating];
            [loadView  setHidden:YES];
            
            if ([clients count] >0)
                [lblStatus setText:@"Seus Clientes:"];
            else
                [lblStatus setText:@"Nenhum cliente enviou mensagem."];
            
            
            [lblStatus setAdjustsFontSizeToFitWidth:YES];
            //            lblStatus
            [tableViewData reloadData];
        }
    }];
}

- (void)viewDidLoad
{
    [self loadData];
    [self loadClients];
}

#pragma mark -configNavBar
- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [tableViewData reloadData];
    [super viewWillAppear:animated];
}

#pragma mark - tableview controll
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [clients count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    c2_Agente_Chat_Cell *cell = (c2_Agente_Chat_Cell *) [tableView dequeueReusableCellWithIdentifier:@"cell_chat" forIndexPath:indexPath];
    
    [cell.lblName   setText:[[clients objectAtIndex:[indexPath row]] objectForKey:@"nameConsumidor"]];
    [cell.lblNumber setText:[[clients objectAtIndex:[indexPath row]] objectForKey:@"numberMessages"]];
    
    [cell.lblName setAdjustsFontSizeToFitWidth:YES];
    [cell.lblNumber setAdjustsFontSizeToFitWidth:YES];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    code = [[clients objectAtIndex:[indexPath row]]objectForKey:@"codigoConsumidor"];
    [AppFunctions GO_TO_SCREEN:self destiny:SEGUE_C2_TO_B3];
}

- (NSString *)getClientCode
{
    return code;
}

- (NSString *)getMessage
{
    return @"";
}

@end
