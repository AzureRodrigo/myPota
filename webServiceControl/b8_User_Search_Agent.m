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
    [self nextScreen];
}

- (void)nextScreen
{
    NSLog(@"%@",SelectVendedor);
//    [self performSegueWithIdentifier:STORY_BOARD_SELLER_PERFIL sender:self];
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
        for (City *city in self->listVendedoresSearch)
            if ([[city.nome lowercaseString] rangeOfString:[text lowercaseString]].location != NSNotFound)
                [tmp addObject:city];
        self->listVendedoresSearch = tmp;
    }
    [self->tableViewData reloadData];
}
- (void)scrollTap:(UIGestureRecognizer*)gestureRecognizer
{
    [self.view endEditing:YES];
}

#pragma mark -getStatesData
- (NSMutableDictionary *)getInfoData
{
    return [self->SelectVendedor.data mutableCopy];
}

@end
