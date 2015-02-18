//
//  voucherListPota.m
//  myPota
//
//  Created by Rodrigo Pimentel on 21/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "v1_Voucher_List.h"

@implementation v1_Voucher_List

#pragma mark -initData
- (void)initTables
{
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorColor: [UIColor clearColor]];
    [searchBar setAutocorrectionType:UITextAutocorrectionTypeNo];
}

- (void)initValues
{
    NSMutableDictionary *info = [AppFunctions PLIST_LOAD:PLIST_PURCHASES];
    listPurchase = [info objectForKey:@"vouchers"];
    if (listPurchase == nil)
        listPurchase = [AppFunctions PLIST_ARRAY_PATH:PLIST_PURCHASES type:@"plist"];
    
    listPurchaseSearch = [listPurchase mutableCopy];
}

- (void)viewDidLoad
{
    [self initValues];
    [self initTables];
    [AppFunctions CONFIGURE_SEARCH_BAR:searchBar
                              delegate:self
                                  done:@selector(keyboardDone:)
                                cancel:@selector(keyboardClear:)];
    [super viewDidLoad];
}

#pragma mark - Numeric keyboard Clear
- (IBAction)keyboardClear:(UIBarButtonItem *)sender
{
    [self->searchBar setText:@""];
    [self controllSearchData];
}

- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    if ([self->searchBar.text isEqualToString:@""])
        [self->searchBar setText:@"Pesquisar"];
    [self controllSearchData];
    [txtViewSelected resignFirstResponder];
}

- (void)controllSearchData
{
    [self changeContent:searchBar.text];
}

#pragma mark -configNavBar
- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [super viewWillAppear:animated];
}

- (void)configNavBar
{
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:@"Minhas Reservas"
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

- (IBAction)menuOpen:(id)sender
{
    [AppMenuView openMenu:self
                   sender:sender];
}

- (IBAction)btnBackScreen:(id)sender
{
    [AppFunctions POP_SCREEN:self
                  identifier:STORYBOARD_ID_A2
                    animated:YES];
}

#pragma mark -tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listPurchaseSearch count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    voucherListPotaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"voucherList"
                                                                forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    NSDictionary *info = [listPurchaseSearch objectAtIndex:[indexPath row]];
    NSString     *type = [info objectForKey:PURCHASE_TYPE];
    NSDictionary *infoProduct = [info objectForKey:PURCHASE_INFO_PRODUCT_RESERVE];
    
    if ([type isEqualToString:PURCHASE_TYPE_TRAVEL])
        type = @"Assistência em Viagem";
    else if ([type isEqualToString:PURCHASE_TYPE_HOTEL])
        type = @"Hotél";
    else if ([type isEqualToString:PURCHASE_TYPE_PACKGE])
        type = @"Pacote Turístico";
    
    [cell startCell:@{ PURCHASE_TYPE                 : type,
                       PURCHASE_INFO_VOLCHER         : [info objectForKey:PURCHASE_INFO_VOLCHER],
                       TAG_BUY_PURCHASE_DATA_START   : [infoProduct objectForKey:TAG_BUY_PURCHASE_DATA_START],
                       TAG_BUY_PURCHASE_CODE_RESERVA : [infoProduct objectForKey:TAG_BUY_PURCHASE_CODE_RESERVA],
                       TAG_BUY_PURCHASE_VALOR        : [infoProduct objectForKey:TAG_BUY_PURCHASE_VALOR]
                       }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [AppFunctions CLEAR_INFORMATION];
    [AppFunctions SAVE_INFORMATION:[listPurchaseSearch objectAtIndex:[indexPath row]]
                               tag:PURCHASE];
    
    [AppFunctions PUSH_SCREEN:self identifier:@"volcherPota"  animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [searchBar resignFirstResponder];
}

#pragma mark -searchBarConfigure
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)_searchBar
{
    if ([searchBar.text isEqualToString:@"Pesquisar"])
        [searchBar setText:@""];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)_SearchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)_searchBar
{
    listPurchaseSearch = listPurchase;
    [self->tableView reloadData];
    [searchBar setText:@"Pesquisar"];
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self changeContent:searchText];
}

- (void)changeContent:(NSString *)searchText
{
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    if ( [searchText length] == 0 ) {
        listPurchaseSearch = listPurchase;
    }else {
        listPurchaseSearch = listPurchase;
        for (NSMutableDictionary *info in listPurchaseSearch)
            if ([[[[info objectForKey:@"ReservaProduto"]objectForKey:@"CodReservaPedido"]lowercaseString] rangeOfString:[searchText lowercaseString]].location != NSNotFound ||
                [[[info objectForKey:PURCHASE_INFO_VOLCHER]lowercaseString] rangeOfString:[searchText lowercaseString]].location != NSNotFound)
                [tmp addObject:info];
        
        listPurchaseSearch = tmp;
    }
    [tableView reloadData];
}

@end
