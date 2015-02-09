//
//  packInfoDatas.m
//  myPota
//
//  Created by Rodrigo Pimentel on 03/12/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "p4_Packages_Data.h"

@implementation p4_Packages_Data

#pragma mark - configNavBar
- (void)configNavBar
{
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:@"Escolha a Data de Partida"
                                                               attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                            NSFontAttributeName: [UIFont fontWithName:FONT_NAME_BOLD size:18]}];
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_GENERIC
                                     title:title
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_CLEAR
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:nil
                                backButton:YES];
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


#pragma mark - configScreen
- (void)configScreen
{
    backScreen = (p2_Package_Info *)[AppFunctions BACK_SCREEN:self number:1];
    
    
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setSeparatorColor:[UIColor clearColor]];
    
    [self startConnection];
    
    [otlLoad startAnimating];
}

- (void)viewDidLoad {
    [self configScreen];
    [super viewDidLoad];
}

#pragma mark - Number of Lines
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    p4_Packages_Data_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellData" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.lblData setText:[[listDatas objectAtIndex:[indexPath row]]objectForKey:PACKAGE_INFO_DATA_SEARCH_DATA_FORMATED]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [backScreen setInfoData:[listDatas objectAtIndex:[indexPath row]]];
    [self btnBackScreen:nil];
}

#pragma mark - connection
- (void) startConnection
{
    listDatas = [NSMutableArray new];
    
    
    NSString *link = [backScreen getNextLink];
    
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
            NSString *tag = @"Saida";
            NSDictionary *allPlans = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:tag];
            for (NSDictionary *tmp in [allPlans objectForKey:tag]) {
                NSDictionary *plan = @{ PACKAGE_INFO_DATA_SEARCH_COD_PLAN 			: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_COD_PLAN],
                                        PACKAGE_INFO_DATA_SEARCH_COD_TEMP 			: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_COD_TEMP],
                                        PACKAGE_INFO_DATA_SEARCH_COD_TYPE_TEMP 		: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_COD_TYPE_TEMP],
                                        PACKAGE_INFO_DATA_SEARCH_IND_AERO			: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_IND_AERO],
                                        PACKAGE_INFO_DATA_SEARCH_COD_PLAN_AERO		: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_COD_PLAN_AERO],
                                        PACKAGE_INFO_DATA_SEARCH_DATA_ORIGINAL	  	: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_DATA_ORIGINAL],
                                        PACKAGE_INFO_DATA_SEARCH_DATA_FORMATED	 	: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_DATA_FORMATED],
                                        PACKAGE_INFO_DATA_SEARCH_DATA_AERO			: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_DATA_AERO],
                                        PACKAGE_INFO_DATA_SEARCH_COD_TYPE_CIRCUIT	: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_COD_TYPE_CIRCUIT],
                                        PACKAGE_INFO_DATA_SEARCH_DATA_FORMATED_WS   : [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_DATA_FORMATED_WS],
                                        PACKAGE_INFO_DATA_SEARCH_DSC_TYPE_TEMP	 	: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_DSC_TYPE_TEMP],
                                        PACKAGE_INFO_DATA_SEARCH_IND_PER_SOL_RES	: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_IND_PER_SOL_RES],
                                        PACKAGE_INFO_DATA_SEARCH_COMB_OPT_SELLING 	: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_COMB_OPT_SELLING],
                                        PACKAGE_INFO_DATA_SEARCH_DATA_EXTENCE		: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_DATA_EXTENCE],
                                        PACKAGE_INFO_DATA_SEARCH_DATA_EXTENCE_AERO	: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_DATA_EXTENCE_AERO],
                                        PACKAGE_INFO_DATA_SEARCH_MONTH_AJUST 		: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_MONTH_AJUST],
                                        PACKAGE_INFO_DATA_SEARCH_YEAR_AJUST  		: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_YEAR_AJUST],
                                        PACKAGE_INFO_DATA_SEARCH_MONTH_ORG   		: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_MONTH_ORG],
                                        PACKAGE_INFO_DATA_SEARCH_YEAR_ORG		 	: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_YEAR_ORG],
                                        PACKAGE_INFO_DATA_SEARCH_TYPE_PRODUCT		: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_TYPE_PRODUCT],
                                        PACKAGE_INFO_DATA_SEARCH_TYPE_ROTEIRO		: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_TYPE_ROTEIRO],
                                        PACKAGE_INFO_DATA_SEARCH_QUANT_DISP 		: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_QUANT_DISP],
                                        PACKAGE_INFO_DATA_SEARCH_QUANT_DISP_AERO 	: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_QUANT_DISP_AERO],
                                        PACKAGE_INFO_DATA_SEARCH_QUANT_DISP_CRUZERO : [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_QUANT_DISP_CRUZERO],
                                        PACKAGE_INFO_DATA_SEARCH_DATA_ATIVA		 	: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_DATA_ATIVA],
                                        PACKAGE_INFO_DATA_SEARCH_DATA_ATIVA_AERO	: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_DATA_ATIVA_AERO],
                                        PACKAGE_INFO_DATA_SEARCH_TYPE_AERO		 	: [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_TYPE_AERO]
                                        };
                [listDatas addObject:[plan mutableCopy]];
            }
            
            [lblLoad setHidden:YES];
            [otlLoad stopAnimating];
            [otlLoad setHidden:YES];
            
            [tableViewData reloadData];
        }
    }];
}

@end
