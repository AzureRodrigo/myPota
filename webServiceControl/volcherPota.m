//
//  volcherPota.m
//  myPota
//
//  Created by Rodrigo Pimentel on 12/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "volcherPota.h"

@implementation volcherPota

#pragma mark -configNavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_VOLCHER
                                     title:nil
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
    [AppFunctions POP_SCREEN:self
                  identifier:@"voucherListPota"
                    animated:YES];
}

#pragma mark - didLoad
- (void)viewDidLoad
{
    [self initScreenData];
    [super viewDidLoad];
}

#pragma mark - willAppear
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [tableData reloadData];
    [self configNavBar];
}

#pragma mark - Init Screen Data
- (void)initScreenData
{
    [tableData setBackgroundColor:[UIColor clearColor]];
    [tableData setSeparatorColor:[UIColor clearColor]];
    purchaseData = [[NSMutableDictionary alloc]initWithDictionary:[AppFunctions LOAD_INFORMATION:PURCHASE]];
    purchaseType = [purchaseData objectForKey:PURCHASE_TYPE];
    purchaseTravellers = [purchaseData objectForKey:PURCHASE_TYPE_PERSON_DATA];
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL])
        [self setDataTravel];
}

- (void)setDataTravel
{
    purchaseInfo       = [[purchaseData objectForKey:PURCHASE_INFO_PRODUCT] mutableCopy];
    listPurchaseData   = [[purchaseInfo objectForKey:PURCHASE_DATA_TRAVEL_PLAN_SELECTED] mutableCopy];
    [listPurchaseData setValue:[purchaseInfo objectForKey:PURCHASE_DATA_TRAVEL_PAX]
                        forKey:PURCHASE_DATA_TRAVEL_PAX];
    [listPurchaseData setValue:[purchaseInfo objectForKey:PURCHASE_DATA_TRAVEL_DAYS]
                        forKey:PURCHASE_DATA_TRAVEL_DAYS];
    
    lblTitlePurchase = @"Custo da Assistência em Viagem";
    
    listInfoDataEnd = @[@{ INFO_TITLE  : @"Como proceder em caso de imprevisto e telefones de emergências",
                           INFO_SCREEN : @"none"},
                        @{ INFO_TITLE  : @"Ver todas as Coberturas",
                           INFO_SCREEN : @"goTo Coberturas"},
                        @{ INFO_TITLE  : @"Condições Gerais",
                           INFO_SCREEN : @"goTo Condições"}];
}

#pragma mark - Number of Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

#pragma mark - Number of Lines
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2)
        return [purchaseTravellers count]; //info travellers
    else if (section == 4)
        return [listInfoDataEnd count]; //info geral
    return 1;
}

#pragma mark - Title Sections
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

#pragma mark - Title Sections Customize
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

#pragma mark - Title Sections Heigth Header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

#pragma mark - Title Sections Heigth Foter
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

#pragma mark - Cell Size
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0)
        return 140;
    else if ([indexPath section] == 1)
        return 226;
    else if ([indexPath section] == 2)
        return 165;
    else if ([indexPath section] == 3)
        return 145;
    else if ([indexPath section] == 4)
        return 60;
    else if ([indexPath section] == 5)
        return 210;
    return 0;
}

#pragma mark - Cell Customize
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0)
        return [self configSection1:tableView index:indexPath];
    else if ([indexPath section] == 1)
        return [self configSection2:tableView index:indexPath];
    else if ([indexPath section] == 2)
        return [self configSection3:tableView index:indexPath];
    else if ([indexPath section] == 3)
        return [self configSection4:tableView index:indexPath];
    else if ([indexPath section] == 4)
        return [self configSection5:tableView index:indexPath];
    else
        return [self configSection6:tableView index:indexPath];
}

#pragma mark - define section 1
-(UITableViewCell *)configSection1:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    voucherPotaVoucherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"voucherCell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.tag = [indexPath row];
    
    [cell startInfo:[purchaseData objectForKey:PURCHASE_INFO_VOLCHER]
               code:[[purchaseData objectForKey:PURCHASE_INFO_PRODUCT_RESERVE]objectForKey:TAG_BUY_PURCHASE_CODE_RESERVA]];
    
    return cell;
}

#pragma mark - define section 2
-(UITableViewCell *)configSection2:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        voucherPotaPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"planCell" forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.tag = [indexPath row];
        
        [cell startInfo:[[[purchaseData objectForKey:PURCHASE_INFO_PRODUCT]objectForKey:PURCHASE_DATA_TRAVEL_PLAN_SELECTED]objectForKey:PURCHASE_DATA_TRAVEL_INFO_PLAN_NAME]
               ageLimit:[[[purchaseData objectForKey:PURCHASE_INFO_PRODUCT]objectForKey:PURCHASE_DATA_TRAVEL_PLAN_SELECTED]objectForKey:PURCHASE_DATA_TRAVEL_INFO_PLAN_MAX_AGE]
                destiny:[[purchaseData  objectForKey:PURCHASE_INFO_PRODUCT]objectForKey:PURCHASE_DATA_TRAVEL_DESTINY]
              dataStart:[[purchaseData  objectForKey:PURCHASE_INFO_PRODUCT]objectForKey:PURCHASE_DATA_TRAVEL_DATA_START]
                dataEnd:[[purchaseData  objectForKey:PURCHASE_INFO_PRODUCT]objectForKey:PURCHASE_DATA_TRAVEL_DATA_END]
             numberDays:[[purchaseData  objectForKey:PURCHASE_INFO_PRODUCT]objectForKey:PURCHASE_DATA_TRAVEL_DAYS]
       numberTravellers:[[purchaseData  objectForKey:PURCHASE_INFO_PRODUCT]objectForKey:PURCHASE_DATA_TRAVEL_PAX]];
        
        return cell;
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_HOTEL]) {
        return nil;
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
        return nil;
    }
    return nil;
}

#pragma mark - define section 3
-(UITableViewCell *)configSection3:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    voucherPotaTravellerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"travellerCell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.tag = [indexPath row];
    
    [cell startInfo:[NSString stringWithFormat:@"%ld", (long)[indexPath row] + 1]
               name:[NSString stringWithFormat:@"%@ %@",[[purchaseTravellers objectAtIndex:[indexPath row]] objectForKey:CADASTRO_PERSON_FIRST_NAME],[[purchaseTravellers objectAtIndex:[indexPath row]] objectForKey:CADASTRO_PERSON_SECOND_NAME]]
                age:[[purchaseTravellers objectAtIndex:[indexPath row]] objectForKey:CADASTRO_PERSON_AGE]
               mail:[[purchaseTravellers objectAtIndex:[indexPath row]] objectForKey:CADASTRO_PERSON_MAIL]
               fone:[[purchaseTravellers objectAtIndex:[indexPath row]] objectForKey:CADASTRO_PERSON_FONE]
                cpf:[[purchaseTravellers objectAtIndex:[indexPath row]] objectForKey:CADASTRO_PERSON_CPF]];
    
    return cell;
}

#pragma mark - define section 4
- (UITableViewCell *)configSection4:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        
        cadastreCell_TravelCustos *cell = [tableView dequeueReusableCellWithIdentifier:@"CellTravelCustos"
                                                                          forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell startCell:listPurchaseData title:@"Custo da Assistência em viagem"];
        
        return cell;
        
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_HOTEL]) {
        return nil;
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
        return nil;
    }
    return nil;
}

#pragma mark - define section 5
-(UITableViewCell *)configSection5:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        BuyInfoEnd *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyInfoEnd" forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.tag = [indexPath row];
        [cell startInfo:[[listInfoDataEnd objectAtIndex:[indexPath row]]objectForKey:INFO_TITLE]
                     id:(int)[indexPath row]];
        return cell;
    }
    return nil;
}

#pragma mark - define section 6
-(UITableViewCell *)configSection6:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    voucherPotaSellerData *cell = [tableView dequeueReusableCellWithIdentifier:@"sellerDataCell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    NSDictionary *agency  = [purchaseData objectForKey:PURCHASE_INFO_AGENCY];
    NSDictionary *seller  = [purchaseData objectForKey:PURCHASE_INFO_SELLER];
    NSDictionary *product = [purchaseData objectForKey:PURCHASE_INFO_PRODUCT_RESERVE];
    NSDateFormatter *formatDate = [[NSDateFormatter alloc] init];
    NSLocale        *locale     = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_Br"];
    [formatDate setLocale:locale];
    [formatDate setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSDate* dateOutput = [formatDate  dateFromString:[product objectForKey:TAG_BUY_PURCHASE_DATA_START]];
    [formatDate setDateFormat:@"dd/MM/yyyy"];
    NSString *dateBuy = [formatDate stringFromDate:dateOutput];
    
    [cell startCell:[agency objectForKey:@"logo"]
          imgSecure:@""
               name:[agency objectForKey:PURCHASE_DATA_TRAVEL_INFO_PLAN_NAME]
             street:[agency objectForKey:@"endereco"]
             adress:[NSString stringWithFormat:@"%@ - %@ - CEP %@",[agency objectForKey:@"bairro"], [agency objectForKey:@"cidade"], [agency objectForKey:@"cep"]]
               mail:[agency objectForKey:@"urlSite"]
             seller:[seller objectForKey:PURCHASE_DATA_TRAVEL_INFO_PLAN_NAME]
        reserveCode:[product objectForKey:TAG_BUY_PURCHASE_CODE_RESERVA]
       dataPurchase:dateBuy];
    
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
    }
    
    return cell;
}

#pragma mark - Table Cell Select
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        if ([indexPath row] == 0)
            NSLog(@"Como proceder");
        else if ([indexPath row] == 1)
            lblNextScreenType = CADASTRO_NEXT_SCREEN_COBERTURAS;
        else
            lblNextScreenType = CADASTRO_NEXT_SCREEN_CONDICOES;
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_HOTEL]) {
        
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
        
    }
    
    if ([[[listInfoDataEnd objectAtIndex:[indexPath row]]objectForKey:INFO_SCREEN] isEqualToString:@"none"]) {
        //        [tableView reloadData];
        //        [AppFunctions PUSH_SCREEN:self identifier:STORYBOARD_ID_B1 animated:YES];
    } else {
        [self performSegueWithIdentifier:STORY_BOARD_VOUCHER_INFO sender:self];
    }
}

- (NSString *)getTypeInfoScreen
{
    NSLog(@"tipo: %@",lblNextScreenType);
    return lblNextScreenType;
}

@end
