//
//  choiceAgencia.m
//  myPota
//
//  Created by Rodrigo Pimentel on 09/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "b7_User_Search_Agency.h"

@implementation b7_User_Search_Agency

#pragma mark - screenConfigure
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)initData
{
    self->backScreen         = (b5_User_Search_Data *)[AppFunctions BACK_SCREEN:self number:1];
    self->listAgencias       = [backScreen getStatesData].listAgencias;
    self->listSearchAgencias = self->listAgencias;
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

- (void)viewDidLoad
{
    [self initData];
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
                                     title:nil
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
    self->listSearchAgencias = self->listAgencias;
    [self->tableViewData reloadData];
}

#pragma mark -tableConfigure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self->listSearchAgencias count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    choiceAgenciaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Agencias *tmp = [listSearchAgencias objectAtIndex:[indexPath row]];
    [cell.lblName setText:[[tmp.data objectForKey:TAG_B7_USER_AGENCY_NAME] uppercaseString]];
    [cell.lblMail setText:[NSString stringWithFormat:@"%@,%@",[[tmp.data objectForKey:@"bairroAgencia"] lowercaseString], [[tmp.data objectForKey:@"enderecoAgencia"] lowercaseString]]];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    [cell.lblName setAdjustsFontSizeToFitWidth:YES];
    [cell.lblMail setAdjustsFontSizeToFitWidth:YES];
    
    return cell;
}

#pragma selectCell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self->searchBarData resignFirstResponder];
    [self->searchBarData setText:@"Pesquisar"];
    self->SelectAgencia = [self->listSearchAgencias objectAtIndex:[indexPath row]];
    [self getWebServiceData:[self->SelectAgencia.data objectForKey:@"codigoAgencia"]];
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
    self->listSearchAgencias = self->listAgencias;
    [self->tableViewData reloadData];
    [self->searchBarData setText:@"Pesquisar"];
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
        self->listSearchAgencias = self->listAgencias;
    else {
        self->listSearchAgencias = self->listAgencias;
        for (Agencias *agency in self->listSearchAgencias)
            if ([[[agency.data objectForKey:TAG_B7_USER_AGENCY_NAME] lowercaseString] rangeOfString:[text lowercaseString]].location != NSNotFound)
                [tmp addObject:agency];
        self->listSearchAgencias = tmp;
    }
    [self->tableViewData reloadData];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [searchBarData resignFirstResponder];
}

#pragma mark -connection
-(void)getWebServiceData:(NSString *)ID
{
    [[backScreen getStatesData] resetListVendedor];
    NSString *wsComplement = [NSString stringWithFormat:WS_URL_AGENCY_SELLERS, KEY_CODE_SITE, ID, KEY_EMPTY,
                              KEY_ACCESS_KEY, KEY_EMPTY, KEY_EMPTY, KEY_TYPE_RETURN];
    NSString *link = [NSString stringWithFormat:WS_URL, WS_URL_SELLER, wsComplement];
    
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : CHOICE_AGENCIA_LABEL_CONNECTION_START,
                                       APP_CONNECTION_TAG_WAIT 	 : CHOICE_AGENCIA_LABEL_CONNECTION_WAIT,
                                       APP_CONNECTION_TAG_RECIVE : CHOICE_AGENCIA_LABEL_CONNECTION_RECIVE,
                                       APP_CONNECTION_TAG_FINISH : CHOICE_AGENCIA_LABEL_CONNECTION_FINISH,
                                       APP_CONNECTION_TAG_ERROR  : CHOICE_AGENCIA_LABEL_CONNECTION_ERROR };
    
    [appConnection START_CONNECT:link timeForOu:15.F labelConnection:labelConnections showView:YES block:^(NSData *result) {
        if (result == nil)
            [AppFunctions LOG_MESSAGE:ERROR_1003_TITLE
                              message:ERROR_1003_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
        else
        {
            NSDictionary *allCitys = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:TAG_SELLER];
            for (NSDictionary *tmp in [allCitys objectForKey:TAG_SELLER]){
                [[backScreen getStatesData] addVendedor:tmp];
            }
            [self nextScreen];
        }
    }];
}

#pragma mark -nextScreenFunction
- (void)nextScreen
{
    [self performSegueWithIdentifier:STORY_BOARD_AGENCY_SELLER sender:self];
}

#pragma mark -getStatesData
- (States *)getAgenciaData
{
    return [self->backScreen getStatesData];
}

- (Agencias *)getSelectAgencia
{
    return self->SelectAgencia;
}

@end
