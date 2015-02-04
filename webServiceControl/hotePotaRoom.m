//
//  hotePotaRoom.m
//  myPota
//
//  Created by Rodrigo Pimentel on 24/11/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "hotePotaRoom.h"

@interface hotePotaRoom ()

@end

@implementation hotePotaRoom

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"hotelPotaRoom dando Warnings");
}

#pragma mark - configNavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_HOTEL_RESERVE
                                     title:nil
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_CLEAR
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:nil
                                backButton:YES];
}

- (IBAction)btnBackScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [super viewWillAppear:animated];
}

#pragma mark - configHeader
- (void)configHeader
{
    dataPurchase = [[AppFunctions LOAD_INFORMATION:PURCHASE]mutableCopy];
    dataProduct  = [dataPurchase objectForKey:PURCHASE_INFO_PRODUCT];
    dataHotel    = [dataPurchase objectForKey:HOTEL_INFO];
    dataWS       = [dataPurchase objectForKey:HOTEL_LINK_WS_INFO];
    
    //hotel Data
    [AppFunctions LOAD_IMAGE_ASYNC:[dataHotel objectForKey:@"imagemHotel"]  completion:^(UIImage *image) {
        [HD_imgHotel setImage:image];
    }];
    NSString *lv = [[NSString stringWithFormat:@"star%@",[dataHotel objectForKey:@"estrelasHotel"]]
                    stringByReplacingOccurrencesOfString:@"." withString:@""];
    [HD_imgStars setImage:[UIImage imageNamed:lv]];
    [HD_lblName   setText:[dataHotel   objectForKey:@"nomeHotel"]];
    [HD_lblCity   setText:[dataProduct objectForKey:HOTEL_INFO_DESTINY]];
    [HD_lblStreet setText:[NSString stringWithFormat:@"%@, %@, %@",
                           [dataHotel   objectForKey:@"enderecoHotel"],
                           [dataHotel   objectForKey:@"localizacoes"],
                           [dataHotel   objectForKey:@"zipCodeHotel"]]];
    //traveller Data
    [HD_lblDestiny    setText:[dataProduct   objectForKey:HOTEL_INFO_DESTINY]];
    [HD_lblDataGo     setText:[NSString stringWithFormat:@"%@, %@",
                               [dataProduct objectForKey:HOTEL_CALENDAR_GO_ALPHA],
                               [dataProduct objectForKey:PURCHASE_DATA_TRAVEL_DATA_START]]];
    [HD_lblDataEnd    setText:[NSString stringWithFormat:@"%@, %@",
                               [dataProduct objectForKey:HOTEL_CALENDAR_END_ALPHA],
                               [dataProduct objectForKey:PURCHASE_DATA_TRAVEL_DATA_END]]];
    [HD_lblTravellers setText:[dataProduct   objectForKey:HOTEL_INFO_NUMBER_TRAVELLER]];
    [HD_lblRoons      setText:[dataProduct   objectForKey:HOTEL_INFO_NUMBER_ROONS]];
    [HD_lblNights     setText:[dataProduct   objectForKey:HOTEL_INFO_NUMBER_NIGHTS]];
}

- (void)viewDidLoad
{
    [self configHeader];
    [self loadRooms];
    [self configTable];
    [super viewDidLoad];
}

#pragma mark -loadRooms
- (void)loadRooms
{
    dataRooms = [NSMutableArray new];
    
    NSString *link = [NSString stringWithFormat:WS_URL_HOTEL_ROOM_INFO,
                      [dataWS objectForKey:HOTEL_LINK_WS_COD_SITE],
                      [dataWS objectForKey:HOTEL_LINK_WS_TOKEN],
                      [dataHotel objectForKey:@"idProvedor"],
                      [dataHotel objectForKey:@"codigoHotel"]];
    link = [NSString stringWithFormat:WS_URL, WS_URL_HOTEL_ROOM, link];
    
    NSString *tag = @"quarto";
    
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : HOTEL_POTA_LIST_RESULT_CONNECTION_START,
                                       APP_CONNECTION_TAG_WAIT 	 : HOTEL_POTA_LIST_RESULT_CONNECTION_WAIT,
                                       APP_CONNECTION_TAG_RECIVE : HOTEL_POTA_LIST_RESULT_CONNECTION_RECIVE,
                                       APP_CONNECTION_TAG_FINISH : HOTEL_POTA_LIST_RESULT_CONNECTION_FINISH,
                                       APP_CONNECTION_TAG_ERROR  : HOTEL_POTA_LIST_RESULT_CONNECTION_ERROR };
    
    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:labelConnections showView:YES block:^(NSData *result) {
        if (result != nil) {
            NSDictionary *allRoons = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:tag];
            for (NSDictionary *tmp in [allRoons objectForKey:tag]){
                NSMutableDictionary *room = [@{
                                               @"abreveaturaMoeda"  : [tmp objectForKey:@"abreveaturaMoeda"],
                                               @"codigoHotel"       : [tmp objectForKey:@"codigoHotel"],
                                               @"codigoQuarto"      : [tmp objectForKey:@"codigoQuarto"],
                                               @"dataCheckin"       : [tmp objectForKey:@"dataCheckin"],
                                               @"dscQuarto"         : [tmp objectForKey:@"dscQuarto"],
                                               @"dscRefeicao"       : [tmp objectForKey:@"dscRefeicao"],
                                               @"idProvedor"        : [tmp objectForKey:@"idProvedor"],
                                               @"indRecomendado"    : [tmp objectForKey:@"indRecomendado"],
                                               @"moedaVenda"        : [tmp objectForKey:@"moedaVenda"],
                                               @"precoTotal"        : [tmp objectForKey:@"precoTotal"],
                                               @"precoTotalMoeda"   : [tmp objectForKey:@"precoTotalMoeda"],
                                               @"precoVenda"        : [tmp objectForKey:@"precoVenda"],
                                               @"qtdAdulto"         : [tmp objectForKey:@"qtdAdulto"],
                                               @"qtdCrianca"        : [tmp objectForKey:@"qtdCrianca"],
                                               @"qtdNoites"         : [tmp objectForKey:@"qtdNoites"],
                                               @"qtdQuarto"         : [tmp objectForKey:@"qtdQuarto"],
                                               @"seqPesquisa"       : [tmp objectForKey:@"seqPesquisa"],
                                               @"tokenHotel"        : [tmp objectForKey:@"tokenHotel"]
                                               }mutableCopy];
                

//                                           @"dscCategoria"      : [tmp objectForKey:@"dscCategoria"],
                [dataRooms addObject:room];
            }
            
            NSLog(@"%@", dataRooms);
            [tableDataView reloadData];
            
        } else {
            NSLog(@"Error");
        }
    }];
}

#pragma mark - configTable
- (void)configTable
{
    [tableDataView setBackgroundColor:[UIColor clearColor]];
    [tableDataView setSeparatorColor:[UIColor clearColor]];
}

#pragma mark - Table Number of Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

#pragma mark - Cell Size
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0) {
        return 65;
    } else if ([indexPath section] == 1) {
        return 70;
    } else if ([indexPath section] == 2) {
        return 65;
    } else
        return 115;
}

#pragma mark - Table Number of Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 0;
    else
        return 0;
}

#pragma mark - Table Cell Custom
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if ([indexPath section] == 0)
    return [self customCell1:tableView cellForRowAtIndexPath:indexPath];
    //    else if ([indexPath section] == 1)
    //        return [self customCell2:tableView cellForRowAtIndexPath:indexPath];
    //    else if ([indexPath section] == 2)
    //        return [self customCell3:tableView cellForRowAtIndexPath:indexPath];
    //    else
    //        return [self customCell4:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - Table Cell Section 1
- (UITableViewCell *)customCell1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    hotelPotaCellAge *cell = [tableView dequeueReusableCellWithIdentifier:@"CellAge" forIndexPath:indexPath];
    //
    //    if (cell.agePicker == nil)
    //    {
    //        cell.agePicker = [AppFunctions HORIZONTAL_PICKER:self
    //                                                    view:cell
    //                                                  center:cell.lblAge.center
    //                                               imageName:@"bgPickerAge"];
    //        [cell.agePicker setTag:[indexPath row]];
    //    }
    //
    //    [cell setBackgroundColor:[UIColor clearColor]];
    //    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //    [cell.lblAge setText:[NSString stringWithFormat:@"Idade da criança %ld", [indexPath row]+1]];
    //    [cell.agePicker selectRow:[[AgeChildren objectAtIndex:[indexPath row]]intValue]-1 inComponent:0 animated:NO];
    //
    return nil;
}

@end
