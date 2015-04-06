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
    dataUser = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_TYPE];
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
                                     title:nil
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
    menuOption = @[@"Pacotes Turísticos",
                   @"Hotéis",
                   @"Assistência em Viagem",
                   @"Orçamento Personalizado",
                   @"Locação de Veiculos",
                   @"Passagens Aéreas"
                   ];
    if ([[dataUser objectForKey:TAG_USER_TYPE_BOOL] boolValue])
        [otlBtnMenu setTitle:@"Meu perfil" forState:UIControlStateNormal];
    
    UIViewController *backScreen = [AppFunctions BACK_SCREEN:self number:1];
    if (![backScreen.restorationIdentifier isEqualToString:@"a2AppMenu"] && backScreen.restorationIdentifier != nil ) {
        [otlBtnMenu setBackgroundImage:[UIImage imageNamed:@"btnMenuPerfilBack.png"] forState:UIControlStateNormal];
    }
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    menuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell" forIndexPath:indexPath];
    [cell.image setImage:[UIImage imageNamed:[NSString stringWithFormat:@"menu0%d", (int)[indexPath row] + 1]]];
    [cell.lbl   setText:[menuOption objectAtIndex:[indexPath row]]];
    [cell setBackgroundColor:[UIColor clearColor]];
    [AppFunctions TABLE_CELL_NO_TOUCH_DELAY:cell];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row] + 1) {
        case 1:
            [AppFunctions GO_TO_SCREEN:self destiny:SEGUE_A2_TO_P0];
            break;
        case 2:
            [self performSegueWithIdentifier:STORY_BOARD_MENU_HOTEL sender:self];
            break;
        case 3:
            [AppFunctions GO_TO_SCREEN:self destiny:SEGUE_A2_TO_T0];
            break;
        case 4:
            [AppFunctions GO_TO_SCREEN:self destiny:SEGUE_A2_TO_A3];
            break;
        case 5:
            [AppFunctions GO_TO_SCREEN:self destiny:@"A2_To_CR0"];
            break;
        case 6:
            [AppFunctions GO_TO_SCREEN:self destiny:@"A2_To_AE0"];
            break;
        case 7:
            //            [self performSegueWithIdentifier:STORY_BOARD_MENU_INGRESSOS sender:self];
            break;
        case 8:
//            [self performSegueWithIdentifier:@"PickerTest" sender:self];
            break;
        default:
            break;
    }
}

- (IBAction)btnMeuAgente:(id)sender
{
    if ([[dataUser objectForKey:TAG_USER_TYPE_BOOL] boolValue])
        [AppFunctions GO_TO_SCREEN:self destiny:SEGUE_A2_TO_C1];
    else
        [AppFunctions GO_TO_SCREEN:self destiny:SEGUE_A2_TO_B2];
}

@end
