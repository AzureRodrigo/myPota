//
//  voucherListPota.m
//  myPota
//
//  Created by Rodrigo Pimentel on 21/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "voucherListPota.h"

@implementation voucherListPota

#pragma mark -initData
- (void)initTables
{
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorColor: [UIColor clearColor]];
    [searchBar setAutocorrectionType:UITextAutocorrectionTypeNo];
}

- (void)initValues
{
    listPurchase = [AppFunctions PLIST_ARRAY_LOAD:PLIST_PURCHASES];
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
    [txtViewSelected setText:@""];
}

#pragma mark - Numeric keyboard Done
- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    [txtViewSelected resignFirstResponder];
}

#pragma mark -configNavBar
- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [super viewWillAppear:animated];
}

- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_VOLCHER
                                     title:@""
                                superTitle:@""
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

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    voucherListPotaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"voucherList"
                                                                forIndexPath:indexPath];
    
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

#pragma mark -searchBarConfigure
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)_searchBar
{
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
    [searchBar setText:@"Busca"];
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    if ( [searchText length] == 0 ) {
        listPurchaseSearch = listPurchase;
    }else {
        listPurchaseSearch = listPurchase;
        for (NSMutableDictionary *info in listPurchaseSearch)
            if ([[[info objectForKey:PURCHASE_INFO_VOLCHER]lowercaseString] rangeOfString:[searchText lowercaseString]].location != NSNotFound)
                [tmp addObject:info];
        
        listPurchaseSearch = tmp;
    }
    [tableView reloadData];
}

- (void)scrollTap:(UIGestureRecognizer*)gestureRecognizer
{
    [self.view endEditing:YES];
}

@end
