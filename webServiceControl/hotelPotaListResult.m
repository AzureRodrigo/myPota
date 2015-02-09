//
//  hotelPotaListResult.m
//  myPota
//
//  Created by Rodrigo Pimentel on 17/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "hotelPotaListResult.h"

@implementation hotelPotaListResult

#pragma mark - screenConfigure
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (UIView *)filterViewConfig
{
    UIView *menu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, 240)]; //600x525
    menu.backgroundColor = [UIColor clearColor];
    
    UIImageView *bg = [[UIImageView alloc]initWithFrame:menu.frame];
    bg.backgroundColor = [UIColor clearColor];
    bg.image = [UIImage imageNamed:@"hotelFilterBg"];
    bg.layer.cornerRadius  = 0;
    bg.layer.masksToBounds = YES;
    [menu addSubview:bg];
    float sizeFont = 17;
    
    UIImageView *whiteBtn = [[UIImageView alloc]initWithFrame:CGRectMake(4, 8, 30, 25)];
    whiteBtn.backgroundColor = [UIColor clearColor];
    whiteBtn.image = [UIImage imageNamed:@"bookmarkWhite"];
    [menu addSubview:whiteBtn];
    
    //filterNameAZ
    buttonNameAZ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonNameAZ addTarget:self
                     action:@selector(selectNameAZ:)
           forControlEvents:UIControlEventTouchUpInside];
    [buttonNameAZ setTitle:@"nome (A-Z)" forState:UIControlStateNormal];
    [buttonNameAZ.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:sizeFont]];
    buttonNameAZ.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    buttonNameAZ.frame  = CGRectMake(0, 0, menu.frame.size.width * .95f, 50);
    //filterNameZA
    buttonNameZA = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonNameZA addTarget:self
                     action:@selector(selectNameZA:)
           forControlEvents:UIControlEventTouchUpInside];
    [buttonNameZA setTitle:@"nome (Z-A)" forState:UIControlStateNormal];
    [buttonNameZA.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:sizeFont]];
    buttonNameZA.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    buttonNameZA.frame  = CGRectMake(0, 0, menu.frame.size.width * .95f, 50);
    //filterStarUP
    buttonStarUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonStarUp addTarget:self
                     action:@selector(selectStarUp:)
           forControlEvents:UIControlEventTouchUpInside];
    [buttonStarUp setTitle:@"estrelas (0 a 5)" forState:UIControlStateNormal];
    [buttonStarUp.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:sizeFont]];
    buttonStarUp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    buttonStarUp.frame  = CGRectMake(0, 0, menu.frame.size.width * .95f, 50);
    //filterStarDown
    buttonStarDown = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonStarDown addTarget:self
                       action:@selector(selectStarDown:)
             forControlEvents:UIControlEventTouchUpInside];
    [buttonStarDown setTitle:@"estrelas (5 a 0)" forState:UIControlStateNormal];
    buttonStarDown.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [buttonStarDown.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:sizeFont]];
    buttonStarDown.frame  = CGRectMake(0, 0, menu.frame.size.width * .95f, 50);
    //filterMoneyUp
    buttonMoneyUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonMoneyUp addTarget:self
                      action:@selector(selectPriceUp:)
            forControlEvents:UIControlEventTouchUpInside];
    [buttonMoneyUp setTitle:@"preço (menor para o maior)" forState:UIControlStateNormal];
    [buttonMoneyUp.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:sizeFont]];
    buttonMoneyUp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    buttonMoneyUp.frame  = CGRectMake(0, 0, menu.frame.size.width * .95f, 50);
    //filterMoneyDown
    buttonMoneyDown = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonMoneyDown addTarget:self
                        action:@selector(selectPriceDown:)
              forControlEvents:UIControlEventTouchUpInside];
    [buttonMoneyDown setTitle:@"preço (maior para o menor)" forState:UIControlStateNormal];
    [buttonMoneyDown.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:sizeFont]];
    buttonMoneyDown.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    buttonMoneyDown.frame  = CGRectMake(0, 0, menu.frame.size.width * .95f, 50);
    
    [self paintButtonsFilterView];
    
    UIImageView *lineAZ = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, menu.frame.size.width * .95f, 1)];
    lineAZ.backgroundColor = [UIColor clearColor];
    lineAZ.image = [UIImage imageNamed:@"dot_line"];
    [menu addSubview:lineAZ];
    
    UIImageView *lineZA = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, menu.frame.size.width * .95f, 1)];
    lineZA.backgroundColor = [UIColor clearColor];
    lineZA.image = [UIImage imageNamed:@"dot_line"];
    [menu addSubview:lineZA];
    
    UIImageView *lineUP = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, menu.frame.size.width * .95f, 1)];
    lineUP.backgroundColor = [UIColor clearColor];
    lineUP.image = [UIImage imageNamed:@"dot_line"];
    [menu addSubview:lineUP];
    
    UIImageView *lineDown = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, menu.frame.size.width * .95f, 1)];
    lineDown.backgroundColor = [UIColor clearColor];
    lineDown.image = [UIImage imageNamed:@"dot_line"];
    [menu addSubview:lineDown];
    
    UIImageView *lineMoney = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, menu.frame.size.width * .95f, 1)];
    lineMoney.backgroundColor = [UIColor clearColor];
    lineMoney.image = [UIImage imageNamed:@"dot_line"];
    [menu addSubview:lineMoney];
    
    float space = .12f;
    float posX  = .5f;
    buttonNameAZ.center    = CGPointMake(menu.frame.size.width * posX, menu.frame.size.height * (.3f + space * 0));
    buttonNameZA.center    = CGPointMake(menu.frame.size.width * posX, menu.frame.size.height * (.3f + space * 1));
    buttonStarUp.center    = CGPointMake(menu.frame.size.width * posX, menu.frame.size.height * (.3f + space * 2));
    buttonStarDown.center  = CGPointMake(menu.frame.size.width * posX, menu.frame.size.height * (.3f + space * 3));
    buttonMoneyUp.center   = CGPointMake(menu.frame.size.width * posX, menu.frame.size.height * (.3f + space * 4));
    buttonMoneyDown.center = CGPointMake(menu.frame.size.width * posX, menu.frame.size.height * (.3f + space * 5));
    
    
    lineAZ.center    = CGPointMake(menu.frame.size.width * posX, menu.frame.size.height * (.355f + space * 0));
    lineZA.center    = CGPointMake(menu.frame.size.width * posX, menu.frame.size.height * (.355f + space * 1));
    lineUP.center    = CGPointMake(menu.frame.size.width * posX, menu.frame.size.height * (.355f + space * 2));
    lineDown.center  = CGPointMake(menu.frame.size.width * posX, menu.frame.size.height * (.355f + space * 3));
    lineMoney.center = CGPointMake(menu.frame.size.width * posX, menu.frame.size.height * (.355f + space * 4));
    
    [menu addSubview:buttonNameAZ];
    [menu addSubview:buttonNameZA];
    [menu addSubview:buttonStarUp];
    [menu addSubview:buttonStarDown];
    [menu addSubview:buttonMoneyUp];
    [menu addSubview:buttonMoneyDown];
    
    return menu;
}

- (void)paintButtonsFilterView
{
    [buttonNameAZ    setTintColor:[UIColor grayColor]];
    [buttonNameZA    setTintColor:[UIColor grayColor]];
    [buttonStarUp    setTintColor:[UIColor grayColor]];
    [buttonStarDown  setTintColor:[UIColor grayColor]];
    [buttonMoneyUp   setTintColor:[UIColor grayColor]];
    [buttonMoneyDown setTintColor:[UIColor grayColor]];
    
    if ([wsFilter isEqualToString:@"nomeHotel"])
    {
        if (wsFilterUp)
            [buttonNameAZ  setTintColor:[UIColor blackColor]];
        else
            [buttonNameZA  setTintColor:[UIColor blackColor]];
    }
    else if ([wsFilter isEqualToString:@"estrelasHotel.floatValue"])
    {
        if (wsFilterUp)
            [buttonStarUp setTintColor:[UIColor blackColor]];
        else
            [buttonStarDown setTintColor:[UIColor blackColor]];
    }
    else if ([wsFilter isEqualToString:@"precoTotal.floatValue"])
    {
        if (wsFilterUp)
            [buttonMoneyUp setTintColor:[UIColor blackColor]];
        else
            [buttonMoneyDown setTintColor:[UIColor blackColor]];
    }
}

- (void)appearFilterView
{
    [self paintButtonsFilterView];
    
    [self->filterView showPos:CGPointMake(CGRectGetMidX(self.view.frame) - 36, self.view.frame.size.height * .545)
                   backGround:NO
                       corner:0];
    
    UITapGestureRecognizer *singleFingerTap =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(handleSingleTap:)];
    [self->filterView addGestureRecognizer:singleFingerTap];
}

- (IBAction)selectNameAZ:(id)sender
{
    wsFilter = @"nomeHotel";
    wsFilterUp = YES;
    [self finishFilterView];
}

- (IBAction)selectNameZA:(id)sender
{
    wsFilter = @"nomeHotel";
    wsFilterUp = NO;
    [self finishFilterView];
}

- (IBAction)selectStarUp:(id)sender
{
    wsFilterUp = YES;
    wsFilter = @"estrelasHotel.floatValue";
    [self finishFilterView];
}

- (IBAction)selectStarDown:(id)sender
{
    wsFilterUp = NO;
    wsFilter = @"estrelasHotel.floatValue";
    [self finishFilterView];
}

- (IBAction)selectPriceUp:(id)sender
{
    wsFilterUp = YES;
    wsFilter = @"precoTotal.floatValue";
    [self finishFilterView];
}

- (IBAction)selectPriceDown:(id)sender
{
    wsFilterUp = NO;
    wsFilter = @"precoTotal.floatValue";
    [self finishFilterView];
}

- (void)initFilterView
{
    self->filterView = [[CustomIOS7AlertView alloc] init];
    [self->filterView setContainerView:[self filterViewConfig]];
    [self->filterView setButtonTitles:nil];
    [self->filterView setDelegate:self];
    [self->filterView setUseMotionEffects:true];
}

- (void)initScreenVariables
{
    InfoPurchase         = [[AppFunctions LOAD_INFORMATION:PURCHASE]mutableCopy];
    InfoHoteis           = [InfoPurchase objectForKey:HOTEL_INFO_ALL];
    InfoToken            = [InfoPurchase objectForKey:HOTEL_LINK_WS_INFO];
    InfoProduct          = [InfoPurchase objectForKey:PURCHASE_INFO_PRODUCT];
    
    wsLink               = WS_URL_POTA_HOTA;
    wsFilter             = @"nomeHotel";
    wsFilterUp           = YES;
    wsCodSite            = [InfoToken objectForKey:HOTEL_LINK_WS_COD_SITE];
    wsToken              = [InfoToken objectForKey:HOTEL_LINK_WS_TOKEN];
    wsCounter            = [InfoToken objectForKey:HOTEL_LINK_WS_COUNTER];
    wsFinal              = [InfoToken objectForKey:HOTEL_LINK_WS_FINAL];
    
    
    [lblCity         setText:[InfoProduct objectForKey:HOTEL_INFO_DESTINY]];
    [lblDataStart    setText:[InfoProduct objectForKey:PURCHASE_DATA_TRAVEL_DATA_START]];
    [lblDataEnd      setText:[InfoProduct objectForKey:PURCHASE_DATA_TRAVEL_DATA_END]];
    [lblNumberPeople setText:[InfoProduct objectForKey:HOTEL_INFO_NUMBER_TRAVELLER]];
    [lblNumberRooms  setText:[InfoProduct objectForKey:HOTEL_INFO_NUMBER_ROONS]];
    [lblNumberDays   setText:[InfoProduct objectForKey:HOTEL_INFO_NUMBER_NIGHTS]];
    
    [LoadBar setHidesWhenStopped:YES];
    [searchBarData setDelegate:self];
    [self->searchBarData setAutocorrectionType:UITextAutocorrectionTypeNo];
    searchSelect = NO;
}

- (void)initListHotel
{
    listHoteis = [NSMutableArray new];
    listImages = [NSMutableDictionary new];
    listHoteis = [self loadHoteis:InfoHoteis];
    listHoteis = [self cleanHoteis:listHoteis];
    listHoteis = [self applyFilter:wsFilter ascending:wsFilterUp];
    listHoteisSearch = [listHoteis mutableCopy];
    [self loadImages:listHoteisSearch];
}

- (NSMutableArray *)loadHoteis:(NSMutableArray *)list
{
    NSMutableArray *tmpList = [NSMutableArray new];
    for (NSDictionary *tmp in list)
    {
        [tmpList addObject:[[potaHoteisData alloc]initHoteis:tmp]];
    }
    return [tmpList mutableCopy];
}

#pragma mark -remover após busca arrumada!
- (NSMutableArray *)cleanHoteis:(NSMutableArray *)list
{
    NSMutableArray *codigosHoteis = [NSMutableArray new];
    for (potaHoteisData *hotelA in list)
    {
        [codigosHoteis addObject:hotelA.codigoHotel];
    }
    NSMutableArray *testCod = [NSMutableArray new];
    for (NSString *tmp in codigosHoteis)
    {
        if(![testCod containsObject:tmp])
            [testCod addObject:tmp];
    }
    codigosHoteis = [testCod mutableCopy];
    NSMutableArray *tmplistHoteis = [NSMutableArray new];
    for (NSString *cod in codigosHoteis) {
        for (potaHoteisData *hotel in list) {
            if ([cod isEqualToString:hotel.codigoHotel]) {
                [tmplistHoteis addObject:hotel];
                break;
            }
        }
    }
    return [tmplistHoteis mutableCopy];
}

- (void)loadImages:(NSMutableArray *)list
{
    for (potaHoteisData *hotel in list){
        [AppFunctions LOAD_IMAGE_ASYNC:hotel.imagemHotel completion:^(UIImage *image) {
            [listImages setObject:image forKey:hotel.codigoHotel];
            [tableViewData reloadData];
        }];
    }
}

- (void)viewDidLoad
{
    [self initScreenVariables];
    [self initListHotel];
    [self initFilterView];
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setSeparatorColor:[UIColor clearColor]];
    [AppFunctions CONFIGURE_SEARCH_BAR:self->searchBarData
                              delegate:self
                                  done:@selector(keyboardDone:)
                                cancel:@selector(keyboardClear:)];
    [searchBarData setImage:[UIImage imageNamed:@"filterIconS"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
    [searchBarData setImage:[UIImage imageNamed:@"filterIcon"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateHighlighted];
    [super viewDidLoad];
}

#pragma mark - Numeric keyboard Clear
- (IBAction)keyboardClear:(UIBarButtonItem *)sender
{
    [txtViewSelected setText:@""];
    [self controllSearchData];
}

#pragma mark - Numeric keyboard Done
- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    if ([self->searchBarData.text isEqualToString:@""])
        [self->searchBarData setText:@"Pesquisar"];
    [txtViewSelected resignFirstResponder];
}

#pragma mark -configNavBar
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

- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [super viewWillAppear:animated];
    [self connectionSearchHotel];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [ct cancel];
    ct = NULL;
    
    [super viewWillDisappear:animated];
}

#pragma mark -tableViewData
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    lblNumberHotel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[listHoteisSearch count]];
    return [listHoteisSearch count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    hotelPotaListResultCell *cell = (hotelPotaListResultCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                                                               forIndexPath:indexPath];
    potaHoteisData *tmp = [listHoteisSearch objectAtIndex:[indexPath row]];
    [cell.lblNameHotel setText:tmp.nomeHotel];
    NSString *lv = [[NSString stringWithFormat:@"star%@",tmp.estrelasHotel] stringByReplacingOccurrencesOfString:@"."
                                                                                                      withString:@""];
    [cell.imageStarLv setImage:[UIImage imageNamed:lv]];
    
    [cell.lblMoney setText:[NSString stringWithFormat:@"%@ %.2f",tmp.moeda, ([tmp.precoTotal floatValue]/[tmp.qtdNoites intValue])]];
    [cell.lblNameCity setText:lblCity.text];
    
    if ([listImages objectForKey:tmp.codigoHotel])
        [cell.imageHotel setImage:[listImages objectForKey:tmp.codigoHotel]];
    else
        [cell.imageHotel setImage:[UIImage imageNamed:@"img"]];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self GO_NEXT_SCREEN:indexPath];
}

#pragma mark -searchBarConfigure
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchSelect = YES;
    
    for (UIView *searchSubview in searchBarData.subviews)
        for (UIView *SubsearchSubview in searchSubview.subviews)
            if ([SubsearchSubview isKindOfClass:[UITextField class]]){
                txtViewSelected = (UITextField *)SubsearchSubview;
            }
    if ([txtViewSelected.text isEqualToString:@"Pesquisar"])
        [self->searchBarData setText:@""];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar
{
    searchSelect = NO;
    [self->searchBarData resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self->listHoteisSearch = self->listHoteis;
    [self->tableViewData reloadData];
    if ([self->searchBarData.text isEqualToString:@""]) {
        [self->searchBarData setText:@"Pesquisar"];
    }
    searchSelect = NO;
    [self->searchBarData resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self controllSearchData];
}



#pragma mark -filter
- (IBAction)btnOptionFilters:(id)sender
{
    if ([self->searchBarData.text isEqualToString:@""])
        [self->searchBarData setText:@"Pesquisar"];
    [self->searchBarData resignFirstResponder];
    [self appearFilterView];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self finishFilterView];
}

- (void)finishFilterView
{
    [self->filterView close];
    self->listHoteis       = [self applyFilter:wsFilter ascending:wsFilterUp];
    self->listHoteisSearch = [self->listHoteis mutableCopy];
    [self->tableViewData reloadData];
}

- (NSMutableArray *)applyFilter:(NSString *)type ascending:(BOOL)ascending
{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:type
                                                 ascending:ascending];
    NSMutableArray *sortDescriptors = [NSMutableArray arrayWithObject:sortDescriptor];
    
    NSArray *sortedArray = [listHoteis sortedArrayUsingDescriptors:sortDescriptors];
    
    return [sortedArray mutableCopy];
}

- (void)controllSearchData
{
    NSString *searchText = searchBarData.text;
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    
    if ( [searchText length] == 0 ) {
        self->listHoteis = [self applyFilter:wsFilter ascending:wsFilterUp];
        self->listHoteisSearch = [self->listHoteis mutableCopy];
    }else {
        self->listHoteis = [self applyFilter:wsFilter ascending:wsFilterUp];
        self->listHoteisSearch = [self->listHoteis mutableCopy];
        if (searchSelect || (![searchText isEqualToString:@""] && ![searchText isEqualToString:@"Busca"]))
        {
            for (potaHoteisData *data in self->listHoteisSearch)
                if ([[data.nomeHotel lowercaseString] rangeOfString:[searchText lowercaseString]].location != NSNotFound)
                    [tmp addObject:data];
            self->listHoteisSearch = tmp;
        }
    }
    [self->tableViewData reloadData];
}
#pragma mark -connection controll
- (void)connectionSearchHotel
{
    wsLinkHotel = [NSString stringWithFormat:@"%@/ws.asmx/xmlBuscaHotel?codigoSite=%@&tokenTos=%@&sequenciaAtual=%@",
                   wsLink, wsCodSite, wsToken, wsCounter];
    [self initConnection:wsLinkHotel];
}

- (void)initConnection:(NSString *)link
{
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : HOTEL_POTA_LIST_RESULT_CONNECTION_START,
                                       APP_CONNECTION_TAG_WAIT 	 : HOTEL_POTA_LIST_RESULT_CONNECTION_WAIT,
                                       APP_CONNECTION_TAG_RECIVE : HOTEL_POTA_LIST_RESULT_CONNECTION_RECIVE,
                                       APP_CONNECTION_TAG_FINISH : HOTEL_POTA_LIST_RESULT_CONNECTION_FINISH,
                                       APP_CONNECTION_TAG_ERROR  : HOTEL_POTA_LIST_RESULT_CONNECTION_ERROR };
    
    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:labelConnections showView:NO block:^(NSData *result) {
        if (result == nil) {
            [self connectionSearchHotel];
        } else {
            ctReceivedData = [[NSMutableData alloc]initWithData:result];
            [self initConnectionData:@"detalhes" subType:@"detalhes"];
            [self initConnectionDataHoteis:@"hotel"];
            
            if([wsFinal isEqualToString:@"false"])
            {
                if (![wsCounter isEqualToString:wsCounterNew])
                {
                    wsCounter = wsCounterNew;
                    if ([listHoteisNew count] > 0)
                    {
                        NSMutableArray *newHotel = [NSMutableArray new];
                        for (NSDictionary *tmp in listHoteisNew){
                            [newHotel addObject:[[potaHoteisData alloc]initHoteis:tmp]];
                        }
                        newHotel = [self cleanHoteis:newHotel];
                        
                        NSMutableArray *newHotelFinal = [NSMutableArray new];
                        for (potaHoteisData *objectA in newHotel){
                            BOOL go = NO;
                            for (potaHoteisData *objectB in listHoteis){
                                if ([objectB.codigoHotel isEqualToString:objectA.codigoHotel]){
                                    go = NO;
                                    break;
                                }else
                                    go = YES;
                            }
                            if (go)
                                [newHotelFinal addObject:objectA];
                        }
                        
                        [listHoteis addObjectsFromArray:newHotelFinal];
                        listHoteisSearch = [listHoteis mutableCopy];
                        [self loadImages:newHotelFinal];
                        [self controllSearchData];
                    }
                }
                [self connectionSearchHotel];
            }else {
                [LoadBar stopAnimating];
            }
        }
    }];
    self->listHoteis       = [self applyFilter:wsFilter ascending:wsFilterUp];
    self->listHoteisSearch = [self->listHoteis mutableCopy];
    [self->tableViewData reloadData];
}

- (void)initConnectionData:(NSString *)type subType:(NSString *)subType
{
    NSDictionary *reciveToken = (NSDictionary *)[[AzParser alloc] xmlDictionary:ctReceivedData tagNode:type];
    for (NSDictionary *tmp in [reciveToken objectForKey:subType])
    {
        if ([tmp objectForKey:@"Token"]){
            wsToken = [tmp objectForKey:@"Token"];
            break;
        }if ([tmp objectForKey:@"sequenciaAnterior"])
            wsCounter = [tmp objectForKey:@"sequenciaAnterior"];
        if ([tmp objectForKey:@"sequenciaAtual"])
            wsCounterNew = [tmp objectForKey:@"sequenciaAtual"];
        if ([tmp objectForKey:@"Finalizado"])
            wsFinal = [tmp objectForKey:@"Finalizado"];
        else if ([tmp objectForKey:@"finalizado"])
            wsFinal = [tmp objectForKey:@"finalizado"];
    }
}

- (void)initConnectionDataHoteis:(NSString *)type
{
    listHoteisNew = [NSMutableArray new];
    NSDictionary *reciveToken = (NSDictionary *)[[AzParser alloc] xmlDictionary:ctReceivedData tagNode:type];
    for (NSDictionary *tmp in [reciveToken objectForKey:type])
    {
        [listHoteisNew addObject:tmp];
    }
}

- (bool)isNumeric:(NSString *)checkText
{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [numberFormatter setNumberStyle:NSNumberFormatterScientificStyle];
    NSNumber* number = [numberFormatter numberFromString:checkText];
    if (number != nil)
        return true;
    return false;
}

#pragma mark -map functions
- (IBAction)btnMap:(id)sender
{
    NSMutableArray *listPins = [NSMutableArray new];
    for (potaHoteisData *hotel in listHoteisSearch) {
        CLLocationCoordinate2D coords = CLLocationCoordinate2DMake([hotel.latitudeHotel floatValue],
                                                                   [hotel.longitudeHotel floatValue]);
        
        if ([self isNumeric:hotel.latitudeHotel] && [self isNumeric:hotel.longitudeHotel])
        {
            if ([hotel.latitudeHotel intValue] != 0 && [hotel.longitudeHotel intValue] != 0)
            {
                NSDictionary *address = @{(NSString *)kABPersonAddressStreetKey: hotel.enderecoHotel,
                                          (NSString *)kABPersonAddressCityKey: hotel.nomeHotel,
                                          (NSString *)kABPersonAddressStateKey: hotel.descricaoHotel,
                                          (NSString *)kABPersonAddressZIPKey: lblCity.text,
                                          (NSString *)kABPersonAddressCountryCodeKey: hotel.telefoneHotel,
                                          };
                MKPlacemark *place = [[MKPlacemark alloc]
                                      initWithCoordinate:coords addressDictionary:address];
                MKMapItem *mapItem = [[MKMapItem alloc]
                                      initWithPlacemark:place];
                [mapItem setName:hotel.nomeHotel];
                [listPins addObject:mapItem];
            }
        }
    }
    [MKMapItem openMapsWithItems:listPins launchOptions:nil];
}

#pragma mark -sendDataNextScree
- (void)GO_NEXT_SCREEN:(NSIndexPath *)indexPath
{
    potaHoteisData *hotel = [listHoteisSearch objectAtIndex:[indexPath row]];
    
    NSMutableDictionary *infoHotel = [@{@"codigoCidadeFornecedor" : hotel.codigoCidadeFornecedor,
                                        @"codigoHotel"            : hotel.codigoHotel,
                                        @"codigoHotelFornecedor"  : hotel.codigoHotelFornecedor,
                                        @"codigoPlano"            : hotel.codigoPlano,
                                        @"dataCheckin"            : hotel.dataCheckin,
                                        @"dataCheckout"           : hotel.dataCheckout,
                                        @"descricaoHotel"         : hotel.descricaoHotel,
                                        @"enderecoHotel"          : hotel.enderecoHotel,
                                        @"faxHotel"               : hotel.faxHotel,
                                        @"idProvedor"             : hotel.idProvedor,
                                        @"imagemHotel"            : hotel.imagemHotel,
                                        @"indRecomendado"         : hotel.indRecomendado,
                                        @"latitudeHotel"          : hotel.latitudeHotel,
                                        @"localizacoes"           : hotel.localizacoes,
                                        @"logotipoFornecedor"     : hotel.logotipoFornecedor,
                                        @"longitudeHotel"         : hotel.longitudeHotel,
                                        @"nomeHotel"              : hotel.nomeHotel,
                                        @"nomeSeguradora"         : hotel.nomeSeguradora,
                                        @"qtdNoites"              : hotel.qtdNoites,
                                        @"seqPesquisa"            : hotel.seqPesquisa,
                                        @"streetViewHotel"        : hotel.streetViewHotel,
                                        @"taxasInclusa"           : hotel.taxasInclusa,
                                        @"telefoneHotel"          : hotel.telefoneHotel,
                                        @"tokenFornecedor"        : hotel.tokenFornecedor,
                                        @"urlMapaHotel"           : hotel.urlMapaHotel,
                                        @"urlSiteHotel"           : hotel.urlSiteHotel,
                                        @"zipCodeHotel"           : hotel.zipCodeHotel,
                                        @"precoTotal"             : hotel.precoTotal,
                                        @"moeda"                  : hotel.moeda,
                                        @"estrelasHotel"          : hotel.estrelasHotel
                                        }mutableCopy];
    
    [InfoPurchase setObject:InfoToken forKey:HOTEL_LINK_WS_INFO];
    [InfoPurchase setObject:infoHotel forKey:HOTEL_INFO];
    
    [AppFunctions CLEAR_INFORMATION];
    [AppFunctions SAVE_INFORMATION:InfoPurchase
                               tag:PURCHASE];
    
    [self performSegueWithIdentifier:STORY_BOARD_HOTEL_INFO sender:self];

}

@end
