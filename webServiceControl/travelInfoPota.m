//
//  travelInfoPota.m
//  myPota
//
//  Created by Rodrigo Pimentel on 13/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "travelInfoPota.h"

@interface travelInfoPota ()

@end

@implementation travelInfoPota

- (void)initScreenVariables
{
    backScreen      = (travelPackges *)[AppFunctions BACK_SCREEN:self number:1];
    purchaseData    = [backScreen getPurchaseData];
    planSELECT      = [[purchaseData objectForKey:PURCHASE_INFO_PRODUCT] objectForKey:PURCHASE_DATA_TRAVEL_PLAN_SELECTED];
    listInfo        = [NSMutableArray new];
    float value     = [[planSELECT.valorPlanoReais stringByReplacingOccurrencesOfString:@","
                                                                   withString:@"."] floatValue];
    [lblPlano    setText:planSELECT.nomePlano];
    [lblMaxPrice setText:[NSString stringWithFormat:@"%.02f",value]];
}

- (void)initScreenTable
{
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setSeparatorColor:[UIColor clearColor]];
}

#pragma mark - didLoad
- (void)viewDidLoad
{
    [self initScreenVariables];
    [self initScreenTable];
    [self startConnection];
    [otlLoad startAnimating];
    [super viewDidLoad];
}

#pragma mark -configNavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_VIAGEM
                                     title:nil
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

#pragma mark - willAppear
- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [super viewWillAppear:animated];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    travelInfoPotaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSMutableDictionary *infos = [listInfo objectAtIndex:[indexPath row]];
    [infos objectForKey:@"code"];
    [cell.lblName setText:[infos objectForKey:@"info"]];
    [cell.lblPrice setText:[infos objectForKey:@"price"]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *infos = [listInfo objectAtIndex:[indexPath row]];
    if (![[infos objectForKey:@"descrition"] isEqualToString:@""])
        [AppFunctions LOG_MESSAGE:[infos objectForKey:@"info"]
                          message:[infos objectForKey:@"descrition"]
                           cancel:ERROR_BUTTON_CANCEL];
}

#pragma mark - connection
- (void) startConnection
{
    [lblLoad setText:@"Procurando informações ..."];
    [self->connection   cancel];
    link                = [NSString stringWithFormat:WS_URL_TRAVEL_INFO, KEY_CODE_SITE_TRAVEL,
                           KEY_CODE_PRODUCT_TRAVEL, planSELECT.codigoPlano];
    link                = [NSString stringWithFormat:WS_URL, WS_URL_TRAVEL, link];
    
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : TRAVEL_INFO_CONNECTION_START,
                                       APP_CONNECTION_TAG_WAIT 	 : TRAVEL_INFO_CONNECTION_WAIT,
                                       APP_CONNECTION_TAG_RECIVE : TRAVEL_INFO_CONNECTION_RECIVE,
                                       APP_CONNECTION_TAG_FINISH : TRAVEL_INFO_CONNECTION_FINISH,
                                       APP_CONNECTION_TAG_ERROR  : TRAVEL_INFO_CONNECTION_ERROR };
    
    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:labelConnections showView:NO block:^(NSData *result) {
        if (result == nil) {
            [AppFunctions LOG_MESSAGE:ERROR_1013_TITLE
                              message:ERROR_1013_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
            
            [lblLoad setText:ERROR_1013_MESSAGE];
            [otlLoad stopAnimating];
            [otlLoad setHidden:YES];
            [tableViewData  reloadData];
        } else {
            NSDictionary *allPlans = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:TAG_TRAVEL_PLAN_INFO];
            for (NSDictionary *tmp in [allPlans objectForKey:TAG_TRAVEL_PLAN_INFO])
            {
                NSMutableDictionary *infos = [NSMutableDictionary new];
                [infos setObject:[tmp objectForKey:@"CodCobertura"] forKey:@"code"];
                [infos setObject:[tmp objectForKey:@"DscCobertura"] forKey:@"info"];
                [infos setObject:[tmp objectForKey:@"VlrCobertura"] forKey:@"price"];
                [infos setObject:[tmp objectForKey:@"ObsCobertura"] forKey:@"descrition"];
                
                [listInfo addObject:infos];

            }
            [lblLoad setHidden:YES];
            [otlLoad stopAnimating];
            [otlLoad setHidden:YES];
            [tableViewData reloadData];
        }
    }];
}

@end
