//  d0_Deal_Data.m
//  myPota
//
//  Created by Rodrigo Pimentel on 11/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "d0_Deal_Data.h"

@implementation d0_Deal_Data

#pragma mark - View Will Appear
- (void)viewWillAppear:(BOOL)animated
{
    [self configScreen];
    [super viewWillAppear:animated];
}

- (void)configScreen
{
    //navbar
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:@"Pagamento"
                                                               attributes:@{ NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                             NSFontAttributeName: [UIFont fontWithName:FONT_NAME_BOLD size:18]}];
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_GENERIC
                                     title:title
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_CLEAR
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:nil
                                backButton:YES];
    //tableView
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData reloadData];
}

- (IBAction)btnBackScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - View Did Load
- (void)viewDidLoad
{
    [self configKeyboard];
    [self configData];
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

- (void)configData
{
    mySeller = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_SELLER];
    myAgency = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_AGENCY];
    //get all info purchase
    purchaseAllData    = [[NSMutableDictionary alloc]initWithDictionary:[AppFunctions LOAD_INFORMATION:PURCHASE]];
    purchaseAllInfo    = [purchaseAllData mutableCopy];
    purchaseType       = [purchaseAllData objectForKey:PURCHASE_TYPE];
    purchaseInfo       = [[purchaseAllData objectForKey:PURCHASE_INFO_PRODUCT] mutableCopy];
    
    //informações dos viajantes
    purchaseTravellers = [purchaseAllInfo objectForKey:PURCHASE_TYPE_PERSON_DATA];
    lblTitleTravellers = @"Informação do Viajante";
    if ([purchaseTravellers count] > 1)
        lblTitleTravellers = @"Informações dos Viajantes";
    
    listInfoDataStart = @[];
    //    listInfoDataStart = @[@{ PURCHASE_INFO_TITLE  : @"Asseguramos a segurança da sua informação. Leia a nossa política de segurança.",
    //                             PURCHASE_INFO_SCREEN : @"goTo PoliticadeSegurança"}];
    cardInfos = [@{
                   PURCHASE_CARD_INFO_PACERLS   : @"1",
                   PURCHASE_CARD_INFO_FLAG      : KEY_CARD_MASTER,
                   PURCHASE_CARD_INFO_NUMBER    : @"1111222233334444",
                   PURCHASE_CARD_INFO_COD       : @"555",
                   PURCHASE_CARD_INFO_MONTH     : @"Abril",
                   PURCHASE_CARD_INFO_YEAR      : @"2015",
                   PURCHASE_CARD_INFO_NAME      : @"Rodrigo P",
                   PURCHASE_PERSON_INFO_ADRESS  : @"",
                   PURCHASE_PERSON_INFO_CITY    : @"",
                   PURCHASE_PERSON_INFO_UF      : @"",
                   PURCHASE_PERSON_INFO_CEP     : @"",
                   PURCHASE_PERSON_INFO_FONE    : @"" } mutableCopy];
    
    //IDWs
    myAgency = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_AGENCY];
    mySeller = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_SELLER];
    NSLog(@"%@",[myAgency objectForKey:TAG_USER_AGENCY_LIST_ID_WS]);
    for (NSDictionary *info in [myAgency objectForKey:TAG_USER_AGENCY_LIST_ID_WS])
    {
        if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
            if ([[info objectForKey:TAG_USER_AGENCY_CODE_SITE] isEqualToString:@"1"])
                IDWS = [info objectForKey:@"idWsSite"];
        }else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
            if ([[info objectForKey:TAG_USER_AGENCY_CODE_SITE] isEqualToString:@"4"])
                IDWS = [info objectForKey:@"idWsSite"];
            IDWS = @"20130409IT004A000017";
        }
    }
    if (IDWS == nil)
        IDWS = KEY_ID_WS_TRAVEL;
    
    //Set Type Purchase
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL])
        [self configPurchaseTravel];
    else if ([purchaseType isEqualToString:PURCHASE_TYPE_HOTEL])
        [self configPurchaseHotel];
    else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE])
        [self configPurchasePackage];
    
    //Generate Budget
    [self connectionBudget];
}

#pragma mark - configPurchase <Travel / Hotel / Package>
- (void)configPurchaseTravel
{
    lblTitlePurchase = @"Custo da Assistência em Viagem";
    
    listInfoDataEnd = @[ @{ PURCHASE_INFO_TITLE  : @"Condições Gerais",
                            PURCHASE_INFO_SCREEN : @"goTo Condições"}];
    
    //informações do produto
    purchaseProduct  = [[[purchaseAllInfo objectForKey:PURCHASE_INFO_PRODUCT] objectForKey:PURCHASE_DATA_TRAVEL_PLAN_SELECTED] mutableCopy];
    
    [purchaseProduct setValue:[[purchaseAllInfo objectForKey:PURCHASE_INFO_PRODUCT] objectForKey:PURCHASE_DATA_TRAVEL_PAX]
                       forKey:PURCHASE_DATA_TRAVEL_PAX];
    [purchaseProduct setValue:[[purchaseAllInfo objectForKey:PURCHASE_INFO_PRODUCT] objectForKey:PURCHASE_DATA_TRAVEL_DAYS]
                       forKey:PURCHASE_DATA_TRAVEL_DAYS];
}

- (void)configPurchaseHotel
{
    
}

- (void)configPurchasePackage
{
    lblTitlePurchase = @"Custo do Pacote Túristico";
    
    listInfoDataEnd = @[ @{ PURCHASE_INFO_TITLE  : @"Condições Gerais",
                            PURCHASE_INFO_SCREEN : @"goTo Condições"}];
    
    purchaseProduct  = [[purchaseAllInfo objectForKey:PURCHASE_INFO_PRODUCT]mutableCopy];
    
    NSString *valuePurchase = @"0";
    for (NSDictionary *room in [purchaseInfo objectForKey:@"info_room"]){
        float money = [valuePurchase floatValue] + ([[room objectForKey:PACKAGE_INFO_DATA_SEARCH_ROOM_VALUE_VALUE_VENDA]floatValue] * [[room objectForKey:PACKAGE_INFO_ROOM_NUMBER]intValue] * [[room objectForKey:PACKAGE_INFO_DATA_SEARCH_ROOM_QTD_PEOPLE]intValue]);
        valuePurchase = [NSString stringWithFormat:@"%.2f",money];
    }
    
    [purchaseProduct setValue:[purchaseProduct objectForKey:@"Numero_de_Viajantes"]
                       forKey:PURCHASE_DATA_TRAVEL_PAX];
    [purchaseProduct setValue:[[purchaseProduct objectForKey:@"info_circuit"] objectForKey:@"NumDias"]
                       forKey:PURCHASE_DATA_TRAVEL_DAYS];
    [purchaseProduct setValue:[[purchaseProduct objectForKey:@"info_circuit"] objectForKey:@"CodProduto"]
                       forKey:PURCHASE_DATA_TRAVEL_INFO_PLAN_CODE];
    [purchaseProduct setValue:[[purchaseProduct objectForKey:@"info_circuit"] objectForKey:@"TpoProduto"]
                       forKey:@"tipo_produto"];
    [purchaseProduct setValue:[[purchaseProduct objectForKey:@"info_data"] objectForKey:@"DtaFormatada"]
                       forKey:@"data_start"];
    
    for (NSDictionary *roon in [purchaseProduct objectForKey:@"info_room"])
        if ([roon objectForKey:@"SeqVlrPlano"] != nil)
            [purchaseProduct setValue:[roon objectForKey:@"SeqVlrPlano"] forKey:@"SeqVlrPlano"];
    
    [purchaseProduct setObject:valuePurchase forKey:@"valor"];
    
    NSString *age = @"";
    for (NSDictionary *person in purchaseTravellers){
        if ([age isEqualToString:@""])
            age = [NSString stringWithFormat:@"%@", [person objectForKey:@"Age"]];
        else
            age = [NSString stringWithFormat:@"%@,%@",age, [person objectForKey:@"Age"]];
    }
    
    [purchaseProduct setObject:[age substringToIndex:[age length]] forKey:@"ages"];
}

#pragma mark - Table View Functions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return [listInfoDataStart count]; //info start
    else if (section == 1)
        return 1; //card
    else if (section == 2)
        return 1; //custos
    else if (section == 3)
        return [purchaseTravellers count]; //viajantes
    else if (section == 4) //info end
        return [listInfoDataEnd count];
    else
        return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, 20)];
        [label setFont:[UIFont fontWithName:FONT_NAME_MEDIUM size:17]];
        [label setText:lblTitleTravellers];
        [label setTextColor:[UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0]];
        [view addSubview:label];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 1;
    else if (section == 2) {
        if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE])
            return 0.0001f;
    } else if (section == 3) {
        return 20;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0)
        return 60;
    else if ([indexPath section] == 1)
        return 409;
    else if ([indexPath section] == 2) {
        if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE])
            return cellPriceSize;
        return 156;
    } else if ([indexPath section] == 3)
        return 128;
    else if ([indexPath section] == 4)
        return 60;
    else
        return 200;
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
        lblNextScreenType = [[listInfoDataEnd objectAtIndex:[indexPath row]]objectForKey:PURCHASE_INFO_TITLE];
        [self performSegueWithIdentifier:SEGUE_D0_TO_D1 sender:self];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:tableViewData]) {
        
        switch (scrollView.panGestureRecognizer.state) {
                
            case UIGestureRecognizerStateBegan:
                if ( _providerToolbar != nil )
                    [self dismissActionSheet:nil];
                if ( txtViewSelected != nil )
                    [txtViewSelected resignFirstResponder];
                break;
            default:
                break;
        }
    }
    
}

#pragma mark - config Cell
-(UITableViewCell *)configSection1:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    BuyInfoStart *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyInfoStart" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.tag = [indexPath row];
    
    [cell startInfo:[[listInfoDataStart objectAtIndex:[indexPath row]]objectForKey:PURCHASE_INFO_TITLE]];
    
    return cell;
}

-(UITableViewCell *)configSection2:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    BuyInfoCard *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyInfoCard" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.tag = [indexPath row];
    
    [cell startCell:self
            txtDone:@selector(btnDone:)
          txtCancel:@selector(btnCancel:)
                 id:(int)[indexPath row]
           cardInfo:cardInfos
           btnMonth:@selector(btnMonth:)
             btnAge:@selector(btnAge:)
            btnCard:@selector(btnFlag:)
          btnParcel:@selector(btnParcel:)];
    
    if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE])
        [cell.otlBottonLine setHidden:YES];
    return cell;
}

-(UITableViewCell *)configSection3:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        BuyInfoCustos *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyInfoCustos"
                                                              forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell startCell:[purchaseProduct copy] title:lblTitlePurchase];
        return cell;
    }else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
        p2_Package_Info_Cell_Price *cell = [tableView dequeueReusableCellWithIdentifier:@"CellCustosPack" forIndexPath:indexPath];
        
        NSMutableDictionary *infoCircuit = [[purchaseAllData objectForKey:PACKAGE_INFO_CIRCUIT] mutableCopy];
        
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
        
        cellPriceSize = cellPriceSize + (20 * extraLine);
        [cell rezise:extraLine roons:[purchaseInfo objectForKey:@"info_room"] coin:[[purchaseInfo objectForKey:@"info_circuit"] objectForKey:TAG_PACK_CIRCUIT_COIN]];
        
        return cell;
    }
    return nil;
}

-(UITableViewCell *)configSection4:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    BuyInfoTravellers *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyInfoTravellers" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.tag = [indexPath row];
    [cell startCell:[purchaseTravellers objectAtIndex:[indexPath row]] ID:(int)[indexPath row]+1];
    
    return cell;
}

-(UITableViewCell *)configSection5:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    BuyInfoEnd *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyInfoEnd" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.tag = [indexPath row];
    [cell startInfo:[[listInfoDataEnd objectAtIndex:[indexPath row]]objectForKey:PURCHASE_INFO_TITLE]
                 id:(int)[indexPath row]];
    return cell;
}

-(UITableViewCell *)configSection6:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    BuyInfoPurchase *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyInfoPurchase" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.tag = [indexPath row];
    [cell startInfo:[[listProduct objectForKey:TAG_BUY_PURCHASE_VALOR]floatValue]
             parcel:[[cardInfos objectForKey:PURCHASE_CARD_INFO_PACERLS]intValue]];
    
    [cell.btnPurchaseConfirm addTarget:self
                                action:@selector(btnConfirm:)
                      forControlEvents:UIControlEventTouchUpInside];
    otlWait = cell.otlActivity;
    return cell;
}

#pragma mark - Functions Buttons
- (IBAction)btnParcel:(UIStepper *)sender
{
    [cardInfos setObject:[NSString stringWithFormat:@"%.f",sender.value] forKey:PURCHASE_CARD_INFO_PACERLS];
    [tableViewData reloadData];
}

- (IBAction)btnFlag:(UIButton *)sender
{
    [cardInfos setObject:sender.accessibilityValue forKey:PURCHASE_CARD_INFO_FLAG];
    [tableViewData reloadData];
}

- (IBAction)btnMonth:(UIButton *)sender
{
    [self setDataPicker:@"month" sender:sender];
}

- (IBAction)btnAge:(UIButton *)sender
{
    [self setDataPicker:@"year" sender:sender];
}

- (IBAction)btnDone:(UIButton *)sender
{
    [self setInfoTextView:txtViewSelected];
    [txtViewSelected resignFirstResponder];
}

- (IBAction)btnCancel:(UIButton *)sender
{
    [txtViewSelected setText:@""];
    [self setInfoTextView:txtViewSelected];
}

- (IBAction)btnConfirm:(UIButton *)sender
{
    [otlWait startAnimating];
    if ([BuyInfoCard validate:cardInfos]) {
        if (![productValue isEqualToString:@""] && [[purchaseAllData objectForKey:PURCHASE_INFO_PRODUCT_RESERVE]objectForKey:TAG_BUY_PURCHASE_CODE_RESERVA] != nil)
            [self connectionBuy];
        else
            [self connectionBudget];
    }else
        [otlWait stopAnimating];
}

#pragma mark - Config Picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [infoPicker count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [infoPicker objectAtIndex:row];
}

#pragma mark - Functions Picker
- (void)setDataPicker:(NSString *)type sender:(UIButton *)sender
{
    if (_providerToolbar != nil )
        [self dismissActionSheet:nil];
    
    [txtViewSelected resignFirstResponder];
    
    NSDateFormatter *dateFormatter   = [[NSDateFormatter alloc] init];
    NSLocale *localeTMP              = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_Br"];
    [dateFormatter setLocale:localeTMP];
    [dateFormatter setDateFormat:@"yyyy"];
    infoPicker = [NSMutableArray new];
    if ([type isEqualToString:@"month"]) {
        [infoPicker setAccessibilityValue:@"month"];
        for(int months = 0; months < 12; months++)
            [infoPicker addObject:[[NSString stringWithFormat:@"%@",[[dateFormatter monthSymbols]objectAtIndex: months]]capitalizedString]];
    } else {
        [infoPicker setAccessibilityValue:@"year"];
        int yearCurrent = [[dateFormatter stringFromDate:[NSDate date]] intValue];
        for (int i = yearCurrent; i <= yearCurrent + 10; i++)
            [infoPicker addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    maskView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 200, 0, 0)];
    [maskView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
    
    [self.view addSubview:maskView];
    _providerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 200, self.view.bounds.size.width, 50)];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Confirmar"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(dismissActionSheet:)];
    
    
    [done setTintColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:255]];
    
    _providerToolbar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], done];
    _providerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    
    _providerPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 200, 0, 0)];
    _providerPickerView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    _providerPickerView.showsSelectionIndicator = YES;
    _providerPickerView.dataSource = self;
    _providerPickerView.delegate = self;
    
    [self.view addSubview:_providerPickerView];
    [self.view addSubview:_providerToolbar];
    
    [AppFunctions SCROLL_RECT_TO_CENTER:sender.frame animated:YES tableView:tableViewData];
}

- (void)dismissActionSheet:(UISegmentedControl*)sender
{
    if ([infoPicker.accessibilityValue isEqualToString:@"month"])
        [cardInfos setObject:[infoPicker objectAtIndex:[_providerPickerView selectedRowInComponent:0]]
                      forKey:PURCHASE_CARD_INFO_MONTH];
    else if ([infoPicker.accessibilityValue isEqualToString:@"year"])
        [cardInfos setObject:[infoPicker objectAtIndex:[_providerPickerView selectedRowInComponent:0]]
                      forKey:PURCHASE_CARD_INFO_YEAR];
    
    [maskView            removeFromSuperview];
    [_providerPickerView removeFromSuperview];
    [_providerToolbar    removeFromSuperview];
    
    _providerToolbar = nil;
    [tableViewData reloadData];
}

#pragma mark - Functions Text Field/View
- (BOOL)textFieldShouldBeginEditing:(UITextView *)textView
{
    [self setInfoTextView:txtViewSelected];
    txtViewSelected = (UITextField *)textView;
    
    if (_providerToolbar != nil )
    {
        if ([infoPicker.accessibilityValue isEqualToString:@"month"])
            [cardInfos setObject:[infoPicker objectAtIndex:[_providerPickerView selectedRowInComponent:0]]
                          forKey:PURCHASE_CARD_INFO_MONTH];
        else if ([infoPicker.accessibilityValue isEqualToString:@"year"])
            [cardInfos setObject:[infoPicker objectAtIndex:[_providerPickerView selectedRowInComponent:0]]
                          forKey:PURCHASE_CARD_INFO_YEAR];
        
        [maskView            removeFromSuperview];
        [_providerPickerView removeFromSuperview];
        [_providerToolbar    removeFromSuperview];
        
        _providerToolbar = nil;
    }
    
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
        [cardInfos setValue:textField.text forKey:textField.accessibilityValue];
}

#pragma mark - Functions Keyboard
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

#pragma mark - config connection <Budget/Product/Buy>
- (void)connectionBudget
{
    _nomes         = [NSMutableString new];
    _sobrenomes    = [NSMutableString new];
    _idades        = [NSMutableString new];
    _sexos         = [NSMutableString new];
    _rgs           = [NSMutableString new];
    _cpfs          = [NSMutableString new];
    _emails        = [NSMutableString new];
    _telefones     = [NSMutableString new];
    
    for (NSMutableDictionary *traveler in purchaseTravellers)
    {
        [_nomes      appendString:[NSString stringWithFormat:@"%@,",[[traveler objectForKey:CADASTRO_PERSON_FIRST_NAME]
                                                                     stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [_sobrenomes appendString:[NSString stringWithFormat:@"%@,",[[traveler objectForKey:CADASTRO_PERSON_SECOND_NAME]
                                                                     stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [_idades     appendString:[NSString stringWithFormat:@"%@,",[[traveler objectForKey:CADASTRO_PERSON_AGE]
                                                                     stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [_sexos      appendString:[NSString stringWithFormat:@"%@,",[[traveler objectForKey:CADASTRO_PERSON_GENDER]
                                                                     stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [_rgs        appendString:[NSString stringWithFormat:@"1,"]];
        [_cpfs       appendString:[NSString stringWithFormat:@"%@,",[[traveler objectForKey:CADASTRO_PERSON_CPF]
                                                                     stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [_emails     appendString:[NSString stringWithFormat:@"%@,",[[traveler objectForKey:CADASTRO_PERSON_MAIL]
                                                                     stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [_telefones  appendString:[NSString stringWithFormat:@"%@,",[[traveler objectForKey:CADASTRO_PERSON_FONE]
                                                                     stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
    
    _nomes      = [[_nomes      substringToIndex:[_nomes length]-1]mutableCopy];
    _sobrenomes = [[_sobrenomes substringToIndex:[_sobrenomes length]-1]mutableCopy];
    _idades     = [[_idades     substringToIndex:[_idades length]-1]mutableCopy];
    _sexos      = [[_sexos      substringToIndex:[_sexos length]-1]mutableCopy];
    _rgs        = [[_rgs        substringToIndex:[_rgs length]-1]mutableCopy];
    _cpfs       = [[_cpfs       substringToIndex:[_cpfs length]-1]mutableCopy];
    _emails     = [[_emails     substringToIndex:[_emails length]-1]mutableCopy];
    _telefones  = [[_telefones  substringToIndex:[_telefones length]-1]mutableCopy];
    
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        linkBudget = [NSString stringWithFormat:WS_URL_BUY_BUDGET_INFO,IDWS,
                      KEY_CODE_ACTION, KEY_EMPTY, KEY_CODE_SITE_TRAVEL, KEY_CODE_PORTAL,
                      [purchaseProduct objectForKey:PURCHASE_DATA_TRAVEL_INFO_PLAN_CODE],
                      [[purchaseAllInfo objectForKey:PURCHASE_INFO_PRODUCT]  objectForKey:PURCHASE_DATA_TRAVEL_DATA_START],
                      [[purchaseAllInfo objectForKey:PURCHASE_INFO_PRODUCT]  objectForKey:PURCHASE_DATA_TRAVEL_DATA_END],
                      [purchaseProduct objectForKey:PURCHASE_DATA_TRAVEL_PAX],
                      _nomes, _sobrenomes, _idades, _sexos,
                      _rgs, _cpfs, _emails, _telefones,
                      [[purchaseAllInfo objectForKey:PURCHASE_INFO_PRODUCT]  objectForKey:PURCHASE_DATA_TRAVEL_DESTINY],
                      KEY_EMPTY, [myAgency objectForKey:TAG_USER_SELLER_CODE]];
        linkBudget = [NSString stringWithFormat:WS_URL, WS_URL_BUY_NEW_BUDGET, linkBudget];
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
        
        linkBudget = [NSString stringWithFormat:WS_URL_BUY_NEW_BUDGET_PACKAGE_INFO,
                      KEY_CODE_SITE, @"23",
                      [purchaseProduct objectForKey:@"codigo"],
                      [purchaseProduct objectForKey:@"tipo_produto"],
                      @"0",@"0",@"0",
                      [purchaseProduct objectForKey:@"data_start"],
                      [purchaseProduct objectForKey:@"data_start"],
                      @"0",@"0",@"0",
                      [purchaseProduct objectForKey:@"Numero_de_Viajantes"],
                      [purchaseProduct objectForKey:@"ages"],
                      [purchaseProduct objectForKey:@"SeqVlrPlano"]];
        
        
        linkBudget = [NSString stringWithFormat:WS_URL, WS_URL_BUY_NEW_BUDGET_PACKAGE, linkBudget];
    }
    [self startConnection:linkBudget step:1];
}

- (void)connectionInfoProduct
{
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        linkProduct = [NSString stringWithFormat:WS_URL_BUY_PURCHASE_INFO,IDWS,
                       KEY_CODE_SITE_TRAVEL,
                       productID,
                       KEY_CODE_STATUS,
                       _nomes, _sobrenomes, _idades, _sexos,
                       _rgs, _cpfs, _emails, _telefones,
                       KEY_EMPTY];
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
        linkProduct = [NSString stringWithFormat:WS_URL_BUY_PURCHASE_INFO,IDWS,
                       KEY_CODE_SITE_PACKAGE,
                       productID,
                       KEY_CODE_STATUS_PACKAGE,
                       _nomes, _sobrenomes, _idades, _sexos,
                       _rgs, _cpfs, _emails, _telefones,
                       KEY_EMPTY];
    }
    linkProduct = [NSString stringWithFormat:WS_URL, WS_URL_BUY_NEW_PURCHASE, linkProduct];
    [self startConnection:linkProduct step:2];
}

- (void)connectionBuy
{
    [otlWait stopAnimating];
    
    NSDateFormatter *formatDateTMP   = [[NSDateFormatter alloc] init];
    NSLocale *localeTMP              = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_Br"];
    [formatDateTMP setLocale:localeTMP];
    [formatDateTMP setDateFormat:@"MM"];
    NSDate *date    = [formatDateTMP dateFromString:[cardInfos objectForKey:PURCHASE_CARD_INFO_MONTH]];
    NSString *month = [formatDateTMP stringFromDate:date];
    
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        linkPurchase = [NSString stringWithFormat:WS_URL_BUY_REGISTER_INFO,
                        IDWS,
                        KEY_CODE_SITE_TRAVEL,
                        [[purchaseAllData objectForKey:PURCHASE_INFO_PRODUCT_RESERVE]objectForKey:TAG_BUY_PURCHASE_CODE_RESERVA],
                        KEY_BUY_TYPE,
                        [cardInfos objectForKey:PURCHASE_CARD_INFO_FLAG],
                        productValue,
                        [cardInfos objectForKey:PURCHASE_CARD_INFO_PACERLS],
                        [cardInfos objectForKey:PURCHASE_CARD_INFO_NUMBER],
                        month,
                        [cardInfos objectForKey:PURCHASE_CARD_INFO_YEAR],
                        [cardInfos objectForKey:PURCHASE_CARD_INFO_NAME],
                        [cardInfos objectForKey:PURCHASE_CARD_INFO_COD]];
    }else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
        linkPurchase = [NSString stringWithFormat:WS_URL_BUY_REGISTER_INFO,
                        IDWS,
                        KEY_CODE_SITE_PACKAGE,
                        [[purchaseAllData objectForKey:PURCHASE_INFO_PRODUCT_RESERVE]objectForKey:TAG_BUY_PURCHASE_CODE_RESERVA],
                        KEY_BUY_TYPE,
                        [cardInfos objectForKey:PURCHASE_CARD_INFO_FLAG],
                        productValue,
                        [cardInfos objectForKey:PURCHASE_CARD_INFO_PACERLS],
                        [cardInfos objectForKey:PURCHASE_CARD_INFO_NUMBER],
                        month,
                        [cardInfos objectForKey:PURCHASE_CARD_INFO_YEAR],
                        [cardInfos objectForKey:PURCHASE_CARD_INFO_NAME],
                        [cardInfos objectForKey:PURCHASE_CARD_INFO_COD]];
        
    }
    linkPurchase = [NSString stringWithFormat:WS_URL, WS_URL_BUY_REGISTER, linkPurchase];
    [self startConnection:linkPurchase step:3];
}

#pragma mark - recive connection <Budget/Product/Buy>
- (void)reciveBudget:(NSDictionary *)info
{
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        listBudget = [@{ TAG_BUY_BUDGET_ORCAMENTO   : [info objectForKey:TAG_BUY_BUDGET_ORCAMENTO],
                         TAG_BUY_BUDGET_PORTAL      : [info objectForKey:TAG_BUY_BUDGET_PORTAL],
                         TAG_BUY_BUDGET_SITE        : [info objectForKey:TAG_BUY_BUDGET_SITE],
                         TAG_BUY_BUDGET_DATA_START  : [info objectForKey:TAG_BUY_BUDGET_DATA_START],
                         TAG_BUY_BUDGET_DATA_END    : [info objectForKey:TAG_BUY_BUDGET_DATA_END],
                         TAG_BUY_BUDGET_MOEDA       : [info objectForKey:TAG_BUY_BUDGET_MOEDA],
                         TAG_BUY_BUDGET_NOME_PORTAL : [info objectForKey:TAG_BUY_BUDGET_NOME_PORTAL],
                         TAG_BUY_BUDGET_PROPOSTA    : [info objectForKey:TAG_BUY_BUDGET_PROPOSTA],
                         } mutableCopy];
        [purchaseAllData setObject:listBudget forKey:PURCHASE_INFO_BUDGET];
        productID = [listBudget objectForKey:TAG_BUY_BUDGET_ORCAMENTO];
    } else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
        productID = [info objectForKey:@"codigoOrcamento"];
    }
    
    [self connectionInfoProduct];
}

- (void)reciveProduct:(NSDictionary *)info
{
    listProduct = [@{
                     TAG_BUY_PURCHASE_CODE_RESERVA  : [info objectForKey:TAG_BUY_PURCHASE_CODE_RESERVA],
                     TAG_BUY_PURCHASE_CODE_SITE     : [info objectForKey:TAG_BUY_PURCHASE_CODE_SITE],
                     TAG_BUY_PURCHASE_CODE_PORTAL   : [info objectForKey:TAG_BUY_PURCHASE_CODE_PORTAL],
                     TAG_BUY_PURCHASE_PORTAL        : [info objectForKey:TAG_BUY_PURCHASE_PORTAL],
                     TAG_BUY_PURCHASE_MOEDA         : [info objectForKey:TAG_BUY_PURCHASE_MOEDA],
                     TAG_BUY_PURCHASE_VALOR         : [info objectForKey:TAG_BUY_PURCHASE_VALOR],
                     TAG_BUY_PURCHASE_STATUS        : [info objectForKey:TAG_BUY_PURCHASE_STATUS],
                     TAG_BUY_PURCHASE_DATA_START    : [info objectForKey:TAG_BUY_PURCHASE_DATA_START],
                     TAG_BUY_PURCHASE_DATA_END      : [info objectForKey:TAG_BUY_PURCHASE_DATA_END],
                     } mutableCopy];
    [purchaseAllData setObject:listProduct forKey:PURCHASE_INFO_PRODUCT_RESERVE];
    productValue = [listProduct objectForKey:TAG_BUY_PURCHASE_VALOR];
    [AppFunctions LOG_MESSAGE:BUY_TRAVEL_TITLE_MONEY
                      message:[NSString stringWithFormat:BUY_TRAVEL_MESSAGE_MONEY, [[listProduct objectForKey:TAG_BUY_PURCHASE_VALOR]floatValue]]
                       cancel:ERROR_BUTTON_CANCEL];
    [otlWait stopAnimating];
}

- (void)reciveBuy:(NSDictionary *)info
{
    NSString *VOLCHER = [info objectForKey:TAG_BUY_VOUCHER];
    if (VOLCHER == NULL || [VOLCHER isEqualToString:@"-"]) {
        [AppFunctions LOG_MESSAGE:@"Erro no web service de cartão."
                          message:@"O web service não retornou nenhum volcher."
                           cancel:ERROR_BUTTON_CANCEL];
        return;
    }
    
    [self createVoucher:purchaseType voucher:VOLCHER];
}

#pragma mark - Connection <Budget/Product/Buy>
- (void)startConnection:(NSString *)_link step:(int)_step
{
    NSDictionary *labelConnections;
    if (_step == 1)
        labelConnections = @{APP_CONNECTION_TAG_START  : BUY_POTA_CONNECTION_START,
                             APP_CONNECTION_TAG_WAIT   : BUY_POTA_CONNECTION_WAIT,
                             APP_CONNECTION_TAG_RECIVE : BUY_POTA_CONNECTION_RECIVE,
                             APP_CONNECTION_TAG_FINISH : BUY_POTA_CONNECTION_FINISH,
                             APP_CONNECTION_TAG_ERROR  : BUY_POTA_CONNECTION_ERROR };
    else if (_step == 2)
        labelConnections = @{APP_CONNECTION_TAG_START  : BUY_POTA_CONNECTION_START,
                             APP_CONNECTION_TAG_WAIT 	 : BUY_POTA_CONNECTION_WAIT,
                             APP_CONNECTION_TAG_RECIVE : BUY_POTA_CONNECTION_RECIVE,
                             APP_CONNECTION_TAG_FINISH : BUY_POTA_CONNECTION_FINISH,
                             APP_CONNECTION_TAG_ERROR  : BUY_POTA_CONNECTION_ERROR };
    else
        labelConnections = @{APP_CONNECTION_TAG_START  : BUY_POTA_CONNECTION_START,
                             APP_CONNECTION_TAG_WAIT 	 : BUY_POTA_CONNECTION_WAIT,
                             APP_CONNECTION_TAG_RECIVE : BUY_POTA_CONNECTION_RECIVE,
                             APP_CONNECTION_TAG_FINISH : BUY_POTA_CONNECTION_FINISH,
                             APP_CONNECTION_TAG_ERROR  : BUY_POTA_CONNECTION_ERROR };
    
    [appConnection START_CONNECT:_link timeForOu:300.f labelConnection:labelConnections showView:YES block:^(NSData *result) {
        if (result == nil)
            [AppFunctions LOG_MESSAGE:ERROR_1013_TITLE
                              message:ERROR_1013_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
        else {
            
            NSString *TAG = TAG_BUY_BUDGET;
            
            if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE])
                TAG = TAG_BUY_BUDGET_PACKAGE;
            
            if (_step == 2)
                TAG = TAG_BUY_PURCHASE;
            if (_step == 3)
                TAG = TAG_BUY_SUCCESS;
            
            NSDictionary *allDATA = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:TAG];
            for (NSDictionary *tmp in [allDATA objectForKey:TAG])
            {
                if (_step == 1) {
                    if ([[tmp objectForKey:TAG_BUY_BUDGET_ERRO]intValue] > 0)
                        [AppFunctions LOG_MESSAGE:[NSString stringWithFormat:BUY_TRAVEL_TITLE_BUDGET_FAIL,[tmp objectForKey:TAG_BUY_BUDGET_ERRO]]
                                          message:BUY_TRAVEL_MESSAGE_BUDGET_FAIL
                                           cancel:ERROR_BUTTON_CANCEL];
                    else
                        [self reciveBudget:tmp];
                } else if (_step == 2) {
                    if ([[tmp objectForKey:TAG_BUY_PURCHASE_ERRO]intValue] > 0){
                        
                        [AppFunctions LOG_MESSAGE:[NSString stringWithFormat:BUY_TRAVEL_TITLE_PURCHASE_FAIL,[tmp objectForKey:TAG_BUY_PURCHASE_ERRO]]
                                          message:BUY_TRAVEL_MESSAGE_PURCHASE_FAIL
                                           cancel:ERROR_BUTTON_CANCEL];
                    }else
                        [self reciveProduct:tmp];
                } else {
                    if ([[tmp objectForKey:TAG_BUY_ERRO]intValue] > 0){
                        
                        [AppFunctions LOG_MESSAGE:[NSString stringWithFormat:BUY_CARD_TITLE_ERROR,  [tmp objectForKey:TAG_BUY_ERRO]]
                                          message:[NSString stringWithFormat:BUY_CARD_MESSAGE_ERROR,[tmp objectForKey:TAG_BUY_ERRO_TEXT]]
                                           cancel:ERROR_BUTTON_CANCEL];
                    }else
                        [self reciveBuy:tmp];
                }
            }
            
        }
    }];
}

#pragma mark - Create Voucher
- (void) createVoucher:(NSString *)type voucher:(NSString *)voucher
{
    [purchaseAllData setObject:voucher  forKey:PURCHASE_INFO_VOLCHER];
    [purchaseAllData setObject:mySeller forKey:PURCHASE_INFO_SELLER];
    [purchaseAllData setObject:myAgency forKey:PURCHASE_INFO_AGENCY];
    
    listSavePurchase        = [AppFunctions PLIST_LOAD:PLIST_PURCHASES];
    if (listSavePurchase == nil)
        listSavePurchase = [AppFunctions PLIST_PATH:PLIST_PURCHASES type:@"plist"];
    
    [[listSavePurchase objectForKey:@"vouchers"] addObject:purchaseAllData];
    [listSavePurchase writeToFile:[AppFunctions PLIST_SAVE:PLIST_PURCHASES] atomically:YES];
    
    [AppFunctions CLEAR_INFORMATION];
    [AppFunctions SAVE_INFORMATION:purchaseAllData
                               tag:PURCHASE];
    
    [AppFunctions LOG_MESSAGE:BUY_CARD_TITLE_SUCCESS
                      message:[NSString stringWithFormat:BUY_CARD_MESSAGE_SUCCESS, [purchaseAllData objectForKey:PURCHASE_INFO_VOLCHER]]
                       cancel:ERROR_BUTTON_CANCEL];
    
    [AppFunctions GO_TO_SCREEN:self destiny:STORY_BOARD_BUY_VOLCHER];
}

#pragma mark - Functions
- (NSDictionary *)getInfos
{
    return @{ @"type"    : lblNextScreenType,
              @"content" : purchaseAllData
              };
}


@end
