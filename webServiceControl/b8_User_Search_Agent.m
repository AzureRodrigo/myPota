//
//  b8_User_Search_Agent.m
//  myPota
//
//  Created by Rodrigo Pimentel on 09/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "b8_User_Search_Agent.h"

@implementation b8_User_Search_Agent

#pragma mark - screenConfigure
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)initData
{
    self->backScreen            = (b7_User_Search_Agency *)[AppFunctions BACK_SCREEN:self number:1];
    self->listVendedores        = [backScreen getAgenciaData].listVendedor;
    self->listVendedoresSearch  = self->listVendedores;
}

#pragma mark -loadImages
- (void)loadImages
{
    self->listImages = [NSMutableDictionary new];
    for (Vendedor *tmp in self->listVendedoresSearch)
        [self->listImages setValue:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[tmp.data objectForKey:@"fotoVendedor"]]]]
                            forKey:[tmp.data objectForKey:@"codigoVendedor"]];
}

- (void)initComponents
{
    [self->tableViewData setDataSource:self];
    [self->tableViewData setDelegate:self];
    [self->tableViewData setBackgroundColor:[UIColor clearColor]];
    [self->tableViewData setSeparatorColor: [UIColor clearColor]];
    [self->searchBarData setDelegate:self];
    [self->searchBarData setAutocorrectionType:UITextAutocorrectionTypeNo];
}

#pragma mark - startScreen
- (void)viewDidLoad
{
    [self initData];
    [self loadImages];
    [self initComponents];
    [AppFunctions CONFIGURE_SEARCH_BAR:self->searchBarData
                              delegate:self
                                  done:@selector(keyboardDone:)
                                cancel:@selector(keyboardClear:)];
    [super viewDidLoad];
}

#pragma mark - Numeric keyboard Clear
- (IBAction)keyboardClear:(UIBarButtonItem *)sender
{
    [txtViewSelected setText:@""];
    [self SearchData:txtViewSelected.text];
}

#pragma mark - Numeric keyboard Done
- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    if ([txtViewSelected.text isEqualToString:@""])
        [txtViewSelected setText:@"Pesquisar"];
    [txtViewSelected resignFirstResponder];
}

#pragma mark -configNavBar
- (void)viewWillAppear:(BOOL)animated
{
    [self reloadScreen];
    [self->tableViewData deselectRowAtIndexPath:[self->tableViewData indexPathForSelectedRow] animated:animated];
    [self configNavBar];
    [super viewWillAppear:animated];
}

- (void) configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PERFIL
                                     title:@""
                                superTitle:@""
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_BACK
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:nil
                                backButton:YES];
}

- (IBAction)btnBackScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)reloadScreen
{
    self->listVendedoresSearch = self->listVendedores;
    [self->tableViewData reloadData];
}

#pragma mark -tableConfigure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self->listVendedoresSearch count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    choiceVendedorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Vendedor *tmp = [listVendedoresSearch objectAtIndex:[indexPath row]];
    [cell.lblName  setText:[[tmp.data objectForKey:@"nomeVendedor"] uppercaseString]];
    
    if ([cell.lblName.text isEqualToString:@"Qualquer Agente"]) {
        //        lblName
        [cell.lblMTitle setText:@"Vendedor Virtual"];
        [cell.lblMTitle setTextColor:[UIColor colorWithRed:122.f/255.f green:140.f/255.f blue:160.f/255.f alpha:1]];
        [cell.lblMail setHidden:NO];
        [cell.lblMail setText:[[tmp.data objectForKey:@"emailVendedor"] lowercaseString]];
    }
    //    if (![self->listImages objectForKey:[tmp.data objectForKey:@"codigoVendedor"]])
    //        [cell.otlImage setImage:[UIImage imageNamed:@"imgPerfil"]];
    //    else
    //        [cell.otlImage setImage:[UIImage imageWithData:[self->listImages objectForKey:[tmp.data objectForKey:@"codigoVendedor"]]]];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

#pragma selectCell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self->searchBarData resignFirstResponder];
    [self->searchBarData setText:@"Busca"];
    self->SelectVendedor = [self->listVendedoresSearch objectAtIndex:[indexPath row]];
    [self connection];
}

- (void)connection
{
    NSString *link;
    NSString *wsComplement = [NSString stringWithFormat:WS_URL_SELLER_CODE, KEY_CODE_SITE, KEY_CODE_AGENCY, KEY_EMPTY,
                              KEY_ACCESS_KEY,[SelectVendedor.data objectForKey:TAG_B1_USER_SELLER_CODE],
                              KEY_EMPTY, KEY_TYPE_RETURN];
    
    link = [NSString stringWithFormat:WS_URL, WS_URL_SELLER, wsComplement];
    
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : CODE_POTA_LABEL_CONNECTION_START,
                                       APP_CONNECTION_TAG_WAIT 	 : CODE_POTA_LABEL_CONNECTION_WAIT,
                                       APP_CONNECTION_TAG_RECIVE : CODE_POTA_LABEL_CONNECTION_RECIVE,
                                       APP_CONNECTION_TAG_FINISH : CODE_POTA_LABEL_CONNECTION_FINISH,
                                       APP_CONNECTION_TAG_ERROR  : CODE_POTA_LABEL_CONNECTION_ERROR };
    
    [appConnection START_CONNECT:link timeForOu:15.f labelConnection:labelConnections showView:YES block:^(NSData *result) {
        if (result == nil)
            [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                              message:ERROR_1000_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
        else {
            NSDictionary *erro = [AzParser xmlDictionary:result tagNode:TAG_ERRO];
            BOOL          error = NO;
            
            for (NSDictionary *tmp in [erro objectForKey:TAG_ERRO])
                if ([tmp objectForKey:TAG_ERRO]) {
                    error = YES;
                    NSLog(@"%@",[tmp objectForKey:TAG_ERRO]);
                }
            if (error)
                [AppFunctions LOG_MESSAGE:ERROR_1001_TITLE
                                  message:ERROR_1001_MESSAGE
                                   cancel:ERROR_BUTTON_CANCEL];
            else {
                NSDictionary *allInfo = [AzParser xmlDictionary:result tagNode:TAG_SELLER];
                for (NSDictionary *tmp in [allInfo objectForKey:TAG_SELLER])
                    agenteInfo = [tmp mutableCopy];
                NSDictionary *idsWs = [AzParser xmlDictionary:result tagNode:@"idWsPorSite"];
                agenteInfoIdWs = [NSMutableArray new];
                for (NSDictionary *tmp in [idsWs objectForKey:@"idWsPorSite"]){
                    [agenteInfoIdWs addObject:tmp];
                }
                [self setSeller];
            }
        }
    }];
}

- (void)setSeller
{
    fetch = [AppFunctions DATA_BASE_ENTITY_GET:fetch
                                      delegate:self
                                        entity:TAG_USER_SELLER
                                          sort:TAG_USER_SELLER_NAME];
    
    NSManagedObject *dataBD = [AppFunctions DATA_BASE_ENTITY_ADD:fetch];
    
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_CITY] 			forKey:TAG_USER_SELLER_CITY];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_CODE] 			forKey:TAG_USER_SELLER_CODE];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_CODE_AGENCY] 	forKey:TAG_USER_SELLER_CODE_AGENCY];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_CODE_CITY] 	forKey:TAG_USER_SELLER_CODE_CITY];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_CODE_SITE] 	forKey:TAG_USER_SELLER_CODE_SITE];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_DDD] 			forKey:TAG_USER_SELLER_DDD];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_DDD_CELL]  	forKey:TAG_USER_SELLER_DDD_CELL];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_MAIL] 			forKey:TAG_USER_SELLER_MAIL];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_FACEBOOK] 		forKey:TAG_USER_SELLER_FACEBOOK];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_FONE]  		forKey:TAG_USER_SELLER_FONE];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_CELL]  		forKey:TAG_USER_SELLER_CELL];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_FOTO]  		forKey:TAG_USER_SELLER_FOTO];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_GTALK] 		forKey:TAG_USER_SELLER_GTALK];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_NAME] 			forKey:TAG_USER_SELLER_NAME];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_UF_NAME] 		forKey:TAG_USER_SELLER_UF_NAME];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_GENDER]  		forKey:TAG_USER_SELLER_GENDER];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_UF] 			forKey:TAG_USER_SELLER_UF];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_SKYPE] 		forKey:TAG_USER_SELLER_SKYPE];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_TWITTER] 		forKey:TAG_USER_SELLER_TWITTER];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_SELLER_WHATSAPP] 		forKey:TAG_USER_SELLER_WHATSAPP];
    [dataBD setValue:@"" forKey:TAG_USER_SELLER_YOUTUBE];
    
    if ([AppFunctions DATA_BASE_ENTITY_SAVE:fetch])
        [self setAgency];
    else
        [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                          message:ERROR_1000_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
    
}

- (void)setAgency
{
    fetch = nil;
    fetch = [AppFunctions DATA_BASE_ENTITY_GET:fetch
                                      delegate:self
                                        entity:TAG_USER_AGENCY
                                          sort:TAG_USER_AGENCY_NAME];
    NSManagedObject *dataBD = [AppFunctions DATA_BASE_ENTITY_ADD:fetch];
    
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_CELL]            forKey:TAG_USER_AGENCY_CELL];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_CEP]             forKey:TAG_USER_AGENCY_CEP];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_CODE]            forKey:TAG_USER_AGENCY_CODE];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_COMPLEMENT]      forKey:TAG_USER_AGENCY_COMPLEMENT];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_CONTACT]         forKey:TAG_USER_AGENCY_CONTACT];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_QUARTER]         forKey:TAG_USER_AGENCY_QUARTER];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_DDD]             forKey:TAG_USER_AGENCY_DDD];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_DDD_CELL]        forKey:TAG_USER_AGENCY_DDD_CELL];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_MAIL]            forKey:TAG_USER_AGENCY_MAIL];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_ADRESS]          forKey:TAG_USER_AGENCY_ADRESS];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_IDWS]            forKey:TAG_USER_AGENCY_IDWS];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_FONE]            forKey:TAG_USER_AGENCY_FONE];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_LATITUDE]        forKey:TAG_USER_AGENCY_LATITUDE];
    [dataBD setValue:agenteInfoIdWs                                               forKey:TAG_USER_AGENCY_LIST_ID_WS];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_LOGOTYPE]        forKey:TAG_USER_AGENCY_LOGOTYPE];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_LONGITUDE]       forKey:TAG_USER_AGENCY_LONGITUDE];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_NAME]            forKey:TAG_USER_AGENCY_NAME];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_NAME_FANTASY]    forKey:TAG_USER_AGENCY_NAME_FANTASY];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_NUMBER_ADRESS]   forKey:TAG_USER_AGENCY_NUMBER_ADRESS];
    [dataBD setValue:[agenteInfo objectForKey:TAG_B1_USER_AGENCY_URL]             forKey:TAG_USER_AGENCY_URL];
    
    if ([AppFunctions DATA_BASE_ENTITY_SAVE:fetch])
        [self nextScreen];
    else
        [AppFunctions LOG_MESSAGE:ERROR_1000_TITLE
                          message:ERROR_1000_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
}

- (void)nextScreen
{
    [AppFunctions GO_TO_SCREEN:self destiny:SEGUE_B8_TO_B2];
}

#pragma mark -searchBarConfigure
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
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
    [self->searchBarData resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self->listVendedoresSearch = self->listVendedores;
    [self->tableViewData reloadData];
    [self->searchBarData setText:@"Busca"];
    [self->searchBarData resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self SearchData:searchText];
}

- (void)SearchData:(NSString *)text
{
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    if ( [text length] == 0 )
        self->listVendedoresSearch = self->listVendedores;
    else {
        self->listVendedoresSearch = self->listVendedores;
        for (Vendedor *seller in self->listVendedoresSearch)
            if ([[[seller.data objectForKey:TAG_B8_USER_SELLER_NAME] lowercaseString] rangeOfString:[text lowercaseString]].location != NSNotFound)
                [tmp addObject:seller];
        self->listVendedoresSearch = tmp;
    }
    [self->tableViewData reloadData];
}
- (void)scrollTap:(UIGestureRecognizer*)gestureRecognizer
{
    [self.view endEditing:YES];
}

@end
