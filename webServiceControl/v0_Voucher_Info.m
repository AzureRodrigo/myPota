//
//  volcherPota.m
//  myPota
//
//  Created by Rodrigo Pimentel on 12/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "v0_Voucher_Info.h"

@implementation v0_Voucher_Info

#pragma mark - config WillAppear
- (void)configNavBar
{
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:@"Voucher"
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

- (IBAction)btnBackScreen:(id)sender
{
    [AppFunctions POP_SCREEN:self identifier:SEGUE_V0_TO_V1 animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [tableData reloadData];
    [super viewWillAppear:animated];
}

#pragma mark - config DidAppear
- (void)initScreenData
{
    [tableData setBackgroundColor:[UIColor clearColor]];
    [tableData setSeparatorColor:[UIColor clearColor]];
    purchaseData = [[NSMutableDictionary alloc]initWithDictionary:[AppFunctions LOAD_INFORMATION:PURCHASE]];
    purchaseType = [purchaseData objectForKey:PURCHASE_TYPE];
    purchaseTravellers = [purchaseData objectForKey:PURCHASE_TYPE_PERSON_DATA];
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL])
        [self setDataTravel];
    else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE])
        [self setDataPackage];
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
    
    listInfoDataEnd = @[@{ INFO_TITLE  : @"Condições Gerais",
                           INFO_SCREEN : @"goTo Condições"}];
}

- (void)setDataPackage
{
    purchaseInfo       = [[purchaseData objectForKey:PURCHASE_INFO_PRODUCT] mutableCopy];
    listPurchaseData   = [[NSMutableDictionary alloc]initWithDictionary:@{
                                                                          PURCHASE_DATA_TRAVEL_PAX  : [purchaseInfo objectForKey:PURCHASE_DATA_TRAVEL_PAX],
                                                                          PURCHASE_DATA_TRAVEL_DAYS : [[purchaseInfo objectForKey:@"info_circuit"] objectForKey:@"NumDias"]
                                                                          }];
    lblTitlePurchase = @"Custo do Pacote Turístico";
    
    listInfoDataEnd =  @[ @{ INFO_TITLE  : @"Condições Gerais",
                             INFO_SCREEN : @""} /*,
                          @{ INFO_TITLE  : @"Informações Sobre o Roteiro",
                             INFO_SCREEN : @""},
                          @{ INFO_TITLE  : @"Cidades Inclusas",
                             INFO_SCREEN : @""},
                          @{ INFO_TITLE  : @"Dia a Dia",
                             INFO_SCREEN : @""},
                          @{ INFO_TITLE  : @"Fotos",
                             INFO_SCREEN : @""}*/];
}

- (void)viewDidLoad
{
    [self initScreenData];
    [super viewDidLoad];
}

#pragma mark - config TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2)
        return [purchaseTravellers count]; //info travellers
    else if (section == 4)
        return [listInfoDataEnd count]; //info geral
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0)
        return 140;
    else if ([indexPath section] == 1)
        return 226;
    else if ([indexPath section] == 2)
        return 165;
    else if ([indexPath section] == 3) {
        if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE])
            return cellPriceSize;
        return 145;
    }else if ([indexPath section] == 4){
        if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE])
            return 40;
        return 60;
    }else if ([indexPath section] == 5)
        return 210;
    return 0;
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 4) {
        lblNextScreenType = [[listInfoDataEnd objectAtIndex:[indexPath row]]objectForKey:INFO_TITLE];
        [self performSegueWithIdentifier:SEGUE_V0_TO_D1 sender:self];
    }
}

#pragma mark - config Cells
-(UITableViewCell *)configSection1:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    voucherPotaVoucherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"voucherCell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.tag = [indexPath row];
    
    [cell startInfo:[purchaseData objectForKey:PURCHASE_INFO_VOLCHER]
               code:[[purchaseData objectForKey:PURCHASE_INFO_PRODUCT_RESERVE]objectForKey:TAG_BUY_PURCHASE_CODE_RESERVA]];
    
    return cell;
}

-(UITableViewCell *)configSection2:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        voucherPotaPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"planCell" forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
        v0_Voucher_Info_Package_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"planCellPackage" forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        NSDictionary *product = [purchaseData objectForKey:@"Produto"];
        [cell.lblType            setText: [[product objectForKey:@"info_circuit"]objectForKey:@"NomGrupo"]];
        [cell.lblName            setText: [[product objectForKey:@"info_circuit"]objectForKey:@"NomProduto"]];
        [cell.lblSeguradora      setText: [[product objectForKey:@"info_circuit"]objectForKey:@"NomSeguradora"]];
        [cell.lblType            setAdjustsFontSizeToFitWidth:YES];
        [cell.lblName            setAdjustsFontSizeToFitWidth:YES];
        [cell.lblSeguradora      setAdjustsFontSizeToFitWidth:YES];
        
        
        NSDateFormatter *formatDateTMP   = [[NSDateFormatter alloc] init];
        NSLocale *localeTMP              = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_Br"];
        [formatDateTMP setLocale:localeTMP];
        [formatDateTMP setDateFormat:@"dd/MM/yyyy"];
        
        NSDate *date = [[formatDateTMP dateFromString:[[product objectForKey:@"info_data"]objectForKey:@"DtaFormatada"]]dateByAddingTimeInterval:60*60*24*[[[product objectForKey:@"info_circuit"]objectForKey:@"NumDias"]intValue]];
        
        [cell.lblDataStart       setText: [[product objectForKey:@"info_data"]objectForKey:@"DtaFormatada"]];
        [cell.lblDataEnd         setText: [formatDateTMP stringFromDate:date]];
        
        [cell.lblNumberTraveller setText: [product objectForKey:@"Numero_de_Viajantes"]];
        [cell.lblNumberDays      setText: [[product objectForKey:@"info_circuit"]objectForKey:@"NumDias"]];
        return cell;
    }
    return nil;
}

-(UITableViewCell *)configSection3:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    voucherPotaTravellerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"travellerCell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.tag = [indexPath row];
    
    [cell startInfo:[NSString stringWithFormat:@"%ld", (long)[indexPath row] + 1]
               name:[NSString stringWithFormat:@"%@ %@",[[purchaseTravellers objectAtIndex:[indexPath row]] objectForKey:CADASTRO_PERSON_FIRST_NAME],[[purchaseTravellers objectAtIndex:[indexPath row]] objectForKey:CADASTRO_PERSON_SECOND_NAME]]
                age:[[purchaseTravellers objectAtIndex:[indexPath row]] objectForKey:CADASTRO_PERSON_AGE]
               mail:[[purchaseTravellers objectAtIndex:[indexPath row]] objectForKey:CADASTRO_PERSON_MAIL]
               fone:[[purchaseTravellers objectAtIndex:[indexPath row]] objectForKey:CADASTRO_PERSON_FONE]
                cpf:[[purchaseTravellers objectAtIndex:[indexPath row]] objectForKey:CADASTRO_PERSON_CPF]];
    
    if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
        if ([indexPath row] >= [purchaseTravellers count] -1)
            [cell.imgBottomBar setHidden:YES];
    }
    
    return cell;
}

- (UITableViewCell *)configSection4:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        
        cadastreCell_TravelCustos *cell = [tableView dequeueReusableCellWithIdentifier:@"CellTravelCustos"
                                                                          forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell startCell:listPurchaseData title:@"Custo da Assistência em viagem"];
        
        return cell;
        
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_HOTEL]) {
        
        return nil;
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
        p2_Package_Info_Cell_Price *cell = [tableView dequeueReusableCellWithIdentifier:@"CellCustosPack" forIndexPath:indexPath];
        
        NSMutableDictionary *infoCircuit = [[purchaseInfo objectForKey:PACKAGE_INFO_CIRCUIT] mutableCopy];
        
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [cell.lblTitle setText:[infoCircuit objectForKey:TAG_PACK_CIRCUIT_NAME_PRODUCT]];
        [cell start];
        
        cellPriceSize = 80;
        NSString *valuePurchase = @"0";
        
        int extraLine = 0;
        for (NSDictionary *room in [purchaseInfo objectForKey:@"info_room"]){
            extraLine += 1;
            float money = [valuePurchase floatValue] + ([[room objectForKey:PACKAGE_INFO_DATA_SEARCH_ROOM_VALUE_VALUE_VENDA]floatValue] * [[room objectForKey:PACKAGE_INFO_ROOM_NUMBER]intValue] * [[room objectForKey:PACKAGE_INFO_DATA_SEARCH_ROOM_QTD_PEOPLE]intValue]);
            valuePurchase = [NSString stringWithFormat:@"%.2f",money];
        }
        
        [cell.lblPrice setText:[NSString stringWithFormat:@"%@ %.2f",
                                [[purchaseInfo objectForKey:@"info_circuit"] objectForKey:TAG_PACK_CIRCUIT_COIN],
                                [valuePurchase floatValue]]];
        
        cellPriceSize = cellPriceSize + (20 * extraLine);
        [cell rezise:extraLine roons:[purchaseInfo objectForKey:@"info_room"] coin:[[purchaseInfo objectForKey:@"info_circuit"] objectForKey:TAG_PACK_CIRCUIT_COIN]];
        
        return cell;
        
    }
    return nil;
}

-(UITableViewCell *)configSection5:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        BuyInfoEnd *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyInfoEnd" forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.tag = [indexPath row];
        [cell startInfo:[[listInfoDataEnd objectAtIndex:[indexPath row]]objectForKey:INFO_TITLE]
                     id:(int)[indexPath row]];
        return cell;
    }else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
        p2_Package_Info_Cell_Button *cell = [tableView dequeueReusableCellWithIdentifier:@"CellInfoPack" forIndexPath:indexPath];
        
        [cell.lblTitle setText:[[listInfoDataEnd objectAtIndex:[indexPath row]]objectForKey:INFO_TITLE]];
        
        if ([[[listInfoDataEnd objectAtIndex:[indexPath row]]objectForKey:INFO_TITLE] isEqualToString:[[listInfoDataEnd objectAtIndex:0]objectForKey:INFO_TITLE]])
            [cell.imgTopBar setHidden:NO];
        else
            [cell.imgTopBar setHidden:YES];
        
        
        if ([[[listInfoDataEnd objectAtIndex:[indexPath row]]objectForKey:INFO_TITLE] isEqualToString:[[listInfoDataEnd objectAtIndex:[listInfoDataEnd count]-1]objectForKey:INFO_TITLE]]){
            [cell.imgBar    setHidden:NO];
            [cell.imgDotBar setHidden:YES];
        } else {
            [cell.imgBar    setHidden:YES];
            [cell.imgDotBar setHidden:NO];
        }
        
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.tag = [indexPath row];
        
        return cell;
    }
    return nil;
}

-(UITableViewCell *)configSection6:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    voucherPotaSellerData *cell = [tableView dequeueReusableCellWithIdentifier:@"sellerDataCell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
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
    
    [cell startCell:[agency objectForKey:TAG_USER_AGENCY_LOGOTYPE]
          imgSecure:@""
               name:[agency objectForKey:TAG_USER_AGENCY_NAME]
             street:[agency objectForKey:TAG_USER_AGENCY_ADRESS]
             adress:[NSString stringWithFormat:@"%@ - %@ - CEP %@",[agency objectForKey:TAG_USER_AGENCY_QUARTER], [seller objectForKey:TAG_USER_SELLER_CITY], [agency objectForKey:TAG_USER_AGENCY_CEP]]
               mail:[agency objectForKey:TAG_USER_AGENCY_URL]
             seller:[seller objectForKey:TAG_USER_SELLER_NAME]
        reserveCode:[product objectForKey:TAG_BUY_PURCHASE_CODE_RESERVA]
       dataPurchase:dateBuy];
    
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
    }
    
    return cell;
}

#pragma mark - Functions
- (NSDictionary *)getInfos
{
    return @{ @"type"    : lblNextScreenType,
              @"content" : purchaseData
              };
}

@end
