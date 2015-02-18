//
//  s0_Split_Menu.m
//  myPota
//
//  Created by Rodrigo Pimentel on 19/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "s0_Split_Menu.h"

@implementation s0_Split_Menu

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
    
    
    dataUser = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_TYPE];
    
    if ([[dataUser objectForKey:TAG_USER_TYPE_BOOL] boolValue])
    {
        if ([[AppMenuView getMenuView].superView.restorationIdentifier isEqualToString: STORYBOARD_ID_A2])
        {
            listOptions = @[@{@"IMAGE"   : @"splitItemPurchase",
                              @"DESTINE" : SEGUE_V0_TO_V1},
                            @{@"IMAGE"   : @"splitItemLogoff",
                              @"DESTINE" : STORYBOARD_ID_A1},
                            @{@"IMAGE"   : @"splitItemInfo",
                              @"DESTINE" : STORYBOARD_ID_D0}];
        } else {
            listOptions = @[@{@"IMAGE"   : @"splitItemHome",
                              @"DESTINE" : STORYBOARD_ID_A2},
                            @{@"IMAGE"   : @"splitItemPurchase",
                              @"DESTINE" : SEGUE_V0_TO_V1},
                            @{@"IMAGE"   : @"splitItemLogoff",
                              @"DESTINE" : STORYBOARD_ID_A1},
                            @{@"IMAGE"   : @"splitItemInfo",
                              @"DESTINE" : STORYBOARD_ID_D0}];
        }
    } else {
        if ([[AppMenuView getMenuView].superView.restorationIdentifier isEqualToString: STORYBOARD_ID_A2])
        {
            listOptions = @[
                            @{@"IMAGE"   : @"splitItemPurchase",
                              @"DESTINE" : SEGUE_V0_TO_V1},
                            @{@"IMAGE"   : @"splitItemMyData",
                              @"DESTINE" : STORYBOARD_ID_I0},
                            @{@"IMAGE"   : @"splitItemAgent",
                              @"DESTINE" : STORYBOARD_ID_B1},
                            @{@"IMAGE"   : @"splitItemLogoff",
                              @"DESTINE" : STORYBOARD_ID_A1},
                            @{@"IMAGE"   : @"splitItemInfo",
                              @"DESTINE" : STORYBOARD_ID_D0}];
        } else {
            listOptions = @[@{@"IMAGE"   : @"splitItemHome",
                              @"DESTINE" : STORYBOARD_ID_A2},
                            @{@"IMAGE"   : @"splitItemPurchase",
                              @"DESTINE" : SEGUE_V0_TO_V1},
                            @{@"IMAGE"   : @"splitItemMyData",
                              @"DESTINE" : STORYBOARD_ID_I0},
                            @{@"IMAGE"   : @"splitItemAgent",
                              @"DESTINE" : STORYBOARD_ID_B1},
                            @{@"IMAGE"   : @"splitItemLogoff",
                              @"DESTINE" : STORYBOARD_ID_A1},
                            @{@"IMAGE"   : @"splitItemInfo",
                              @"DESTINE" : STORYBOARD_ID_D0}];
        }
    }
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
    s0_Split_Menu_Cell *cell = (s0_Split_Menu_Cell *)[tableViewData dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[s0_Split_Menu_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    [cell.imgBg setImage:[UIImage imageNamed:[[listOptions objectAtIndex:[indexPath row]]objectForKey:@"IMAGE"]]];
    
    return cell;
}

#pragma mark - Table Cell Select
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self option:[[listOptions objectAtIndex:[indexPath row]]objectForKey:@"DESTINE"]];
}

- (void)option:(NSString *)identifier
{
    [[AppMenuView getMenuView].superView.slideNavigationViewController slideWithDirectionNoAnimation:MWFSlideDirectionNone];
    
    if ([identifier isEqualToString:STORYBOARD_ID_A1]) {
        [AppFunctions APP_LOGOFF:[AppMenuView getMenuView].superView identifier:identifier];
    } else if ([identifier isEqualToString:STORYBOARD_ID_B1]) {
        [AppFunctions APP_SELECT_SELLER];
        [AppFunctions PUSH_SCREEN:[AppMenuView getMenuView].superView identifier:identifier animated:YES];
    } else {
        [AppFunctions PUSH_SCREEN:[AppMenuView getMenuView].superView identifier:identifier animated:YES];
    }
}

@end
