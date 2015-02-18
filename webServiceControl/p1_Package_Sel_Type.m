//
//  packCircuits.m
//  myPota
//
//  Created by Rodrigo Pimentel on 27/10/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "p1_Package_Sel_Type.h"

@implementation p1_Package_Sel_Type

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"p1_Package_Sel_Type contem Warnings");
}

- (void)viewDidLoad {
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setSeparatorColor:[UIColor clearColor]];
    listData     = [[NSMutableDictionary alloc]initWithDictionary:[AppFunctions LOAD_INFORMATION:PACKAGE_INFO_DATA]];
    
    infoType     = [[listData objectForKey:PACKAGE_INFO_TYPE] copy];
    infoCircuits = [[listData objectForKey:PACKAGE_INFO_CIRCUIT] copy];
    listDataSearch = [infoCircuits mutableCopy];
    [self configHeader];
    
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setSeparatorColor:[UIColor clearColor]];
    
    [self loadImages:infoCircuits];
    [super viewDidLoad];
}

#pragma mark - configNavBar
- (void)configNavBar
{
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:@"Pacotes Disponíveis"
                                                               attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                            NSFontAttributeName: [UIFont fontWithName:FONT_NAME_BOLD size:18]}];
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_GENERIC
                                     title:title
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

#pragma mark - config Filter

- (IBAction)selectNameAZ:(id)sender
{
    wsFilter = @"NomProduto";
    wsFilterUp = YES;
    [self finishFilterView];
}

- (IBAction)selectNameZA:(id)sender
{
    wsFilter = @"NomProduto";
    wsFilterUp = NO;
    [self finishFilterView];
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
    
    
    [self paintButtonsFilterView];
    
    UIImageView *lineAZ = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, menu.frame.size.width * .95f, 1)];
    lineAZ.backgroundColor = [UIColor clearColor];
    lineAZ.image = [UIImage imageNamed:@"dot_line"];
    [menu addSubview:lineAZ];
    
    UIImageView *lineZA = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, menu.frame.size.width * .95f, 1)];
    lineZA.backgroundColor = [UIColor clearColor];
    lineZA.image = [UIImage imageNamed:@"dot_line"];
    [menu addSubview:lineZA];
    
    [menu addSubview:lineAZ];
    
    float space = .12f;
    float posX  = .5f;
    buttonNameAZ.center    = CGPointMake(menu.frame.size.width * posX, menu.frame.size.height * (.3f + space * 0));
    buttonNameZA.center    = CGPointMake(menu.frame.size.width * posX, menu.frame.size.height * (.3f + space * 1));
    
    
    lineAZ.center    = CGPointMake(menu.frame.size.width * posX, menu.frame.size.height * (.355f + space * 0));
    lineZA.center    = CGPointMake(menu.frame.size.width * posX, menu.frame.size.height * (.355f + space * 1));
    
    
    [menu addSubview:buttonNameAZ];
    [menu addSubview:buttonNameZA];
    
    return menu;
}

- (void)paintButtonsFilterView
{
    [buttonNameAZ    setTintColor:[UIColor grayColor]];
    [buttonNameZA    setTintColor:[UIColor grayColor]];
    
    if ([wsFilter isEqualToString:@"nomeHotel"])
    {
        if (wsFilterUp)
            [buttonNameAZ  setTintColor:[UIColor blackColor]];
        else
            [buttonNameZA  setTintColor:[UIColor blackColor]];
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

- (void)initFilterView
{
    self->filterView = [[CustomIOS7AlertView alloc] init];
    [self->filterView setContainerView:[self filterViewConfig]];
    [self->filterView setButtonTitles:nil];
    [self->filterView setDelegate:self];
    [self->filterView setUseMotionEffects:true];
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
    [AppFunctions CONFIGURE_SEARCH_BAR:self->searchBarData
                              delegate:self
                                  done:@selector(keyboardDone:)
                                cancel:@selector(keyboardClear:)];
    
    [searchBarData setImage:[UIImage imageNamed:@"filterIconS"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
    [searchBarData setImage:[UIImage imageNamed:@"filterIcon"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateHighlighted];
    
    [self initFilterView];
    [self selectNameAZ:nil];
}

- (IBAction)keyboardClear:(UIBarButtonItem *)sender
{
    [txtViewSelected setText:@""];
    [self controllSearchData];
}

- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    if ([self->searchBarData.text isEqualToString:@""])
        [self->searchBarData setText:@"Pesquisar"];
    [self controllSearchData];
    [txtViewSelected resignFirstResponder];
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
    self->listDataSearch = [self->infoCircuits mutableCopy];
    int Nmbcircuts = (int)[listDataSearch count];
    [lblCircuitNumbers setText:[NSString stringWithFormat:@"%d",Nmbcircuts]];
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
    if ( [text length] == 0 ) {
        self->listDataSearch = [self->infoCircuits mutableCopy];
    }else {
        self->listDataSearch = [self->infoCircuits mutableCopy];
        for (NSDictionary *city in self->listDataSearch){
            if ([[[city objectForKey:@"NomProduto" ] lowercaseString] rangeOfString:[text lowercaseString]].location != NSNotFound)
                [tmp addObject:city];
        }
        self->listDataSearch = tmp;
    }
    
    int Nmbcircuts = (int)[listDataSearch count];
    [lblCircuitNumbers setText:[NSString stringWithFormat:@"%d",Nmbcircuts]];
    [self->tableViewData reloadData];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [searchBarData resignFirstResponder];
}

#pragma mark - Filter Change
- (void)controllSearchData
{
    [self SearchData:searchBarData.text];
}

- (IBAction)btnFilter:(id)sender
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
    self->listDataSearch   = [self applyFilter:wsFilter ascending:wsFilterUp];
    [self->tableViewData reloadData];
}

- (NSMutableArray *)applyFilter:(NSString *)type ascending:(BOOL)ascending
{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:type
                                                 ascending:ascending];
    NSMutableArray *sortDescriptors = [NSMutableArray arrayWithObject:sortDescriptor];
    
    NSArray *sortedArray = [listDataSearch sortedArrayUsingDescriptors:sortDescriptors];
    
    return [sortedArray mutableCopy];
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
    }
    
}

#pragma mark - table view Data
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listDataSearch count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    p1_Package_Sel_Type_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    NSString *code        = [[listDataSearch objectAtIndex:[indexPath row]]objectForKey:TAG_PACK_CIRCUIT_COD_PRODUCT];
    NSString *name        = [[listDataSearch objectAtIndex:[indexPath row]]objectForKey:TAG_PACK_CIRCUIT_NAME_PRODUCT];
    NSString *days        = [[listDataSearch objectAtIndex:[indexPath row]]objectForKey:TAG_PACK_CIRCUIT_NUM_DAYS];
    NSString *price       = [[listDataSearch objectAtIndex:[indexPath row]]objectForKey:TAG_PACK_CIRCUIT_VALUE_VENDA];
    NSString *coin        = [[listDataSearch objectAtIndex:[indexPath row]]objectForKey:TAG_PACK_CIRCUIT_COIN];
    NSString *entrance    = [[listDataSearch objectAtIndex:[indexPath row]]objectForKey:TAG_PACK_CIRCUIT_VALUE_ENTRADA];
    NSString *parcels     = [[listDataSearch objectAtIndex:[indexPath row]]objectForKey:TAG_PACK_CIRCUIT_NUM_PARCELA];
    NSString *parcelValue = [[listDataSearch objectAtIndex:[indexPath row]]objectForKey:TAG_PACK_CIRCUIT_VALUE_PARCELA];
    
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
    
    [cell.lblName  setAdjustsFontSizeToFitWidth:YES];
    [cell.lblDays  setAdjustsFontSizeToFitWidth:YES];
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
    [self->searchBarData resignFirstResponder];
    [self searchInfo:(int)[indexPath row]];
}

- (void)searchInfo:(int)ID
{
    NSDictionary *data = @{
                           PACKAGE_INFO_TYPE     : infoType,
                           PACKAGE_INFO_CIRCUIT  : [listDataSearch objectAtIndex:ID]
                           };
    
    [AppFunctions CLEAR_INFORMATION];
    [AppFunctions SAVE_INFORMATION:data
                               tag:PACKAGE_INFO_DATA];
    [AppFunctions GO_TO_SCREEN:self destiny:SEGUE_P1_TO_P2];
}

@end
