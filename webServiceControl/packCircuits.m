//
//  packCircuits.m
//  myPota
//
//  Created by Rodrigo Pimentel on 27/10/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "packCircuits.h"

@interface packCircuits ()

@end

@implementation packCircuits

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"packCircuits contem Warnings");
}

- (void)viewDidLoad {
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setSeparatorColor:[UIColor clearColor]];
    listData     = [[NSMutableDictionary alloc]initWithDictionary:[AppFunctions LOAD_INFORMATION:PACKAGE_INFO_DATA]];
    
    infoType     = [[listData objectForKey:PACKAGE_INFO_TYPE] copy];
    infoCircuits = [[listData objectForKey:PACKAGE_INFO_CIRCUIT] copy];
    
    [self configHeader];
    
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setSeparatorColor:[UIColor clearColor]];
    
    [self loadImages:infoCircuits];
    [super viewDidLoad];
}

#pragma mark - configNavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PACKAGE
                                     title:@""
                                superTitle:@""
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

#pragma mark - configCabeçalho
- (void)configHeader
{
    [lblCircuitName       setText:[infoType objectForKey:TAG_PACK_SEO_TITLE]];
    [lblCircuitName       setAdjustsFontSizeToFitWidth:YES];
    [lblCircuitDescrition setText:[infoType objectForKey:TAG_PACK_SEO_DESCRIPTION]];
    [lblCircuitDescrition setAdjustsFontSizeToFitWidth:YES];
    int Nmbcircuts = (int)[infoCircuits count];
    [lblCircuitNumbers setText:[NSString stringWithFormat:@"%d",Nmbcircuts]];
    [lblCircuitNumbersLabel setText:@"roteiro"];
    if (Nmbcircuts > 1)
        [lblCircuitNumbersLabel setText:@"roteiros"];
    [loadCircuits stopAnimating];
    [loadCircuits setHidden:YES];
}

#pragma mark - configFilter
- (void)configFilter
{
    [AppFunctions CONFIGURE_SEARCH_BAR:self->seachBarData
                              delegate:self
                                  done:@selector(keyboardDone:)
                                cancel:@selector(keyboardClear:)];
    
    [seachBarData setImage:[UIImage imageNamed:@"filterIconS"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
    [seachBarData setImage:[UIImage imageNamed:@"filterIcon"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateHighlighted];
}

- (IBAction)keyboardClear:(UIBarButtonItem *)sender
{
    [txtViewSelected setText:@""];
    [self controllSearchData];
}

- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    if ([self->seachBarData.text isEqualToString:@""])
        [self->seachBarData setText:@"Pesquisar"];
    [txtViewSelected resignFirstResponder];
}

#pragma mark -searchBarConfigure
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchSelect = YES;
    for (UIView *searchSubview in seachBarData.subviews)
        for (UIView *SubsearchSubview in searchSubview.subviews)
            if ([SubsearchSubview isKindOfClass:[UITextField class]]){
                txtViewSelected = (UITextField *)SubsearchSubview;
            }
    if ([txtViewSelected.text isEqualToString:@"Pesquisar"])
        [self->seachBarData setText:@""];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar
{
    searchSelect = NO;
    [self->seachBarData resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    if ([self->seachBarData.text isEqualToString:@""]) {
        [self->seachBarData setText:@"Pesquisar"];
    }
    searchSelect = NO;
    [self->seachBarData resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self controllSearchData];
}

#pragma mark - Filter Change
- (void)controllSearchData
{
    
}

- (IBAction)btnFilter:(id)sender {
    
}

#pragma mark - willAppear
- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [self configFilter];
    [tableViewData reloadData];
    [super viewWillAppear:animated];
}

#pragma mark - Load Images
- (void)loadImages:(NSArray *)list
{
    listImages = [NSMutableDictionary new];
    
    for (NSDictionary *circuit in list)
    {
        NSString *link = [circuit objectForKey:TAG_PACK_CIRCUIT_IMAGE_PRODUTO];
        if (![link containsString:@"www"]){
            link = [NSString stringWithFormat:@"%@%@",@"http://www.schultz.com.br/arquivos/img/roteiro/",
                    [circuit objectForKey:TAG_PACK_CIRCUIT_IMAGE_PRODUTO]];
        }
        
//        [AppFunctions LOAD_IMAGE_ASYNC:link completion:^(UIImage *image) {
//            [listImages setObject:image forKey:[circuit objectForKey:TAG_PACK_CIRCUIT_COD_PRODUCT]];
//            [tableViewData reloadData];
//        }];
    }
    
}

#pragma mark - table view Data
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [infoCircuits count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    packCircuitsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    NSString *code  = [[infoCircuits objectAtIndex:[indexPath row]]objectForKey:TAG_PACK_CIRCUIT_COD_PRODUCT];
    NSString *name  = [[infoCircuits objectAtIndex:[indexPath row]]objectForKey:TAG_PACK_CIRCUIT_NAME_PRODUCT];
    NSString *days  = [[infoCircuits objectAtIndex:[indexPath row]]objectForKey:TAG_PACK_CIRCUIT_NUM_DAYS];
    NSString *price = [[infoCircuits objectAtIndex:[indexPath row]]objectForKey:TAG_PACK_CIRCUIT_VALUE_VENDA];
    NSString *coin  = [[infoCircuits objectAtIndex:[indexPath row]]objectForKey:TAG_PACK_CIRCUIT_COIN];
    NSString *entrance    = [[infoCircuits objectAtIndex:[indexPath row]]objectForKey:TAG_PACK_CIRCUIT_VALUE_ENTRADA];
    NSString *parcels     = [[infoCircuits objectAtIndex:[indexPath row]]objectForKey:TAG_PACK_CIRCUIT_NUM_PARCELA];
    NSString *parcelValue = [[infoCircuits objectAtIndex:[indexPath row]]objectForKey:TAG_PACK_CIRCUIT_VALUE_PARCELA];
    
    NSString *day   = @"Dias";
    if ([days integerValue] <= 1) day = @"Dia";
    price       = [NSString stringWithFormat:@"%.2f", [price floatValue]];
    entrance    = [NSString stringWithFormat:@"%.2f", [entrance floatValue]];
    parcelValue = [NSString stringWithFormat:@"%.2f", [parcelValue floatValue]];
    parcels     = [NSString stringWithFormat:@"%d", [parcels intValue]];
    
    if ([listImages objectForKey:code])
        [cell.imgView setImage:[listImages objectForKey:code]];
    else
        [cell.imgView setImage:[UIImage imageNamed:@"img"]];
    
    [cell.lblName  setText:name];
    [cell.lblName setAdjustsFontSizeToFitWidth:YES];
    [cell.lblDays  setText:[NSString stringWithFormat:@"%@ %@", days, day]];
    [cell.lblPrice setText:[NSString stringWithFormat:@"A partir de %@ %@ ou entrada de %@ %@ + %@ x de %@ %@ ",
                            coin, price, coin, entrance, parcels, coin, parcelValue]];
    
    [cell.lblPrice setAdjustsFontSizeToFitWidth:YES];
    

    NSString *sizeStart = @"A partir de ";
    NSString *sizeEnd   = [NSString stringWithFormat:@"%@ %@",coin, price];
    
    NSMutableAttributedString *notifyingStr = [[NSMutableAttributedString alloc] initWithString:cell.lblPrice.text];
    [notifyingStr beginEditing];
    [notifyingStr addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:FONT_NAME_BOLD size:16.0]
                         range:NSMakeRange([sizeStart length], [sizeEnd length])];
    [notifyingStr endEditing];

    [cell.lblPrice setAttributedText:notifyingStr];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self searchInfo:(int)[indexPath row]];
}

- (void)searchInfo:(int)ID
{
    
    NSDictionary *data = @{
                           PACKAGE_INFO_TYPE     : infoType,
                           PACKAGE_INFO_CIRCUIT  : [infoCircuits objectAtIndex:ID]
                           };
    
    [AppFunctions CLEAR_INFORMATION];
    [AppFunctions SAVE_INFORMATION:data
                               tag:PACKAGE_INFO_DATA];
    
    [AppFunctions GO_TO_SCREEN:self destiny:STORY_BOARD_PACK_CIRCUIT_INFO];
}

@end
