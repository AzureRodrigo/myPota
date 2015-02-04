//
//  cadastrePurchase.m
//  myPota
//
//  Created by Rodrigo Pimentel on 06/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "cadastrePurchase.h"

@implementation cadastrePurchase

#pragma mark -configNavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_RESERVA
                                     title:nil
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_CLEAR
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:nil
                                backButton:YES];
}

- (IBAction)btnBackScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    [self configNavBar];
    [tableViewData reloadData];
    [super viewWillAppear:animated];
}

#pragma mark - Init Screen Data
- (void)initScreenData
{
    [tableViewData  setBackgroundColor:[UIColor clearColor]];
    purchaseData = [[NSMutableDictionary alloc]initWithDictionary:[AppFunctions LOAD_INFORMATION:PURCHASE]];
    purchaseType = [purchaseData objectForKey:PURCHASE_TYPE];
    purchaseInfo = [[purchaseData objectForKey:PURCHASE_INFO_PRODUCT] mutableCopy];
    
    
    NSLog(@"%@",purchaseData);
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL])
        [self setDataTravel];
    else if ([purchaseType isEqualToString:PURCHASE_TYPE_HOTEL])
        [self setDataHotel];
    else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE])
        [self setDataPackge];
}

#pragma mark - Set data for: Travel
- (void)setDataTravel
{
    // 1º seta o tipo de viajante e a quantia
    listPeopleData = [NSMutableArray new];
    for (int i = 0; i < [[purchaseInfo objectForKey:PURCHASE_DATA_TRAVEL_PAX]intValue]; i++) {
        bool hide = YES;
        if (i == 0)
            hide = NO;
        //        NSDictionary *tmp = @{ CADASTRO_PERSON_HIDE        : [NSString stringWithFormat:@"%d",hide],
        //                               CADASTRO_PERSON_FIRST_NAME  : @"",
        //                               CADASTRO_PERSON_SECOND_NAME : @"",
        //                               CADASTRO_PERSON_CPF         : @"",
        //                               CADASTRO_PERSON_GENDER      : @"M",
        //                               CADASTRO_PERSON_AGE         : @"",
        //                               CADASTRO_PERSON_MAIL        : @"",
        //                               CADASTRO_PERSON_FONE        : @"",
        //                               CADASTRO_PERSON_OBSERVER    : @"",
        //                               CADASTRO_PERSON_RECIVE_MAIL : @"YES"
        //                               };
        NSDictionary *tmp = @{ CADASTRO_PERSON_HIDE        : [NSString stringWithFormat:@"%d",hide],
                               CADASTRO_PERSON_FIRST_NAME  : @"rodrigo",
                               CADASTRO_PERSON_SECOND_NAME : @"pimentel",
                               CADASTRO_PERSON_CPF         : @"07528709980",
                               CADASTRO_PERSON_GENDER      : @"M",
                               CADASTRO_PERSON_AGE         : @"25",
                               CADASTRO_PERSON_MAIL        : @"rodrigoazurex@gmail.com",
                               CADASTRO_PERSON_FONE        : @"4136698252",
                               CADASTRO_PERSON_OBSERVER    : @"nada",
                               CADASTRO_PERSON_RECIVE_MAIL : @"YES"
                               };
        [listPeopleData addObject:[tmp mutableCopy]];
    }
    
    // 2º seta os dados da compra
    listPurchaseData = [[purchaseInfo objectForKey:PURCHASE_DATA_TRAVEL_PLAN_SELECTED] mutableCopy];
    
    
    [listPurchaseData setValue:[purchaseInfo objectForKey:PURCHASE_DATA_TRAVEL_PAX]
                        forKey:PURCHASE_DATA_TRAVEL_PAX];
    [listPurchaseData setValue:[purchaseInfo objectForKey:PURCHASE_DATA_TRAVEL_DAYS]
                        forKey:PURCHASE_DATA_TRAVEL_DAYS];
    
    lblTitlePurchase = @"Custo da Assistência em Viagem";
    
    // 3º seta os tipos de informações
    listInfoData = @[@{ CADASTRO_INFO_TITLE  : @"Ver todas as Coberturas",
                        CADASTRO_INFO_SCREEN : CADASTRO_NEXT_SCREEN_COBERTURAS},
                     @{ CADASTRO_INFO_TITLE  : @"Condições Gerais",
                        CADASTRO_INFO_SCREEN : CADASTRO_NEXT_SCREEN_CONDICOES}];
    
    // 4º seta o titulo do botão de confirmar
    lblTitleConfirm = @"Confirmar";
}

#pragma mark - Set data for: Hotel
- (void)setDataHotel
{
    
}

#pragma mark - Set data for: Packge
- (void)setDataPackge
{
    listPeopleData = [NSMutableArray new];
    int pax        = [[[purchaseInfo objectForKey:PACKAGE_INFO_DETAIL]objectForKey:PURCHASE_DATA_TRAVEL_PAX]intValue];
    
    for (int i = 0; i < pax; i++) {
        bool hide = YES;
        if (i == 0)
            hide = NO;
        NSDictionary *tmp = @{ CADASTRO_PERSON_HIDE        : [NSString stringWithFormat:@"%d",hide],
                               CADASTRO_PERSON_FIRST_NAME  : @"rodrigo",
                               CADASTRO_PERSON_SECOND_NAME : @"pimentel",
                               CADASTRO_PERSON_CPF         : @"07528709980",
                               CADASTRO_PERSON_GENDER      : @"M",
                               CADASTRO_PERSON_AGE         : @"25",
                               CADASTRO_PERSON_MAIL        : @"rodrigoazurex@gmail.com",
                               CADASTRO_PERSON_FONE        : @"4136698252",
                               CADASTRO_PERSON_OBSERVER    : @"nada",
                               CADASTRO_PERSON_RECIVE_MAIL : @"YES"
                               };
        [listPeopleData addObject:[tmp mutableCopy]];
    }
    
    infoCircuit = [[purchaseInfo objectForKey:PACKAGE_INFO_CIRCUIT] copy];
    
    infoCircuitPriceSize = [[[purchaseInfo objectForKey:PACKAGE_INFO_DETAIL]objectForKey:PACKAGE_INFO_ROOM_SIZE]intValue];
    
    listInfoData = @[@{ CADASTRO_INFO_TITLE  : @"Condições Gerais",
                        CADASTRO_INFO_SCREEN : CADASTRO_NEXT_SCREEN_PACK_COND},
                     @{ CADASTRO_INFO_TITLE  : @"Informações Sobre o Roteiro",
                        CADASTRO_INFO_SCREEN : CADASTRO_NEXT_SCREEN_PACK_INFO},
                     @{ CADASTRO_INFO_TITLE  : @"Dia a Dia",
                        CADASTRO_INFO_SCREEN : CADASTRO_NEXT_SCREEN_PACK_DAY}];
    
    // 4º seta o titulo do botão de confirmar
    lblTitleConfirm = @"Confirmar";
}

#pragma mark - Number of Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

#pragma mark - Number of Lines
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return [listPeopleData count];
    else if (section == 1)
        return 1;
    else if (section == 2)
        return [listInfoData count];
    else
        return 1;
}

#pragma mark - Title Sections
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
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
    if ([indexPath section] == 0) {
        if ([[[listPeopleData objectAtIndex:[indexPath row]] objectForKey:CADASTRO_PERSON_HIDE] boolValue])
            return SIZE_CELL_HEIGHT_TAG_0_CLOSE;
        return SIZE_CELL_HEIGHT_TAG_0_OPEN;
    } else if ([indexPath section] == 1) {
        if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL])
            return 145;
        else
            return infoCircuitPriceSize;
    } else if ([indexPath section] == 2) {
        if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL])
            return 60;
        else
            return 40;
    } else
        return 60;
}

#pragma mark - Cell Customize
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0)
        
        return  [self setSection1:tableView index:indexPath];
    
    else if ([indexPath section] == 1)
        
        return  [self setSection2:tableView index:indexPath];
    
    else if ([indexPath section] == 2)
        
        return [self setSection3:tableView index:indexPath];
    
    else
        
        return [self setSection4:tableView index:indexPath];
}

#pragma mark - Cell config sector 1
- (UITableViewCell *)setSection1:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    cadastreCell_TravelPeople *cell = [tableView dequeueReusableCellWithIdentifier:@"CellTravelPeople" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.tag = [indexPath row];
    [cell.lblTitle setText:[NSString stringWithFormat:@"Viajante %ld",(long)[indexPath row]+1]];
    cell.hide = [[[listPeopleData objectAtIndex:[indexPath row]] objectForKey:CADASTRO_PERSON_HIDE] boolValue];
    
    //button config
    [cell.btnHideShow  setTag:[indexPath row]];
    [cell.btnHideShow addTarget:self action:@selector(btnHideShow:)
               forControlEvents:UIControlEventTouchUpInside];
    [cell.btnGender setTag:[indexPath row]];
    [cell.btnGender addTarget:self action:@selector(btnGender:)
             forControlEvents:UIControlEventValueChanged];
    [cell.btnSwitchMail  setTag:[indexPath row]];
    [cell.btnSwitchMail addTarget:self action:@selector(btnSwitchMail:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [cell startCell:self
               done:@selector(keyboardDone:)
             cancel:@selector(keyboardClear:)
                 id:(int)[indexPath row]
          traveller:[listPeopleData objectAtIndex:[indexPath row]]];
    
    [cell.btnCancel setTag:[indexPath row]];
    
    return cell;
}

#pragma mark - Cell config sector 2
- (UITableViewCell *)setSection2:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        
        cadastreCell_TravelCustos *cell = [tableView dequeueReusableCellWithIdentifier:@"CellTravelCustos"
                                                                          forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell startCell:[listPurchaseData copy] title:lblTitlePurchase];
        
        return cell;
        
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_HOTEL]) {
        return nil;
        
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
        
        NSDictionary *information = [purchaseInfo objectForKey:PACKAGE_INFO_DETAIL];
        
        packInfoPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellPackageCustos" forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        NSString *circuit_days = [infoCircuit objectForKey:TAG_PACK_CIRCUIT_NUM_DAYS];
        NSString *day   = @"Dias";
        if ([circuit_days integerValue] <= 1) day = @"Dia";
        
        [cell.lblTitle setText:[NSString stringWithFormat:@"%@ (%@ %@)",
                                [infoCircuit objectForKey:TAG_PACK_CIRCUIT_NAME_PRODUCT], circuit_days, day]];
        
        [cell.lblPrice setText:[NSString stringWithFormat:@"%@ %.2f",
                                [infoCircuit objectForKey:TAG_PACK_CIRCUIT_COIN],
                                [[information objectForKey:PACKAGE_INFO_ROOM_PRICE]floatValue]]];
        
        [cell start];
        int extraLine = 0;
        for (NSDictionary *room in [information objectForKey:PACKAGE_INFO_ROOM_INFO])
            if ([[room objectForKey:PACKAGE_INFO_ROOM_NUMBER]intValue] != 0)
                extraLine += 1;
        
        [cell rezise:extraLine roons:[information objectForKey:PACKAGE_INFO_ROOM_INFO] coin:[infoCircuit objectForKey:TAG_PACK_CIRCUIT_COIN]];
        
        return cell;
        
    }
    
    return nil;
}

#pragma mark - Cell config sector 3
- (UITableViewCell *)setSection3:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        
        cadastreCell_Info *cell = [tableView dequeueReusableCellWithIdentifier:@"CellInfo"
                                                                  forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell startInfo:[[listInfoData objectAtIndex:[indexPath row]]objectForKey:CADASTRO_INFO_TITLE]
                     id:(int)[indexPath row]];
        
        return cell;
        
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_HOTEL]) {
        
        return nil;
        
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
        
        packInfoButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellInfoPack" forIndexPath:indexPath];
        
        if ([indexPath row] == 0)
            [cell.imgTopBar setHidden:NO];
        if([indexPath row] != 2)[cell.imgBar    setHidden:YES];
        if([indexPath row] == 2)[cell.imgDotBar setHidden:YES];
        
        [cell.lblTitle setText:[[listInfoData objectAtIndex:[indexPath row]]objectForKey:CADASTRO_INFO_TITLE]];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.tag = [indexPath row];
        return cell;
        
    }
    return nil;
}

#pragma mark - Cell config sector 4
- (UITableViewCell *)setSection4:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    cadastreCell_Confirm *cell = [tableView dequeueReusableCellWithIdentifier:@"CellConfirm"
                                                                 forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.otlButtonConfirm addTarget:self action:@selector(btnConfirm:)
                    forControlEvents:UIControlEventTouchUpInside];
    [cell.otlButtonConfirm setTitle:lblTitleConfirm forState:UIControlStateNormal];
    
    return cell;
}

#pragma mark - hideButton travellerData
- (IBAction)btnHideShow:(UIButton *)sender
{
    bool hide = [[[listPeopleData objectAtIndex:sender.tag] objectForKey:CADASTRO_PERSON_HIDE] boolValue];
    [[listPeopleData objectAtIndex:sender.tag] setObject:[NSString stringWithFormat:@"%d", hide = !hide] forKey:CADASTRO_PERSON_HIDE];
    [tableViewData reloadData];
}

#pragma mark - hideButton travellerGender
- (IBAction)btnGender:(UIButton *)sender
{
    UISegmentedControl *choice = (UISegmentedControl *)sender;
    NSString *sex = @"M";
    if (choice.selectedSegmentIndex == 1)
        sex = @"F";
    [[listPeopleData objectAtIndex:sender.tag] setObject:sex forKey:CADASTRO_PERSON_GENDER];
}

#pragma mark - switchButton mail
- (IBAction)btnSwitchMail:(UIButton *)sender
{
    bool hide = [[[listPeopleData objectAtIndex:sender.tag] objectForKey:CADASTRO_PERSON_RECIVE_MAIL] boolValue];
    [[listPeopleData objectAtIndex:sender.tag] setObject:[NSString stringWithFormat:@"%d", hide = !hide] forKey:CADASTRO_PERSON_RECIVE_MAIL];
}

#pragma mark - Table Cell Select
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 2) {
        lblNextScreenType = [[listInfoData objectAtIndex:[indexPath row]]objectForKey:CADASTRO_INFO_SCREEN];
        [self performSegueWithIdentifier:STORY_BOARD_CADASTRE_INFO sender:self];
    }
}

#pragma mark - function for next screen
- (NSString *)getTypeInfoScreen
{
    return lblNextScreenType;
}

- (NSDictionary *)getLinkData
{
    return [purchaseData objectForKey:PACKAGE_INFO_HTML_DATA];
}

#pragma mark - Validate confirm to Next Screen
- (BOOL)isValidated
{
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        
        for (int i = 0; i < [listPeopleData count]; i++)
            if (![cadastreCell_TravelPeople validate:[listPeopleData objectAtIndex:i] ID:i])
                return NO;
        
        int ageNew = 0;
        for (int i = 0; i < [listPeopleData count]; i++)
            if ([[[listPeopleData objectAtIndex:i]objectForKey:CADASTRO_PERSON_AGE]intValue] <= 75)
                ageNew += 1;
        
        if (ageNew > [[purchaseInfo objectForKey:PURCHASE_DATA_TRAVEL_PAX_YOUNG]intValue]) {
            [AppFunctions LOG_MESSAGE:ERROR_1027_TITLE
                              message:ERROR_1027_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
            return NO;
        }
        
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_HOTEL]) {
        
        return NO;
        
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
        for (int i = 0; i < [listPeopleData count]; i++)
            if (![cadastreCell_TravelPeople validate:[listPeopleData objectAtIndex:i] ID:i])
                return NO;
    }
    
    return YES;
}

#pragma mark - Button confirm to Next Screen
- (IBAction)btnConfirm:(UIButton *)sender
{
    if ([self isValidated])
        [self nextScreenPrepare];
}

#pragma mark - TEXT FIELD FUNCTIONS

#pragma mark - Numeric keyboard Clear
- (IBAction)keyboardClear:(UIBarButtonItem *)sender
{
    [txtViewSelected setText:@""];
    [self setInfoTextView:txtViewSelected];
}

#pragma mark - Numeric keyboard Done
- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    [self setInfoTextView:txtViewSelected];
    [txtViewSelected resignFirstResponder];
}

#pragma mark - Textfield begin edit
- (BOOL)textFieldShouldBeginEditing:(UITextView *)textView
{
    [self setInfoTextView:txtViewSelected];
    txtViewSelected = (UITextField *)textView;
    [self upScreen:textView];
    return YES;
}

#pragma mark - Textfield end edit
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self setInfoTextView:txtViewSelected];
    return YES;
}

#pragma mark - TextBoxField end edit
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    [self setInfoTextView:txtViewSelected];
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound )
        return YES;
    
    [textView resignFirstResponder];
    return NO;
}

#pragma mark - Textfield open
-(BOOL)textViewDidBeginEditing:(UITextView *)textView
{
    [self setInfoTextView:txtViewSelected];
    txtViewSelected = (UITextField *)textView;
    return YES;
}

#pragma mark - Textfield close
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self setInfoTextView:txtViewSelected];
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - textViewFunction Switch fild
- (void)setInfoTextView:(UITextField *)textField
{
    if (textField != NULL)
        [[listPeopleData objectAtIndex:textField.tag] setValue:textField.text forKey:textField.accessibilityValue];
}

#pragma mark - scroll Ajust
- (void)upScreen:(UITextView *)textView
{
    float sizeCenter = 0;
    
    for (int i = 0 ; i < textView.tag; i++)
    {
        if (![[[listPeopleData objectAtIndex:i] objectForKey:CADASTRO_PERSON_HIDE] boolValue])
            sizeCenter += SIZE_CELL_HEIGHT_TAG_0_OPEN;
        else
            sizeCenter += SIZE_CELL_HEIGHT_TAG_0_CLOSE;
    }
    
    CGRect textFieldRect = CGRectMake( textView.frame.origin.x, textView.frame.origin.y+sizeCenter+30,
                                      textView.frame.size.width, textView.frame.size.height);
    
    [AppFunctions SCROLL_RECT_TO_CENTER:textFieldRect
                               animated:YES
                              tableView:tableViewData];
}

#pragma mark -Prepare to next screen
- (void)nextScreenPrepare
{
    [purchaseData setObject:listPeopleData forKey:PURCHASE_TYPE_PERSON_DATA];
    
    [AppFunctions CLEAR_INFORMATION];
    [AppFunctions SAVE_INFORMATION:purchaseData
                               tag:PURCHASE];
    
    NSLog(@"%@",purchaseData);
    
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        [self performSegueWithIdentifier:STORY_BOARD_CADASTRE_BUY sender:self];
    }
}

@end
