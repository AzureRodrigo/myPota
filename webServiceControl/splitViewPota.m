//
//  splitViewPota.m
//  myPota
//
//  Created by Rodrigo Pimentel on 19/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "splitViewPota.h"

@implementation splitViewPota

- (void)viewDidAppear:(BOOL)animated
{
    [self preparScreen];
    [super viewDidAppear:animated];
}

- (void)preparScreen
{
    [self.view snapshotViewAfterScreenUpdates:NO];
    //setBackgroud
    backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splitMenuBg"]];
    backgroundView.frame = self.view.bounds;
    [[self view] addSubview:backgroundView];
    //seTableView
    tableViewData = [[UITableView alloc]initWithFrame:self.view.bounds];
    [tableViewData setDelegate:self];
    [tableViewData setDataSource:self];
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setSeparatorColor:[UIColor clearColor]];
    [tableViewData setScrollEnabled:NO];
    [[self view] addSubview:tableViewData];
    //setListaOption
    listOptions = @[@{@"IMAGE"   : @"splitItemHome",
                      @"DESTINE" : STORYBOARD_ID_A2},
                    @{@"IMAGE"   : @"splitItemPurchase",
                      @"DESTINE" : @"voucherListPota"},
                    @{@"IMAGE"   : @"splitItemAgent",
                      @"DESTINE" : STORYBOARD_ID_B1},
                    @{@"IMAGE"   : @"splitItemMyData",
                      @"DESTINE" : STORYBOARD_ID_A1},
                    @{@"IMAGE"   : @"splitItemInfo",
                      @"DESTINE" : @"infoPota"}];
}

#pragma mark - Number of Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - Number of Lines
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listOptions count];
}

#pragma mark - Title Sections
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

#pragma mark - Title Sections Customize
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}

#pragma mark - Footer Sections Customize
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}

#pragma mark - Title Sections Heigth Header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - Title Sections Heigth Foter
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - Cell Size
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_SIZE;
}

#pragma mark - Cell Customize
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SplitMenuCell";
    splitViewCell *cell = (splitViewCell *)[tableViewData dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[splitViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    [cell.imgBg setImage:[UIImage imageNamed:[[listOptions objectAtIndex:[indexPath row]]objectForKey:@"IMAGE"]]];
    
    return cell;
}

#pragma mark - Table Cell Select
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self changePersonPota:[[listOptions objectAtIndex:[indexPath row]]objectForKey:@"DESTINE"]];
}

- (void)changePersonPota:(NSString *)identifier
{
    [[AppMenuView getMenuView].superView.slideNavigationViewController slideWithDirectionNoAnimation:MWFSlideDirectionNone];
    if ([identifier isEqualToString:STORYBOARD_ID_B1])
    {
        [AppFunctions DATA_BASE_ENTITY_REMOVE:TAG_USER_SELLER];
        [AppFunctions DATA_BASE_ENTITY_REMOVE:TAG_USER_AGENCY];
        [AppFunctions POP_SCREEN:[AppMenuView getMenuView].superView identifier:identifier animated:YES];
    } else if([identifier isEqualToString:STORYBOARD_ID_A1]) {
        [AppFunctions APP_LOGOFF];
        [AppFunctions PUSH_SCREEN:[AppMenuView getMenuView].superView identifier:identifier animated:YES];
    }else
        [AppFunctions PUSH_SCREEN:[AppMenuView getMenuView].superView identifier:identifier animated:YES];
    
}

@end
