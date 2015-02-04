//
//  hotelPota.m
//  myPota
//
//  Created by Rodrigo Pimentel on 10/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "hotelPota.h"

@implementation hotelPota

@synthesize infoHotel, wsCounter, wsFinal, wsToken, wsCounterNew;

#pragma mark - Config Screen
- (void)viewDidLoad
{
    //verificar
    maxRoons       = 4;
    roomInfo       = [AppFunctions PLIST_PATH:PLIST_HOTEL_ROOM_NAME type:@"plist"];
    wsCodSite      = KEY_CODE_SITE;
    //data
    calendarData = [@{ HOTEL_INFO_NUMBER_NIGHTS     : @"",
                       HOTEL_CALENDAR_GO_NUMERIC    : @"",
                       HOTEL_CALENDAR_END_NUMERIC   : @"",
                       HOTEL_CALENDAR_GO_ALPHA      : @"",
                       HOTEL_CALENDAR_END_ALPHA     : @"", }mutableCopy];
    
    NSDate *toDay    = [NSDate new];
    NSDate *toMorrow = [toDay dateByAddingTimeInterval:60*60*24*1];
    [self setDateTravel:toDay end:toMorrow];
    //age
    PickerAgeList =  @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13"];
    AgeChildren   = [NSMutableArray new];
    //hotel
    hotelData = [@{ HOTEL_INFO_DESTINY           : @"",
                    HOTEL_INFO_NUMBER_TRAVELLER  : @"1",
                    HOTEL_INFO_NUMBER_ADULTS     : @"1",
                    HOTEL_INFO_NUMBER_CHILDRENS  : @"0",
                    HOTEL_INFO_AGE_CHILDRENS     : AgeChildren,
                    HOTEL_INFO_NUMBER_ROONS      : @"1",
                    HOTEL_INFO_DATA_GO           : [calendarData objectForKey:HOTEL_CALENDAR_GO_NUMERIC],
                    HOTEL_INFO_DATA_END          : [calendarData objectForKey:HOTEL_CALENDAR_END_NUMERIC],
                    HOTEL_INFO_NUMBER_NIGHTS     : [calendarData objectForKey:HOTEL_INFO_NUMBER_NIGHTS]} mutableCopy];
    //table
    [tableViewData setDelegate:self];
    [tableViewData setDataSource:self];
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setSeparatorColor:[UIColor clearColor]];
    //connection
    wsDataChecking      = @"";
    wsCodCity           = @"";
    wsNumberNights      = @"";
    wsTypeRooms         = @"";
    wsRoomsOccupation   = @"1";
    wsToken             = @"";
    wsCounter           = @"0";
    wsCounterNew        = @"0";
    wsFinal             = @"";
    infoHotel           = [NSMutableArray new];
    //load
    [super  viewDidLoad];
}

#pragma mark -Config NavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_HOTEL
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

#pragma mark -Config Appear
- (void)viewWillAppear:(BOOL)animated
{
    [self  configNavBar];
    [self  setInfoPax];
    [super viewWillAppear:animated];
}

#pragma mark -Config Disappear
- (void)viewWillDisappear:(BOOL)animated
{
    [ct cancel];
    ct  = NULL;
    [super viewWillDisappear:animated];
}

#pragma mark - Functions Table
- (void)updateTable
{
    [self->tableViewData reloadData];
}

#pragma mark - Table Number of Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
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
        return [[hotelData objectForKey:HOTEL_INFO_NUMBER_CHILDRENS]intValue];
    else
        return 1;
}

#pragma mark - Table Cell Custom
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0)
        return [self customCell1:tableView cellForRowAtIndexPath:indexPath];
    else if ([indexPath section] == 1)
        return [self customCell2:tableView cellForRowAtIndexPath:indexPath];
    else if ([indexPath section] == 2)
        return [self customCell3:tableView cellForRowAtIndexPath:indexPath];
    else
        return [self customCell4:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - Table Cell Section 1
- (UITableViewCell *)customCell1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    hotelPotaCellAge *cell = [tableView dequeueReusableCellWithIdentifier:@"CellAge" forIndexPath:indexPath];
    
    if (cell.agePicker == nil)
    {
        cell.agePicker = [AppFunctions HORIZONTAL_PICKER:self
                                                    view:cell
                                                  center:cell.lblAge.center
                                               imageName:@"bgPickerAge"];
        [cell.agePicker setTag:[indexPath row]];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.lblAge setText:[NSString stringWithFormat:@"Idade da criança %d", [indexPath row]+1]];
    [cell.agePicker selectRow:[[AgeChildren objectAtIndex:[indexPath row]]intValue]-1 inComponent:0 animated:NO];
    
    return cell;
}

#pragma mark - Table Cell Section 2
- (UITableViewCell *)customCell2:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    hotelPotaCellRoom *cell = [tableView dequeueReusableCellWithIdentifier:@"CellRoom" forIndexPath:indexPath];
    
    if ([AgeChildren count] > 0)
        [cell.lineBar setHidden:NO];
    else
        [cell.lineBar setHidden:YES];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.lblNumber setText:[hotelData objectForKey:HOTEL_INFO_NUMBER_ROONS]];
    [cell.btnMinus addTarget:self action:@selector(btnCell2Minus:)
            forControlEvents:UIControlEventTouchUpInside];
    [cell.btnPlus addTarget:self action:@selector(btnCell2Plus:)
           forControlEvents:UIControlEventTouchUpInside];
    
    if ([[hotelData objectForKey:HOTEL_INFO_NUMBER_ROONS]intValue] < MAX_NUMBER_HOTEL_ROOMS)
        [cell.btnPlus setEnabled:YES];
    else
        [cell.btnPlus setEnabled:NO];
    
    if ([[hotelData objectForKey:HOTEL_INFO_NUMBER_ROONS]intValue] > 1)
        [cell.btnMinus setEnabled:YES];
    else
        [cell.btnMinus setEnabled:NO];
    
    return cell;
}

- (IBAction)btnCell2Minus:(id)sender
{
    int roons = [[hotelData objectForKey:HOTEL_INFO_NUMBER_ROONS]intValue];
    if (roons > 1)
        [hotelData setObject:[NSString stringWithFormat:@"%d",roons - 1] forKey:HOTEL_INFO_NUMBER_ROONS];
    [self verifyTravellers];
}

- (IBAction)btnCell2Plus:(id)sender
{
    int roons = [[hotelData objectForKey:HOTEL_INFO_NUMBER_ROONS]intValue];
    if (roons < MAX_NUMBER_HOTEL_ROOMS)
        [hotelData setObject:[NSString stringWithFormat:@"%d",roons + 1] forKey:HOTEL_INFO_NUMBER_ROONS];
    [self verifyTravellers];
}

#pragma mark - Table Cell Section 3
- (UITableViewCell *)customCell3:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    hotelPotaCellData *cell = [tableView dequeueReusableCellWithIdentifier:@"CellData" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell.lblGoDay    setText:[calendarData objectForKey:HOTEL_CALENDAR_GO_ALPHA]];
    [cell.lblEndDay   setText:[calendarData objectForKey:HOTEL_CALENDAR_END_ALPHA]];
    [cell.lblGoAlpha  setText:[calendarData objectForKey:HOTEL_CALENDAR_GO_NUMERIC]];
    [cell.lblEndAlpha setText:[calendarData objectForKey:HOTEL_CALENDAR_END_NUMERIC]];
    [cell.btnData addTarget:self action:@selector(btnCell3Data:)
           forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (IBAction)btnCell3Data:(id)sender
{
    [AppFunctions GO_TO_SCREEN:self destiny:@"hotelPotaTocalendarPota"];
}

#pragma mark - Table Cell Section 4
- (UITableViewCell *)customCell4:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    hotelPotaCellNext *cell = [tableView dequeueReusableCellWithIdentifier:@"CellSearch" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (![[hotelData objectForKey:HOTEL_INFO_DESTINY] isEqualToString:@""])
        [cell.btnSearch setEnabled:YES];
    else
        [cell.btnSearch setEnabled:NO];
    
    [cell.btnSearch addTarget:self action:@selector(btnCell4Search:)
             forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (IBAction)btnCell4Search:(id)sender
{
    [self initConnectionReset];
    [self prepareData];
}

#pragma mark - Picker Components
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

#pragma mark - Picker Row
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [PickerAgeList count];
}

#pragma mark - Picker Cell Content
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    return [AppFunctions HORIZONTAL_PICKER_TEXT:[PickerAgeList objectAtIndex:row]];
}

#pragma mark - Picker Cell Select
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [AgeChildren replaceObjectAtIndex:pickerView.tag withObject:[PickerAgeList objectAtIndex:row]];
}

#pragma mark - Function Childrens Age
- (void)setAgeChildrens
{
    int nbChilds    = [otlNumberChildren.text intValue];
    int nbChildsAge = (int)[AgeChildren count];
    
    if (nbChilds > nbChildsAge)
        for (int i=nbChildsAge; i < nbChilds; i++)
            [AgeChildren addObject:@"1"];
    else if (nbChilds < nbChildsAge)
        for (int i=nbChildsAge; i > nbChilds; i--)
            [AgeChildren removeLastObject];
}

#pragma mark - Functions Data
- (NSString *)getDayName:(NSDate *)date
{
    [formatDate setDateFormat:@"EEEE"];
    return      [formatDate stringFromDate:date];
}

- (NSString *)getWeakName:(NSDate *)date
{
    [formatDate setDateFormat:@"MMMM"];
    return      [formatDate stringFromDate:date];
}

- (NSString *)getDateFormat:(NSDate *)date
{
    [formatDate     setDateFormat:@"dd"];
    NSString        *txtDate = [formatDate stringFromDate:date];
    [formatDate     setDateFormat:@"MMMM/yyyy"];
    return [NSString stringWithFormat:@"%@ de %@",txtDate,[[formatDate stringFromDate:date]capitalizedString]];
}

- (void)setDateTravel:(NSDate *)start end:(NSDate *)end
{
    if (start == nil || end == nil) {
        return;
    }
    
    [calendarData setObject:[AzCalendar getDayName:start]           forKey:HOTEL_CALENDAR_GO_ALPHA];
    [calendarData setObject:[AzCalendar getDateFormatNumeric:start] forKey:HOTEL_CALENDAR_GO_NUMERIC];
    [calendarData setObject:[AzCalendar getDayName:end]             forKey:HOTEL_CALENDAR_END_ALPHA];
    [calendarData setObject:[AzCalendar getDateFormatNumeric:end]   forKey:HOTEL_CALENDAR_END_NUMERIC];
    
    wsDataChecking      = [calendarData objectForKey:HOTEL_CALENDAR_GO_NUMERIC];
    wsNumberNights      = [NSString stringWithFormat:@"%d",
                           [AppFunctions DIFERENCE_DATE_IN_DAYS_DATE:[calendarData objectForKey:HOTEL_CALENDAR_GO_NUMERIC]
                                                                 end:[calendarData objectForKey:HOTEL_CALENDAR_END_NUMERIC]]];
    
    [calendarData setObject:wsNumberNights forKey:HOTEL_INFO_NUMBER_NIGHTS];
}

- (void)defineDestinyData:(NSString *)dataCity dataCountry:(NSString *)dataCountry cityCod:(NSString *)cityCod
{
    otlDestinyCity         = dataCity;
    otlDestinyCountry.text = [NSString stringWithFormat:@"%@, %@",dataCity, dataCountry];
    [hotelData setObject:otlDestinyCountry.text forKey:HOTEL_INFO_DESTINY];
    wsCodCity              = cityCod;
}

#pragma mark - Button Controll Number Adults
- (IBAction)btnMinusAdults:(id)sender
{
    if ([otlNumberAdults.text intValue] > 1)
        [otlNumberAdults setText:[NSString stringWithFormat:@"%d", [otlNumberAdults.text intValue] -1]];
    [self verifyTravellers];
}

- (IBAction)btnPlusAdults:(id)sender
{
    int roons = [[hotelData objectForKey:HOTEL_INFO_NUMBER_ROONS]intValue];
    if ([otlNumberAdults.text intValue] + [otlNumberChildren.text intValue] < MAX_PEOPLE_HOTEL * roons)
        [otlNumberAdults setText:[NSString stringWithFormat:@"%d", [otlNumberAdults.text intValue] +1]];
    [self verifyTravellers];
}

#pragma mark - Button Controll Number Childs
- (IBAction)btnMinusChilds:(id)sender
{
    if ([otlNumberChildren.text intValue] > 0)
        [otlNumberChildren setText:[NSString stringWithFormat:@"%d", [otlNumberChildren.text intValue] -1]];
    [self verifyTravellers];
}

- (IBAction)btnPlusChilds:(id)sender
{
    int roons  = [[hotelData objectForKey:HOTEL_INFO_NUMBER_ROONS]intValue];
    if ([otlNumberAdults.text intValue] + [otlNumberChildren.text intValue] < MAX_PEOPLE_HOTEL * roons && [otlNumberChildren.text intValue] < MAX_PEOPLE_HOTEL_CHILDS * roons)
        [otlNumberChildren setText:[NSString stringWithFormat:@"%d", [otlNumberChildren.text intValue] +1]];
    [self verifyTravellers];
}

#pragma mark - controll Peoples
- (void)verifyTravellers
{
    if ([otlNumberAdults.text intValue] > 1)
        [otlBtnMinusAdults setEnabled:YES];
    else
        [otlBtnMinusAdults setEnabled:NO];
    
    if ([otlNumberChildren.text intValue] > 0)
        [otlBtnMinusChildren setEnabled:YES];
    else
        [otlBtnMinusChildren setEnabled:NO];
    
    int roons = [[hotelData objectForKey:HOTEL_INFO_NUMBER_ROONS]intValue];
    
    if ([otlNumberAdults.text intValue] + [otlNumberChildren.text intValue] >= MAX_PEOPLE_HOTEL * roons)
    {
        [otlBtnPlusChildren setEnabled:NO];
        [otlBtnPlusAdults setEnabled:NO];
    } else {
        
        if ([otlNumberAdults.text intValue] < MAX_PEOPLE_HOTEL)
            [otlBtnPlusAdults setEnabled:YES];
        if ([otlNumberChildren.text intValue] + [otlNumberAdults.text intValue] < MAX_PEOPLE_HOTEL * roons && [otlNumberChildren.text intValue] < MAX_PEOPLE_HOTEL_CHILDS * roons)
            [otlBtnPlusChildren setEnabled:YES];
        else
            [otlBtnPlusChildren setEnabled:NO];
    }
    [self setInfoPax];
}

#pragma mark - Funções de Ajuste de Pesquisa
- (void)setInfoPax
{
    [hotelData setObject:otlNumberAdults.text   forKey:HOTEL_INFO_NUMBER_ADULTS];
    [hotelData setObject:otlNumberChildren.text forKey:HOTEL_INFO_NUMBER_CHILDRENS];
    int adults   = [[hotelData objectForKey:HOTEL_INFO_NUMBER_ADULTS]intValue];
    int children = [[hotelData objectForKey:HOTEL_INFO_NUMBER_CHILDRENS]intValue];
    [otlPax setText:[NSString stringWithFormat:@"%d", adults + children]];
    [hotelData setObject:otlPax.text forKey:HOTEL_INFO_NUMBER_TRAVELLER];
    
    [self setAgeChildrens];
    
    [hotelData setObject:AgeChildren forKey:HOTEL_INFO_AGE_CHILDRENS];
    [self updateTable];
}

#pragma mark - Prepar Search
- (void)prepareData
{
    [self setInfoAge];
    purchaseData = [@{ PURCHASE_TYPE         : PURCHASE_TYPE_HOTEL,
                       PURCHASE_INFO_PRODUCT : @{
                               PURCHASE_DATA_TRAVEL_DESTINY     : [hotelData objectForKey:HOTEL_INFO_DESTINY],
                               PURCHASE_DATA_TRAVEL_DATA_START  : [hotelData objectForKey:HOTEL_INFO_DATA_GO],
                               PURCHASE_DATA_TRAVEL_DATA_END    : [hotelData objectForKey:HOTEL_INFO_DATA_END],
                               HOTEL_INFO_NUMBER_ADULTS         : [hotelData objectForKey:HOTEL_INFO_NUMBER_ADULTS],
                               HOTEL_INFO_NUMBER_CHILDRENS      : [hotelData objectForKey:HOTEL_INFO_NUMBER_CHILDRENS],
                               HOTEL_INFO_NUMBER_TRAVELLER      : [hotelData objectForKey:HOTEL_INFO_NUMBER_TRAVELLER],
                               HOTEL_INFO_AGE_CHILDRENS         : [hotelData objectForKey:HOTEL_INFO_AGE_CHILDRENS],
                               HOTEL_INFO_NUMBER_ROONS          : [hotelData objectForKey:HOTEL_INFO_NUMBER_ROONS],
                               HOTEL_INFO_NUMBER_NIGHTS         : [hotelData objectForKey:HOTEL_INFO_NUMBER_NIGHTS],
                               HOTEL_CALENDAR_GO_ALPHA          : [calendarData objectForKey:HOTEL_CALENDAR_GO_ALPHA],
                               HOTEL_CALENDAR_END_ALPHA         : [calendarData objectForKey:HOTEL_CALENDAR_END_ALPHA]
                               }
                       }mutableCopy];
    
    [self connectionSearchToken];
}

- (void)setInfoAge
{
    NSString *roonsStart = [NSString stringWithFormat:@"[1|%d|",[[hotelData objectForKey:HOTEL_INFO_NUMBER_ROONS] intValue]];
    NSString *roonsEnd   = @"";
    wsRoomsOccupation = otlPax.text;
    if ([otlNumberChildren.text intValue] > 0)
    {
        int tmpAge = [otlNumberChildren.text intValue];
        if (tmpAge > 2)
            tmpAge = 2;
        for (int age = 1; age <= tmpAge; age++)
            roonsEnd = [NSString stringWithFormat:@"%@%@,", roonsEnd,[[hotelData objectForKey:HOTEL_INFO_AGE_CHILDRENS] objectAtIndex:age - 1]]; // subistituir o 7
    }
    
    if ([roonsEnd length] <= 0)
        roonsEnd = @"1";
    if ( [[roonsEnd substringWithRange:NSMakeRange([roonsEnd length]-1, 1)] isEqualToString:@","])
        roonsEnd = [roonsEnd stringByReplacingCharactersInRange:NSMakeRange([roonsEnd length]-1, 1) withString:@""];
    
    roonsStart  = [NSString stringWithFormat:@"%@%@]", roonsStart, roonsEnd];
    wsTypeRooms = roonsStart;
}

#pragma mark - Functions Connection
- (void)connectionSearchToken
{
    wsLinkToken = [NSString stringWithFormat:WS_URL_HOTEL_SEARCH, KEY_CODE_SITE,
                   wsDataChecking, wsCodCity, wsNumberNights,
                   KEY_EMPTY, wsTypeRooms, KEY_EMPTY];
    wsLinkToken = [NSString stringWithFormat:WS_URL, WS_URL_TOKEN, wsLinkToken];
    
    [self initConnection:wsLinkToken];
}

- (void)connectionSearchHotel
{
    wsLinkHotel = [NSString stringWithFormat:WS_URL_HOTEL_TOKEN, KEY_CODE_SITE,
                   wsToken, wsCounter];
    wsLinkHotel = [NSString stringWithFormat:WS_URL, WS_URL_HOTEL, wsLinkHotel];
    [self initConnection:wsLinkHotel];
}

- (void)initConnection:(NSString *)link
{
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : HOTEL_POTA_CONNECTION_START,
                                       APP_CONNECTION_TAG_WAIT 	 : HOTEL_POTA_CONNECTION_WAIT,
                                       APP_CONNECTION_TAG_RECIVE : HOTEL_POTA_CONNECTION_RECIVE,
                                       APP_CONNECTION_TAG_FINISH : HOTEL_POTA_CONNECTION_FINISH,
                                       APP_CONNECTION_TAG_ERROR  : HOTEL_POTA_CONNECTION_ERROR };
    
    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:labelConnections showView:YES block:^(NSData *result) {
        if (result == nil) {
            [self initConnectionReset];
        }else {
            ctReceivedData = [result copy];
            if ([wsToken isEqualToString:@""]){
                [self initConnectionData:TAG_SEARCH_HOTEL
                                 subType:TAG_SEARCH_HOTEL];
                if (![wsToken isEqualToString:@""])
                    [self connectionSearchHotel];
            }
            else{
                
                [self initConnectionData:TAG_DETAILS
                                 subType:TAG_DETAILS];
                [self initConnectionDataHoteis:TAG_HOTEL];
                
                if ([wsFinal isEqualToString:@"false"]){
                    if ([wsCounter isEqualToString:wsCounterNew])
                        [self connectionSearchHotel];
                    else
                        if ([infoHotel count] > 0)
                            [self GO_NEXT_SCREEN];
                }else{
                    if ([infoHotel count] > 0)
                        [self GO_NEXT_SCREEN];
                    else
                        [self initConnectionReset];
                }
            }
        }
    }];
}

- (void)GO_NEXT_SCREEN
{
    [purchaseData setObject:@{ HOTEL_LINK_WS_TOKEN    : wsToken,
                               HOTEL_LINK_WS_COUNTER  : wsCounterNew,
                               HOTEL_LINK_WS_FINAL    : wsFinal,
                               HOTEL_LINK_WS_COD_SITE : wsCodSite}
                     forKey:HOTEL_LINK_WS_INFO];
    [purchaseData setObject:infoHotel forKey:HOTEL_INFO_ALL];
    
    [AppFunctions CLEAR_INFORMATION];
    [AppFunctions SAVE_INFORMATION:purchaseData
                               tag:PURCHASE];
    
    [self performSegueWithIdentifier:STORY_BOARD_HOTEL_RESULT sender:self];
}

- (void)initConnectionData:(NSString *)type subType:(NSString *)subType
{
    NSDictionary *reciveToken = (NSDictionary *)[[AzParser alloc] xmlDictionary:ctReceivedData tagNode:type];
    for (NSDictionary *tmp in [reciveToken objectForKey:subType])
    {
        if ([tmp objectForKey:TAG_TOKEN]){
            wsToken = [tmp objectForKey:TAG_TOKEN];
            break;
        }if ([tmp objectForKey:TAG_SEQUENCE_LAST])
            wsCounter = [tmp objectForKey:TAG_SEQUENCE_LAST];
        if ([tmp objectForKey:TAG_SEQUENCE_NEW])
            wsCounterNew = [tmp objectForKey:TAG_SEQUENCE_NEW];
        if ([tmp objectForKey:TAG_FINISH])
            wsFinal = [tmp objectForKey:TAG_FINISH];
        else if ([tmp objectForKey:TAG_FINISH_NEW])
            wsFinal = [tmp objectForKey:TAG_FINISH_NEW];
    }
}

- (void)initConnectionDataHoteis:(NSString *)type
{
    NSDictionary *reciveToken = (NSDictionary *)[[AzParser alloc] xmlDictionary:ctReceivedData tagNode:type];
    for (NSDictionary *tmp in [reciveToken objectForKey:type])
        [infoHotel addObject:tmp];
}

- (void)initConnectionReset
{
    self->wsToken        = @"";
    self->wsCounter      = @"0";
    self->wsCounterNew   = @"0";
    self->wsFinal        = @"false";
    self->infoHotel      = NULL;
    self->infoHotel      = [NSMutableArray new];
}

@end
