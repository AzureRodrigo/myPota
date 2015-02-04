//
//  packTypes.m
//  myPota
//
//  Created by Rodrigo Pimentel on 21/10/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "packTypes.h"

@interface packTypes ()

@end

@implementation packTypes

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"packTypes contem Warnings");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setSeparatorColor:[UIColor clearColor]];
    listTypes    = [NSMutableArray new];
    NSMutableDictionary *seller = [AppFunctions PLIST_LOAD:PLIST_SELLER_NAME];
    IDWS = [[seller objectForKey:PURCHASE_INFO_AGENCY]objectForKey:AGENCY_DATA_IDWS];
    if ([IDWS isEqualToString:@""])
        IDWS = KEY_ID_WS_TRAVEL;
    [self getCircuits];
}

#pragma mark -configNavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PACKAGE
                                     title:nil
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_CLEAR
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:@selector(menuOpen:)
                                backButton:YES];
    
    [AppFunctions KEYBOARD_ADD_BAR:@[textDestiny]
                          delegate:self
                            change:@selector(textFieldDidChange:)
                              done:@selector(keyboardDone:)
                            cancel:@selector(keyboardClear:)];
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

#pragma mark - Text Field
- (void)textFieldDidChange :(UITextField *)theTextField
{
    if (![textDestiny.text isEqualToString:@""])
        [oltBtnSearch setEnabled:YES];
    else
        [oltBtnSearch setEnabled:NO];
}

- (IBAction)keyboardClear:(UIBarButtonItem *)sender
{
    [textDestiny setText:@""];
}

- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    [textDestiny resignFirstResponder];
}

#pragma mark - willAppear
- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [tableViewData reloadData];
    [super viewWillAppear:animated];
}

#pragma mark - start Circuits
- (void)getCircuits
{
    [lblSearch setText:@"Procurando informações ..."];
    [self->connection   cancel];
    
    NSString *link = [NSString stringWithFormat:WS_URL_PACK_TYPES_INFO, @"4", @"23"];
    link           = [NSString stringWithFormat:WS_URL, WS_URL_PACK_TYPES, link];
    
    
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
            
            [lblSearch setText:ERROR_1013_MESSAGE];
            [otlLoad stopAnimating];
            [otlLoad setHidden:YES];
            [tableViewData  reloadData];
            
        }else {
            NSDictionary *allInfo = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:TAG_PACK_TYPES];
            for (NSDictionary *tmp in [allInfo objectForKey:TAG_PACK_TYPES])
            {
                NSDictionary *plan = @{ TAG_PACK_COD_AREA        : [tmp objectForKey:TAG_PACK_COD_AREA],
                                        TAG_PACK_COD_GROUP       : [tmp objectForKey:TAG_PACK_COD_GROUP],
                                        TAG_PACK_COD_PORTAL      : [tmp objectForKey:TAG_PACK_COD_PORTAL],
                                        TAG_PACK_COD_SITE        : [tmp objectForKey:TAG_PACK_COD_SITE],
                                        TAG_PACK_DSC_AREA        : [tmp objectForKey:TAG_PACK_DSC_AREA],
                                        TAG_PACK_SEO_DESCRIPTION : [tmp objectForKey:TAG_PACK_SEO_DESCRIPTION],
                                        TAG_PACK_SEO_PASSWORD    : [tmp objectForKey:TAG_PACK_SEO_PASSWORD],
                                        TAG_PACK_SEO_TITLE       : [tmp objectForKey:TAG_PACK_SEO_TITLE],
                                        TAG_PACK_TYPE_AREA       : [tmp objectForKey:TAG_PACK_TYPE_AREA]
                                        };
                [listTypes addObject:plan];
            }
            [otlLoad    stopAnimating];
            [otlLoad    setHidden:YES];
            [lblSearch  setHidden:YES];
            [tableViewData reloadData];
        }
    }];
}

#pragma mark - btn Search
- (IBAction)btnSearch:(id)sender {
    [self searchCircuits:1 index:0];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listTypes count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([listTypes count] > 0)
        return @"Nossos Pacotes Segmentados";
    else
        return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    packTypesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [cell.lblType setText:[[listTypes objectAtIndex:[indexPath row]] objectForKey:TAG_PACK_DSC_AREA]];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self searchCircuits:2 index:(int)[indexPath row]];
}

#pragma mark - search circuits
- (void)searchCircuits:(int)type index:(int)index
{
    NSString *link = @"";
    listCircuits = [NSMutableArray new];
    
    if (type == 1) {
        link =[NSString stringWithFormat:WS_URL_PACK_CIRCUITS_INFO, @"4", @"23", @"1", textDestiny.text, @"DP", @"desc"];
    } else {
        link =[NSString stringWithFormat:WS_URL_PACK_CIRCUITS_INFO,
               [[listTypes objectAtIndex:index]objectForKey:TAG_PACK_COD_SITE],
               [[listTypes objectAtIndex:index]objectForKey:TAG_PACK_COD_PORTAL],
               [[listTypes objectAtIndex:index]objectForKey:TAG_PACK_COD_AREA],
               @"",
               @"DP",
               @"desc"];
    }
    link = [NSString stringWithFormat:WS_URL, WS_URL_PACK_CIRCUITS, link];
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : TRAVEL_DESTINY_LABEL_CONNECTION_START,
                                       APP_CONNECTION_TAG_WAIT 	 : TRAVEL_DESTINY_LABEL_CONNECTION_WAIT,
                                       APP_CONNECTION_TAG_RECIVE : TRAVEL_DESTINY_LABEL_CONNECTION_RECIVE,
                                       APP_CONNECTION_TAG_FINISH : TRAVEL_DESTINY_LABEL_CONNECTION_FINISH,
                                       APP_CONNECTION_TAG_ERROR  : TRAVEL_DESTINY_LABEL_CONNECTION_ERROR };
    link = [link stringByReplacingOccurrencesOfString:@" " withString:@", "];
    
    [appConnection START_CONNECT:link timeForOu:15.F labelConnection:labelConnections showView:YES block:^(NSData *result) {
        if (result == nil){
            [AppFunctions LOG_MESSAGE:ERROR_1013_TITLE
                              message:ERROR_1013_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
            
            [lblSearch setText:ERROR_1013_MESSAGE];
        }else {
            NSDictionary *allInfo = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:@"Produto"];
            for (NSDictionary *tmp in [allInfo objectForKey:@"Produto"])
            {
                NSDictionary *plan = @{
                                        TAG_PACK_CIRCUIT_COIN            : [tmp objectForKey:TAG_PACK_CIRCUIT_COIN],
                                        TAG_PACK_CIRCUIT_COD_GROUP       : [tmp objectForKey:TAG_PACK_CIRCUIT_COD_GROUP],
                                        TAG_PACK_CIRCUIT_COD_PRODUCT     : [tmp objectForKey:TAG_PACK_CIRCUIT_COD_PRODUCT],
                                        TAG_PACK_CIRCUIT_OPT_SELL        : [tmp objectForKey:TAG_PACK_CIRCUIT_OPT_SELL],
                                        TAG_PACK_CIRCUIT_DSC_PERG        : [tmp objectForKey:TAG_PACK_CIRCUIT_DSC_PERG],
                                        TAG_PACK_CIRCUIT_DSC_PLAN        : [tmp objectForKey:TAG_PACK_CIRCUIT_DSC_PLAN],
                                        TAG_PACK_CIRCUIT_IND_AIR         : [tmp objectForKey:TAG_PACK_CIRCUIT_IND_AIR],
                                        TAG_PACK_CIRCUIT_IND_DESTAC      : [tmp objectForKey:TAG_PACK_CIRCUIT_IND_DESTAC],
                                        TAG_PACK_CIRCUIT_IND_PROMO       : [tmp objectForKey:TAG_PACK_CIRCUIT_IND_PROMO],
                                        TAG_PACK_CIRCUIT_IND_SCREEN      : [tmp objectForKey:TAG_PACK_CIRCUIT_IND_SCREEN],
                                        TAG_PACK_CIRCUIT_NAME_GROUP      : [tmp objectForKey:TAG_PACK_CIRCUIT_NAME_GROUP],
                                        TAG_PACK_CIRCUIT_NAME_COUNTRY    : [tmp objectForKey:TAG_PACK_CIRCUIT_NAME_COUNTRY],
                                        TAG_PACK_CIRCUIT_NAME_PRODUCT    : [tmp objectForKey:TAG_PACK_CIRCUIT_NAME_PRODUCT],
                                        TAG_PACK_CIRCUIT_NAME_SECURE     : [tmp objectForKey:TAG_PACK_CIRCUIT_NAME_SECURE],
                                        TAG_PACK_CIRCUIT_NUM_DAYS        : [tmp objectForKey:TAG_PACK_CIRCUIT_NUM_DAYS],
                                        TAG_PACK_CIRCUIT_NUM_PARCELA     : [tmp objectForKey:TAG_PACK_CIRCUIT_NUM_PARCELA],
                                        TAG_PACK_CIRCUIT_NUM_RANK        : [tmp objectForKey:TAG_PACK_CIRCUIT_NUM_RANK],
                                        TAG_PACK_CIRCUIT_SEO_DESCRIPTION : [tmp objectForKey:TAG_PACK_CIRCUIT_SEO_DESCRIPTION],
                                        TAG_PACK_CIRCUIT_TYPE_PRODUCT    : [tmp objectForKey:TAG_PACK_CIRCUIT_TYPE_PRODUCT],
                                        TAG_PACK_CIRCUIT_TYPE_ROTEIRO    : [tmp objectForKey:TAG_PACK_CIRCUIT_TYPE_ROTEIRO],
                                        TAG_PACK_CIRCUIT_VALUE_ENTRADA   : [tmp objectForKey:TAG_PACK_CIRCUIT_VALUE_ENTRADA],
                                        TAG_PACK_CIRCUIT_VALUE_PARCELA   : [tmp objectForKey:TAG_PACK_CIRCUIT_VALUE_PARCELA],
                                        TAG_PACK_CIRCUIT_VALUE_VENDA     : [tmp objectForKey:TAG_PACK_CIRCUIT_VALUE_VENDA],
                                        TAG_PACK_CIRCUIT_DATE_MES        : [tmp objectForKey:TAG_PACK_CIRCUIT_DATE_MES],
                                        TAG_PACK_CIRCUIT_DATE_PRODUTO    : [tmp objectForKey:TAG_PACK_CIRCUIT_DATE_PRODUTO],
                                        TAG_PACK_CIRCUIT_IMAGE_LOGO      : [tmp objectForKey:TAG_PACK_CIRCUIT_IMAGE_LOGO],
                                        TAG_PACK_CIRCUIT_IMAGE_PRODUTO   : [tmp objectForKey:TAG_PACK_CIRCUIT_IMAGE_PRODUTO]
                                        };
                [listCircuits addObject:plan];
            }
            [self goCircuits:index];
        }
    }];
}

- (void)goCircuits:(int)IdChoice
{
    NSDictionary *data = @{ PACKAGE_INFO_TYPE     : [listTypes objectAtIndex:IdChoice],
                            PACKAGE_INFO_CIRCUIT  : listCircuits
                          };
    [AppFunctions CLEAR_INFORMATION];
    [AppFunctions SAVE_INFORMATION:data
                               tag:PACKAGE_INFO_DATA];
    
    [AppFunctions GO_TO_SCREEN:self destiny:STORY_BOARD_PACK_TYPES_CIRCUIT];
}

@end
