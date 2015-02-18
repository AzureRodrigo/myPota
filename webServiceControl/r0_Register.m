//
//  cadastrePurchase.m
//  myPota
//
//  Created by Rodrigo Pimentel on 06/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "r0_Register.h"

@implementation r0_Register

#pragma mark -configNavBar
- (void)configNavBar
{
    frameView = tableViewData.frame;
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:@"Cadastro de Viajantes"
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
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - willAppear
- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [tableViewData reloadData];
    [super viewWillAppear:animated];
}

#pragma mark - didLoad
- (void)viewDidLoad
{
    [self initScreenData];
    [self configKeyboard];
    [super viewDidLoad];
}

- (void)configKeyboard
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark - config data <Travel, Hotel, Package>
- (void)initScreenData
{
    [tableViewData  setBackgroundColor:[UIColor clearColor]];
    purchaseData = [[NSMutableDictionary alloc]initWithDictionary:[AppFunctions LOAD_INFORMATION:PURCHASE]];
    purchaseType = [purchaseData objectForKey:PURCHASE_TYPE];
    purchaseInfo = [[purchaseData objectForKey:PURCHASE_INFO_PRODUCT] mutableCopy];
    
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL])
        [self setDataTravel];
    else if ([purchaseType isEqualToString:PURCHASE_TYPE_HOTEL])
        [self setDataHotel];
    else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE])
        [self setDataPackge];
}

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
                               CADASTRO_PERSON_SECOND_NAME : @"teste",
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

- (void)setDataHotel
{
    
}

- (void)setDataPackge
{
    listPeopleData = [NSMutableArray new];
    int pax        = [[purchaseInfo objectForKey:PURCHASE_DATA_TRAVEL_PAX]intValue];
    
    for (int i = 0; i < pax; i++) {
        bool hide = YES;
        if (i == 0)
            hide = NO;
        NSDictionary *tmp = @{ CADASTRO_PERSON_HIDE        : [NSString stringWithFormat:@"%d",hide],
                               CADASTRO_PERSON_FIRST_NAME  : @"teste",
                               CADASTRO_PERSON_SECOND_NAME : @"teste",
                               CADASTRO_PERSON_CPF         : @"07528709980",
                               CADASTRO_PERSON_GENDER      : @"M",
                               CADASTRO_PERSON_AGE         : @"25",
                               CADASTRO_PERSON_MAIL        : @"rodrigoazurex@gmail.com",
                               CADASTRO_PERSON_FONE        : @"4136698252",
                               CADASTRO_PERSON_OBSERVER    : @"nada",
                               CADASTRO_PERSON_ROOM_TYPE   : @"",
                               CADASTRO_PERSON_RECIVE_MAIL : @"YES"
                               };
        [listPeopleData addObject:[tmp mutableCopy]];
    }
    //    infoCircuit = [[purchaseInfo objectForKey:PACKAGE_INFO_CIRCUIT] copy];
    //
    //    infoCircuitPriceSize = [[[purchaseInfo objectForKey:PACKAGE_INFO_DETAIL]objectForKey:PACKAGE_INFO_ROOM_SIZE]intValue];
    
    
    //    link_conditions
    //    link_info
    //    link_cyties
    //    link_days
    //    link_images
    listInfoData = @[@{ CADASTRO_INFO_TITLE  : @"Condições Gerais",
                        CADASTRO_INFO_SCREEN : @""},
                     @{ CADASTRO_INFO_TITLE  : @"Informações Sobre o Roteiro",
                        CADASTRO_INFO_SCREEN : @""},
                     @{ CADASTRO_INFO_TITLE  : @"Cidades Inclusas",
                        CADASTRO_INFO_SCREEN : @""},
                     @{ CADASTRO_INFO_TITLE  : @"Dia a Dia",
                        CADASTRO_INFO_SCREEN : @""},
                     @{ CADASTRO_INFO_TITLE  : @"Fotos",
                        CADASTRO_INFO_SCREEN : @""}];
    
    lblTitleConfirm = @"Confirmar";
}

#pragma mark - config TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return [listPeopleData count];
    else if (section == 1)
        return 1;
    //    else if (section == 2)
    //        return [listInfoData count];
    else
        return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1)
        if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE])
            return 0.001f;
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE])
        return 0.001f;
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0) {
        if ([[[listPeopleData objectAtIndex:[indexPath row]] objectForKey:CADASTRO_PERSON_HIDE] boolValue])
            return SIZE_CELL_HEIGHT_TAG_0_CLOSE;
        return SIZE_CELL_HEIGHT_TAG_0_OPEN;
    } else if ([indexPath section] == 1) {
        if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL])
            return 145;
        else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE])
            return cellPriceSize;
        else
            return infoCircuitPriceSize;
    } /*else if ([indexPath section] == 2) {
       if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL])
       return 60;
       else
       return 40;
       } */else
           return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0)
        return  [self setSection1:tableView index:indexPath];
    else if ([indexPath section] == 1)
        return  [self setSection2:tableView index:indexPath];
    //    else if ([indexPath section] == 2)
    //        return [self setSection3:tableView index:indexPath];
    else
        return [self setSection4:tableView index:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*if ([indexPath section] == 2) {
     lblNextScreenType = [[listInfoData objectAtIndex:[indexPath row]]objectForKey:CADASTRO_INFO_SCREEN];
     [self performSegueWithIdentifier:STORY_BOARD_CADASTRE_INFO sender:self];
     }*/
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [txtViewSelected resignFirstResponder];
}

#pragma mark - config Cell's
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
    
    if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE])
        if ([indexPath row] == [listPeopleData count] - 1 ){
            [cell.imgBottonHide setHidden:YES];
            [cell.imgLineHide   setHidden:YES];
        }
    
    return cell;
}

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
        p2_Package_Info_Cell_Price *cell = [tableView dequeueReusableCellWithIdentifier:@"CellCustos" forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor clearColor]];
        
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
        
        cellPriceSize = cellPriceSize + (SIZE_PLUS * extraLine);
        [cell rezise:extraLine roons:[purchaseInfo objectForKey:@"info_room"] coin:[[purchaseInfo objectForKey:@"info_circuit"] objectForKey:TAG_PACK_CIRCUIT_COIN]];
        
        return cell;
    }
    
    return nil;
}

- (UITableViewCell *)setSection3:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        
        cadastreCell_Info *cell = [tableView dequeueReusableCellWithIdentifier:@"CellInfo"
                                                                  forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell startInfo:[[listInfoData objectAtIndex:[indexPath row]] objectForKey:CADASTRO_INFO_TITLE]
                     id:(int)[indexPath row]];
        
        return cell;
        
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_HOTEL]) {
        
        return nil;
        
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
        
        p2_Package_Info_Cell_Button *cell = [tableView dequeueReusableCellWithIdentifier:@"CellInfoPack" forIndexPath:indexPath];
        if([indexPath row] == 0 )                        [cell.imgTopBar setHidden:NO];
        if([indexPath row] != [listInfoData count] -1 )  [cell.imgBar    setHidden:YES];
        if([indexPath row] == [listInfoData count] -1 )  [cell.imgDotBar setHidden:YES];
        
        [cell.lblTitle setText:[[listInfoData objectAtIndex:[indexPath row]]objectForKey:CADASTRO_INFO_TITLE]];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.tag = [indexPath row];
        
        return cell;
    }
    
    return nil;
}

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

#pragma mark - config Buttons
- (IBAction)btnHideShow:(UIButton *)sender
{
    bool hide = [[[listPeopleData objectAtIndex:sender.tag] objectForKey:CADASTRO_PERSON_HIDE] boolValue];
    [[listPeopleData objectAtIndex:sender.tag] setObject:[NSString stringWithFormat:@"%d", hide = !hide] forKey:CADASTRO_PERSON_HIDE];
    [tableViewData reloadData];
}

- (IBAction)btnGender:(UIButton *)sender
{
    UISegmentedControl *choice = (UISegmentedControl *)sender;
    NSString *sex = @"M";
    if (choice.selectedSegmentIndex == 1)
        sex = @"F";
    [[listPeopleData objectAtIndex:sender.tag] setObject:sex forKey:CADASTRO_PERSON_GENDER];
}

- (IBAction)btnSwitchMail:(UIButton *)sender
{
    bool hide = [[[listPeopleData objectAtIndex:sender.tag] objectForKey:CADASTRO_PERSON_RECIVE_MAIL] boolValue];
    [[listPeopleData objectAtIndex:sender.tag] setObject:[NSString stringWithFormat:@"%d", hide = !hide] forKey:CADASTRO_PERSON_RECIVE_MAIL];
}

- (NSDictionary *)getLinkData
{
    return [purchaseData objectForKey:PACKAGE_INFO_HTML_DATA];
}

#pragma mark - config Keyboard
- (void)keyboardWillShow:(NSNotification *)sender
{
    CGSize kbSize = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSTimeInterval duration = [[[sender userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
        [tableViewData setContentInset:edgeInsets];
        [tableViewData setScrollIndicatorInsets:edgeInsets];
    }];
}

- (void)keyboardWillHide:(NSNotification *)sender
{
    NSTimeInterval duration = [[[sender userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
        [tableViewData setContentInset:edgeInsets];
        [tableViewData setScrollIndicatorInsets:edgeInsets];
    }];
}

- (IBAction)keyboardClear:(UIBarButtonItem *)sender
{
    [txtViewSelected setText:@""];
    [self setInfoTextView:txtViewSelected];
}

- (IBAction)keyboardDone:(UIBarButtonItem *)sender
{
    [self setInfoTextView:txtViewSelected];
    [txtViewSelected resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextView *)textView
{
    [self setInfoTextView:txtViewSelected];
    txtViewSelected = (UITextField *)textView;
    //    [self upScreen:textView];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self setInfoTextView:txtViewSelected];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    [self setInfoTextView:txtViewSelected];
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound )
        return YES;
    
    [textView resignFirstResponder];
    return NO;
}

-(BOOL)textViewDidBeginEditing:(UITextView *)textView
{
    [self setInfoTextView:txtViewSelected];
    txtViewSelected = (UITextField *)textView;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self setInfoTextView:txtViewSelected];
    [textField resignFirstResponder];
    return NO;
}

- (void)setInfoTextView:(UITextField *)textField
{
    if (textField != NULL)
        [[listPeopleData objectAtIndex:textField.tag] setValue:textField.text forKey:textField.accessibilityValue];
}

#pragma mark - Functions Screen
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

- (IBAction)btnConfirm:(UIButton *)sender
{
    if ([self isValidated])
    {
        [purchaseData setObject:listPeopleData forKey:PURCHASE_TYPE_PERSON_DATA];
        
        [AppFunctions CLEAR_INFORMATION];
        [AppFunctions SAVE_INFORMATION:purchaseData
                                   tag:PURCHASE];
        
        if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL] || [purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
            [self performSegueWithIdentifier:STORY_BOARD_CADASTRE_BUY sender:self];
        }
    }
}

- (NSString *)getTypeInfoScreen
{
    return lblNextScreenType;
}
@end
