//
//  HotelOriginDestiny.m
//  webServiceControl
//
//  Created by Rodrigo Pimentel on 14/03/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "hotelPotaDestiny.h"

@interface hotelPotaDestiny ()

@end

@implementation hotelPotaDestiny

#pragma HideStatusBar
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)initScreenVariables
{
    self->hotelSearchData   = [AppFunctions PLIST_LOAD:PLIST_HOTEL_NAME];
    
    self->city              = @"";
    self->Citys             = [NSMutableArray new];
    self->allCitys          = [NSMutableDictionary new];
    self->backScreen        = (hotelPota *)[AppFunctions BACK_SCREEN:self number:1];
}

- (void)initScreenData
{
    [searchBarData  setAutocorrectionType:UITextAutocorrectionTypeNo];
    [AppFunctions   CONFIGURE_SEARCH_BAR:self->searchBarData
                                delegate:self
                                    done:@selector(keyboardDone:)
                                  cancel:@selector(keyboardClear:)];
    [tableViewData  setBackgroundColor:[UIColor clearColor]];
    [tableViewData  setSeparatorColor:[UIColor clearColor]];
    [lblStatus      setHidden:YES];
}

#pragma mark - Numeric keyboard Clear
- (IBAction)keyboardClear:(UIBarButtonItem *)sender
{
    [txtViewSelected setText:@""];
}

#pragma mark - Numeric keyboard Done
- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    if ([txtViewSelected.text isEqualToString:@""])
        [txtViewSelected setText:@"Pesquisar"];
    [txtViewSelected resignFirstResponder];
}

- (void)viewDidLoad
{
    [self   initScreenVariables];
    [self   initScreenData];
    [super  viewDidLoad];
}

#pragma mark -config NavBar
- (void)viewWillAppear:(BOOL)animated
{
    [self   configNavBar];
    [super  viewWillAppear:animated];
}

- (void) configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_HOTEL
                                     title:@""
                                superTitle:@""
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_CLEAR
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:nil
                                backButton:YES];
}

- (IBAction)btnBackScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self->Citys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    hotelDestinyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *stcity   = [[self->Citys objectAtIndex:[indexPath row]]nameCity];
    NSString *stcontry = [[self->Citys objectAtIndex:[indexPath row]]nameContry];
    NSString *ststate  = [[self->Citys objectAtIndex:[indexPath row]]nameState];
    NSString *ligue    = @"%@, %@ - %@.";
    if ([stcontry isEqualToString:ststate]) {
        ststate = @"";
        ligue   = @"%@, %@. %@";
    }
    if ([stcontry isEqualToString:city]) {
        stcontry = @"";
        ligue   = @"%@. %@ %@";
    }
    
    dataCity = [NSString stringWithFormat:ligue,stcity, stcontry,ststate];
    
    cell.labelCidade.text = dataCity;
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self SetDestiny:(int)[indexPath row]];
}

-(void)SetDestiny:(int)ID
{
    NSMutableDictionary *data = [[NSMutableDictionary alloc]initWithDictionary: self->hotelSearchData];
    
    [[data objectForKey:PLIST_HOTEL_INFO_DESTINY]setObject:[[self->Citys objectAtIndex:ID]codigoCity]    forKey:PLIST_HOTEL_ID_CITY];
    [[data objectForKey:PLIST_HOTEL_INFO_DESTINY]setObject:[[self->Citys objectAtIndex:ID]codigoCountry] forKey:PLIST_HOTEL_ID_COUNTRY];
    [[data objectForKey:PLIST_HOTEL_INFO_DESTINY]setObject:[[self->Citys objectAtIndex:ID]nameCity]      forKey:PLIST_HOTEL_NAME_CITY];
    [[data objectForKey:PLIST_HOTEL_INFO_DESTINY]setObject:[[self->Citys objectAtIndex:ID]nameContry]    forKey:PLIST_HOTEL_NAME_COUNTRY];
    [[data objectForKey:PLIST_HOTEL_INFO_DESTINY]setObject:[[self->Citys objectAtIndex:ID]nameState]     forKey:PLIST_HOTEL_NAME_STATE];
    
    [data writeToFile:[AppFunctions PLIST_SAVE:PLIST_HOTEL_NAME] atomically:YES];
    
    [backScreen defineDestinyData:[[self->Citys objectAtIndex:ID]nameCity] dataCountry:[[self->Citys objectAtIndex:ID]nameContry] cityCod:[[self->Citys objectAtIndex:ID]codigoCity]];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -searchBarConfigure
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    for (UIView *searchSubview in searchBarData.subviews)
        for (UIView *SubsearchSubview in searchSubview.subviews)
            if ([SubsearchSubview isKindOfClass:[UITextField class]]){
                txtViewSelected = (UITextField *)SubsearchSubview;
            }
    self->allCitys      = [NSMutableDictionary new];
    self->Citys         = [NSMutableArray new];
    
    if ([txtViewSelected.text isEqualToString:@"Pesquisar"])
        [self->searchBarData setText:@""];
    
    [tableViewData      reloadData];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar
{
    [searchBarData resignFirstResponder];
    [tableViewData reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self->connection   cancel];
    self->allCitys      = nil;
    self->Citys         = [NSMutableArray new];
    searchBarData.text  = @"Busca";
    [searchBarData      resignFirstResponder];
    [lblStatus          setHidden:YES];
    [tableViewData      reloadData];
}

#pragma mark -filter
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [lblStatus setText:@"Buscando..."];
    if (searchText.length > 1) {
        self->city      = searchText;
        [lblStatus      setHidden:NO];
        self->allCitys  = nil;
        self->Citys     = [NSMutableArray new];
        [tableViewData  reloadData];
        [self           startConnection];
    }else{
        self->allCitys  = nil;
        [self->connection cancel];
        self->allCitys  = [NSMutableDictionary new];
        self->Citys     = [NSMutableArray new];
        [tableViewData  reloadData];
        [lblStatus      setHidden:YES];
    }
    [tableViewData      reloadData];
}

#pragma mark - connections
- (void) startConnection
{
    self->Citys         = [NSMutableArray new];
    [tableViewData      reloadData];
    [self->connection   cancel];
    NSString *tmp       = [NSString stringWithFormat:WS_URL_HOTEL_CITY, self->city];
    if ([DEBUG_TAG_SHOW_LINK_IN_CONNECTION isEqualToString:@"YES"])
        NSLog(@"\n%@\n",tmp);
    self->url           = [NSURL URLWithString:[tmp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    self->request       = [NSURLRequest requestWithURL:self->url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0f];
    self->connection    = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)_response
{
    self->receivedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self->receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [lblStatus      setText:ERROR_1013_MESSAGE];
    self->Citys     = [NSMutableArray new];
    [tableViewData  reloadData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)_connection
{
    self->allCitys  = nil;
    self->Citys     = [NSMutableArray new];
    [tableViewData  reloadData];
    
    self->allCitys  = (NSDictionary *)[[AzParser alloc] xmlDictionary:receivedData tagNode:TAG_CITY];
    for (NSDictionary *tmp in [self->allCitys objectForKey:TAG_CITY]) {
        HotelSeachCidades *cityTmp = [[HotelSeachCidades alloc]initData:[tmp objectForKey:PLIST_HOTEL_CITY_CODE]
                                                               nameCity:[tmp objectForKey:PLIST_HOTEL_CITY_NAME]
                                                          codigoCountry:[tmp objectForKey:PLIST_HOTEL_COUNTRY_CODE]
                                                            nameCountry:[tmp objectForKey:PLIST_HOTEL_COUNTRY_NAME]
                                                              nameState:[tmp objectForKey:PLIST_HOTEL_COUNTRY_NAME]];
        [self->Citys addObject:cityTmp];
    }
    if ([Citys count] == 0)
        [lblStatus setText:ERROR_1014_MESSAGE];
    else
        [lblStatus setHidden:YES];
    
    [tableViewData reloadData];
}

@end
