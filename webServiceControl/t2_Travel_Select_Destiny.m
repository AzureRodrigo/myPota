//
//  travelPotaDestiny.m
//  myPota
//
//  Created by Rodrigo Pimentel on 12/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "t2_Travel_Select_Destiny.h"

@implementation t2_Travel_Select_Destiny

#pragma mark - confiScreen
- (void)confiScreen
{
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setSeparatorColor:[UIColor clearColor]];
    
    backScreen = (t0_Travel *)[AppFunctions BACK_SCREEN:self number:1];
    
    myAgency = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_AGENCY];
    for (NSDictionary *info in [myAgency objectForKey:TAG_USER_AGENCY_LIST_ID_WS])
        if ([[info objectForKey:TAG_USER_AGENCY_CODE_SITE] isEqualToString:@"1"])
            IDWS = [info objectForKey:@"idWsSite"];
    if (IDWS == nil)
        IDWS = KEY_ID_WS_TRAVEL;
    
    [self startConnection];
    
    [otlLoad startAnimating];

}

- (void)viewDidLoad
{
    [self confiScreen];
    [super viewDidLoad];
}

#pragma mark -configNavBar
- (void)configNavBar
{
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:@"Destino"
                                                               attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                            NSFontAttributeName: [UIFont fontWithName:FONT_NAME_BOLD size:18]}];
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_GENERIC
                                     title:title
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
    return [listPlans count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    t2_Travel_Select_Destiny_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [cell.lblDestiny setText:[listPlans objectAtIndex:[indexPath row]]];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [backScreen setDestiny:[listPlans objectAtIndex:[indexPath row]]];
    [self btnBackScreen:nil];
}

#pragma mark - connection
- (void) startConnection
{
    listPlans = [NSMutableArray new];
    [lblLoad setText:@"Carregando opções aguarde."];
    [self->connection   cancel];

    NSString *link       = [NSString stringWithFormat:WS_URL_TRAVEL_DESTINY,IDWS,KEY_CODE_SITE_TRAVEL];
    link                 = [NSString stringWithFormat:WS_URL, WS_URL_TRAVEL_DESTINYS, link];
    
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : TRAVEL_DESTINY_LABEL_CONNECTION_START,
                                       APP_CONNECTION_TAG_WAIT 	 : TRAVEL_DESTINY_LABEL_CONNECTION_WAIT,
                                       APP_CONNECTION_TAG_RECIVE : TRAVEL_DESTINY_LABEL_CONNECTION_RECIVE,
                                       APP_CONNECTION_TAG_FINISH : TRAVEL_DESTINY_LABEL_CONNECTION_FINISH,
                                       APP_CONNECTION_TAG_ERROR  : TRAVEL_DESTINY_LABEL_CONNECTION_ERROR };
    
    [appConnection START_CONNECT:link timeForOu:15.F labelConnection:labelConnections showView:NO block:^(NSData *result) {
        if (result == nil){
            [AppFunctions LOG_MESSAGE:ERROR_1013_TITLE
                              message:ERROR_1013_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
            
            [lblLoad setText:ERROR_1013_MESSAGE];
            [otlLoad stopAnimating];
            [otlLoad setHidden:YES];
            [tableViewData  reloadData];
        }else {
            NSDictionary *allPlans = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:TAG_TRAVEL_DESTINY];
            for (NSDictionary *tmp in [allPlans objectForKey:TAG_TRAVEL_DESTINY])
                if ([tmp objectForKey:@"dscDestino"] != NULL)
                    if (![listPlans containsObject:[tmp objectForKey:@"dscDestino"]])
                        [listPlans addObject:[tmp objectForKey:@"dscDestino"]];
            
            [lblLoad setHidden:YES];
            [otlLoad stopAnimating];
            [otlLoad setHidden:YES];
            
            [tableViewData reloadData];
        }
    }];
}

@end
