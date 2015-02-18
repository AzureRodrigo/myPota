//
//  searchStateData.m
//  myPota
//
//  Created by Rodrigo Pimentel on 08/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "b6_User_Search_Place.h"

@implementation b6_User_Search_Place

#pragma mark - screenConfigure
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark -initData
- (void)initTables
{
    [self->tableViewData setDataSource:self];
    [self->tableViewData setDelegate:self];
    [self->tableViewData setBackgroundColor:[UIColor clearColor]];
    [self->tableViewData setSeparatorColor: [UIColor clearColor]];
    [self->searchBarData setDelegate:self];
    [self->searchBarData setAutocorrectionType:UITextAutocorrectionTypeNo];
}

- (void)initValues
{
    backScreen              = (b5_User_Search_Data *)[AppFunctions BACK_SCREEN:self number:1];
    stateSelect             = [backScreen getStateSelect];
    self->listData          = [backScreen getStateData];
    self->listDataSearch    = self->listData;
}

- (void)viewDidLoad
{
    [self initValues];
    [self initTables];
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
    [self configNavBar];
    [super viewWillAppear:animated];
}

- (void)configNavBar
{
    [lblInfo setText:@"Selecione a Cidade"];
    if (stateSelect)
        [lblInfo setText:@"Selecione o Estado"];
    
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

#pragma mark -tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self->listDataSearch count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    searchStateCityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchStateDataCell" forIndexPath:indexPath];
    if (stateSelect)
        [cell.lblName setText:[self->listDataSearch objectAtIndex:[indexPath row]]];
    else{
        [cell.icon setImage:[UIImage imageNamed:@"iconCity.png"]];
        City *tmp = [self->listDataSearch objectAtIndex:[indexPath row]];
        [cell.lblName setText:tmp.nome];
    }
    UIView * selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    [selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:254.0/255.0 blue:189.0/255.0 alpha:70.0/255.0]];
    [cell setSelectedBackgroundView:selectedBackgroundView];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (stateSelect)
        [backScreen selectNewState];
    [backScreen setStateName:[self->listDataSearch objectAtIndex:[indexPath row]]];
    [self->searchBarData resignFirstResponder];
    [self->searchBarData setText:@"Pesquisar"];
    
    [self backScreen];
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
    self->listDataSearch = self->listData;
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
        self->listDataSearch = self->listData;
    }else {
        self->listDataSearch = self->listData;
        if (stateSelect){
            for (NSString *state in self->listDataSearch)
                if ([[state lowercaseString] rangeOfString:[text lowercaseString]].location != NSNotFound)
                    [tmp addObject:state];
        }else
            for (City *city in self->listDataSearch)
                if ([[city.nome lowercaseString] rangeOfString:[text lowercaseString]].location != NSNotFound)
                    [tmp addObject:city];
        self->listDataSearch = tmp;
    }
    [self->tableViewData reloadData];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [searchBarData resignFirstResponder];
}


#pragma mark -backScreen
- (void)backScreen
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
