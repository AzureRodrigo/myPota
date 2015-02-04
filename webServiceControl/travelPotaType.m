//
//  travelPotaType.m
//  myPota
//
//  Created by Rodrigo Pimentel on 07/07/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "travelPotaType.h"

@implementation travelPotaType

- (void)initScreenData
{
    backScreen = (travelPota *)[AppFunctions BACK_SCREEN:self number:1];
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setSeparatorColor:[UIColor clearColor]];
    NSMutableDictionary *seller = [AppFunctions PLIST_LOAD:PLIST_SELLER_NAME];
    IDWS = [[seller objectForKey:PURCHASE_INFO_AGENCY]objectForKey:AGENCY_DATA_IDWS];
    if ([IDWS isEqualToString:@""])
        IDWS = KEY_ID_WS_TRAVEL;
    
    [self startConnection];
    [otlLoad startAnimating];
}

#pragma mark - didLoad
- (void)viewDidLoad
{
    [self initScreenData];
    [super viewDidLoad];
}

#pragma mark -configNavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_VIAGEM
                                     title:@""
                                superTitle:@""
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
    return [listTypes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    travelPotaTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [cell.lblType setText:[listTypes objectAtIndex:[indexPath row]]];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [backScreen setType:[listTypes objectAtIndex:[indexPath row]]];
    [self btnBackScreen:nil];
}

#pragma mark - connection
- (void) startConnection
{
    listTypes = [NSMutableArray new];
    [lblLoad setText:@"Procurando informações ..."];
    [self->connection   cancel];
    //aqui
    NSString *link       = [NSString stringWithFormat:WS_URL_TRAVEL_DESTINY_TYPE,KEY_CODE_SITE_TRAVEL, KEY_CODE_PORTAL_TRAVEL, KEY_CODE_AREA_TRAVEL];
    link                 = [NSString stringWithFormat:WS_URL, WS_URL_TRAVEL_DESTINYS_TYPE, link];
    
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
            NSDictionary *allPlans = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:TAG_TRAVEL_TYPE];
            for (NSDictionary *tmp in [allPlans objectForKey:TAG_TRAVEL_TYPE])
                if ([tmp objectForKey:@"dscTipoProduto"] != NULL)
                    if (![listTypes containsObject:[tmp objectForKey:@"dscTipoProduto"]])
                        [listTypes addObject:[tmp objectForKey:@"dscTipoProduto"]];
            
            [lblLoad setHidden:YES];
            [otlLoad stopAnimating];
            [otlLoad setHidden:YES];
            
            [tableViewData reloadData];
        }
    }];
}

@end
