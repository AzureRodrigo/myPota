//
//  a2_App_Menu.m
//  myPota
//
//  Created by Rodrigo Pimentel on 08/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "a2_App_Menu.h"

@implementation a2_App_Menu

- (void)initSellerData
{
    listSellInfo = [AppFunctions PLIST_LOAD:PLIST_SELLER_NAME];
    if ([[listSellInfo objectForKey:@"Chosen"] boolValue])
        [otlMeuAgente setImage:[UIImage imageNamed:@"btnAgente04"]
                      forState:UIControlStateNormal];
}

- (void)viewDidLoad
{
    [self initSellerData];
    [super viewDidLoad];
}

#pragma mark -configNavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PERFIL
                                     title:@""
                                superTitle:@""
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_CLEAR
                                buttonBack:nil
                             openSplitMenu:@selector(menuOpen:)
                                backButton:NO];
}

- (IBAction)menuOpen:(id)sender
{
    [AppMenuView openMenu:self
                   sender:sender];
}

- (void)configTableView
{
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setSeparatorColor:[UIColor clearColor]];
    [tableViewData setDelaysContentTouches:NO];
}

- (void)resetPurchase
{
    NSMutableDictionary *purchase = [AppFunctions PLIST_PATH:PLIST_NAME_CADASTRE type:@"plist"];
    [purchase writeToFile:[AppFunctions PLIST_SAVE:PLIST_NAME_CADASTRE] atomically:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [self configTableView];
    [tableViewData reloadData];
    [super viewWillAppear:animated];
}

#pragma mark -tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    menuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell" forIndexPath:indexPath];
    [cell.image setImage:[UIImage imageNamed:[NSString stringWithFormat:@"menu0%d", (int)[indexPath row] + 1]]];
    [AppFunctions TABLE_CELL_NO_TOUCH_DELAY:cell];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row] + 1) {
        case 1:
            [self performSegueWithIdentifier:STORY_BOARD_MENU_PACOTES sender:self];
            
            break;
        case 2:
            [self performSegueWithIdentifier:STORY_BOARD_MENU_ASSISTENCIA sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:STORY_BOARD_MENU_HOTEL sender:self];
            break;
        case 4:
            //            [self performSegueWithIdentifier:@"teste" sender:self];
            break;
        case 5:
            //            [self performSegueWithIdentifier:@"gigateste" sender:self];
            break;
        case 6:
            //            [self performSegueWithIdentifier:STORY_BOARD_MENU_OPCIONAIS sender:self];
            break;
        case 7:
            //            [self performSegueWithIdentifier:STORY_BOARD_MENU_INGRESSOS sender:self];
            break;
        case 8:
                [self performSegueWithIdentifier:@"PickerTest" sender:self];
            break;
        default:
            break;
    }
}

- (IBAction)btnMeuAgente:(id)sender
{
    if ([[listSellInfo objectForKey:@"Chosen"] boolValue])
    {
        if ([[listSellInfo objectForKey:USER_TYPE] isEqualToString:USER_SELLER])
            [AppFunctions GO_TO_SCREEN:self destiny:STORY_BOARD_MENU_AGENTE_PERFIL];
        else
            [AppFunctions GO_TO_SCREEN:self destiny:STORY_BOARD_MENU_PERFIL];
    }else
        [AppFunctions GO_TO_SCREEN:self destiny:STORY_BOARD_MENU_CADASTRO];
}

@end
