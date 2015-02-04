
//  purchasePota.m
//  myPota
//
//  Created by Rodrigo Pimentel on 11/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "purchasePota.h"

@implementation purchasePota

#pragma mark -configNavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PURCHASE
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
    [super viewWillAppear:animated];
    [tableViewData reloadData];
}

#pragma mark - Init Screen Data
- (void)initScreenData
{
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    purchaseAllData = [[NSMutableDictionary alloc]initWithDictionary:[AppFunctions LOAD_INFORMATION:PURCHASE]];
    purchaseAllInfo = [purchaseAllData mutableCopy];
    purchaseType    = [purchaseAllData objectForKey:PURCHASE_TYPE];
    [self setDataGeral];
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL])
        [self setDataTravel];
    else if ([purchaseType isEqualToString:PURCHASE_TYPE_HOTEL])
        [self setDataHotel];
    else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE])
        [self setDataPackage];
    
//    [self connectionBudget];
}

- (void)setDataGeral
{
    purchaseTravellers = [purchaseAllInfo objectForKey:PURCHASE_TYPE_PERSON_DATA];
    lblTitleTravellers = @"Informação do Viajante";
    if ([purchaseTravellers count] > 1)
        lblTitleTravellers = @"Informações dos Viajantes";
    
    purchaseProduct = [[[purchaseAllInfo objectForKey:PURCHASE_INFO_PRODUCT] objectForKey:PURCHASE_DATA_TRAVEL_PLAN_SELECTED] mutableCopy];
    [purchaseProduct setValue:[[purchaseAllInfo objectForKey:PURCHASE_INFO_PRODUCT] objectForKey:PURCHASE_DATA_TRAVEL_PAX]
                       forKey:PURCHASE_DATA_TRAVEL_PAX];
    [purchaseProduct setValue:[[purchaseAllInfo objectForKey:PURCHASE_INFO_PRODUCT] objectForKey:PURCHASE_DATA_TRAVEL_DAYS]
                       forKey:PURCHASE_DATA_TRAVEL_DAYS];
    
    listInfoDataStart = @[];
//    listInfoDataStart = @[@{ PURCHASE_INFO_TITLE  : @"Asseguramos a segurança da sua informação. Leia a nossa política de segurança.",
//                             PURCHASE_INFO_SCREEN : @"goTo PoliticadeSegurança"}];
    cardInfos = [@{
                   PURCHASE_CARD_INFO_PACERLS   : @"1",
                   PURCHASE_CARD_INFO_FLAG      : KEY_CARD_MASTER,
                   PURCHASE_CARD_INFO_NUMBER    : @"1111222233334444",
                   PURCHASE_CARD_INFO_COD       : @"555",
                   PURCHASE_CARD_INFO_MONTH     : @"Janeiro",
                   PURCHASE_CARD_INFO_YEAR      : @"2015",
                   PURCHASE_CARD_INFO_NAME      : @"Rodrigo P",
                   PURCHASE_PERSON_INFO_ADRESS  : @"",
                   PURCHASE_PERSON_INFO_CITY    : @"",
                   PURCHASE_PERSON_INFO_UF      : @"",
                   PURCHASE_PERSON_INFO_CEP     : @"",
                   PURCHASE_PERSON_INFO_FONE    : @"" } mutableCopy];
//    cardInfos = [@{
//                   PURCHASE_CARD_INFO_PACERLS   : @"1",
//                   PURCHASE_CARD_INFO_FLAG      : KEY_CARD_MASTER,
//                   PURCHASE_CARD_INFO_NUMBER    : @"",
//                   PURCHASE_CARD_INFO_COD       : @"",
//                   PURCHASE_CARD_INFO_MONTH     : @"",
//                   PURCHASE_CARD_INFO_YEAR      : @"",
//                   PURCHASE_CARD_INFO_NAME      : @"",
//                   PURCHASE_PERSON_INFO_ADRESS  : @"",
//                   PURCHASE_PERSON_INFO_CITY    : @"",
//                   PURCHASE_PERSON_INFO_UF      : @"",
//                   PURCHASE_PERSON_INFO_CEP     : @"",
//                   PURCHASE_PERSON_INFO_FONE    : @"" } mutableCopy];
    
    
    IDWS = @"TESTE_WS_VITALCARD";//[[purchaseAllInfo objectForKey:PURCHASE_INFO_AGENCY]objectForKey:AGENCY_DATA_IDWS];
    if ([IDWS isEqualToString:@""])
        IDWS = KEY_ID_WS_TRAVEL;
}

- (void)setDataTravel
{
    lblTitlePurchase = @"Custo da Assistência em Viagem";
    
    listInfoDataEnd = @[@{ PURCHASE_INFO_TITLE  : @"Ver todas as Coberturas",
                           PURCHASE_INFO_SCREEN : @"goTo Coberturas"},
                        @{ PURCHASE_INFO_TITLE  : @"Condições Gerais",
                           PURCHASE_INFO_SCREEN : @"goTo Condições"}];
}

- (void)setDataHotel
{
    
}

- (void)setDataPackage
{
    
}

#pragma mark - Number of Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

#pragma mark - Number of Lines
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

#pragma mark - Title Sections
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

#pragma mark - Title Sections Customize
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

#pragma mark - Title Sections Heigth Header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 1;
    else if (section == 3)
        return 20;
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
        return 60;
    else if ([indexPath section] == 1)
        return 409;
    else if ([indexPath section] == 2)
        return 156;
    else if ([indexPath section] == 3)
        return 128;
    else if ([indexPath section] == 4)
        return 60;
    else
        return 200;
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
    BuyInfoStart *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyInfoStart" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.tag = [indexPath row];
    
    [cell startInfo:[[listInfoDataStart objectAtIndex:[indexPath row]]objectForKey:PURCHASE_INFO_TITLE]];
    
    return cell;
}

#pragma mark - define section 2
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
    
    return cell;
}

#pragma mark - define section 3
-(UITableViewCell *)configSection3:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
        BuyInfoCustos *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyInfoCustos"
                                                              forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell startCell:[purchaseProduct copy] title:lblTitlePurchase];
        return cell;
    }
    return nil;
}

#pragma mark - define section 4
-(UITableViewCell *)configSection4:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    BuyInfoTravellers *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyInfoTravellers" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.tag = [indexPath row];
    [cell startCell:[purchaseTravellers objectAtIndex:[indexPath row]] ID:(int)[indexPath row]+1];
    
    return cell;
}

#pragma mark - define section 5
-(UITableViewCell *)configSection5:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    BuyInfoEnd *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyInfoEnd" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.tag = [indexPath row];
    [cell startInfo:[[listInfoDataEnd objectAtIndex:[indexPath row]]objectForKey:PURCHASE_INFO_TITLE]
                 id:(int)[indexPath row]];
    return cell;
}

#pragma mark - define section 6
-(UITableViewCell *)configSection6:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    BuyInfoPurchase *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyInfoPurchase" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.tag = [indexPath row];
    [cell startInfo:[[purchaseProduct objectForKey:@"valor"]floatValue]
             parcel:[[cardInfos objectForKey:PURCHASE_CARD_INFO_PACERLS]intValue]];
    
    [cell.btnPurchaseConfirm addTarget:self
                                action:@selector(btnConfirm:)
                      forControlEvents:UIControlEventTouchUpInside];
    otlWait = cell.otlActivity;
    return cell;
}

#pragma mark - Table Cell Select
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0) {
        lblNextScreenType = CADASTRO_NEXT_SCREEN_SECURE;
    } else if ([indexPath section] == 4) {
        if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL]) {
            if ([indexPath row] == 0)
                lblNextScreenType = CADASTRO_NEXT_SCREEN_COBERTURAS;
            else
                lblNextScreenType = CADASTRO_NEXT_SCREEN_CONDICOES;
        } else if ([purchaseType isEqualToString:PURCHASE_TYPE_HOTEL]) {
            
        } else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE]) {
            
        }
    }
    [self performSegueWithIdentifier:STORY_BOARD_BUY_INFO sender:self];
}

- (NSString *)getTypeInfoScreen
{
    return lblNextScreenType;
}

#pragma mark - Button Parcel
- (IBAction)btnParcel:(UIStepper *)sender
{
    [cardInfos setObject:[NSString stringWithFormat:@"%.f",sender.value] forKey:PURCHASE_CARD_INFO_PACERLS];
    [tableViewData reloadData];
}

#pragma mark - Button Flag
- (IBAction)btnFlag:(UIButton *)sender
{
    [cardInfos setObject:sender.accessibilityValue forKey:PURCHASE_CARD_INFO_FLAG];
    [tableViewData reloadData];
}

#pragma mark - Button Month
- (IBAction)btnMonth:(UIButton *)sender
{
    [self setDataPicker:@"month"];
}

#pragma mark - Button Age
- (IBAction)btnAge:(UIButton *)sender
{
    [self setDataPicker:@"year"];
}

#pragma mark - set data picker
- (void)setDataPicker:(NSString *)type
{
    NSDateFormatter *dateFormatter   = [[NSDateFormatter alloc] init];
    NSLocale *localeTMP              = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_Br"];
    [dateFormatter setLocale:localeTMP];
    [dateFormatter setDateFormat:@"yyyy"];
    
    infoPicker = [NSMutableArray new];
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:nil
                                     cancelButtonTitle:@""
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    
    if ([type isEqualToString:@"month"]) {
        [actionSheet setAccessibilityValue:@"month"];
        for(int months = 0; months < 12; months++)
            [infoPicker addObject:[[NSString stringWithFormat:@"%@",[[dateFormatter monthSymbols]objectAtIndex: months]]capitalizedString]];
    } else {
        int yearCurrent = [[dateFormatter stringFromDate:[NSDate date]] intValue];
        for (int i = yearCurrent; i <= yearCurrent + 10; i++)
            [infoPicker addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    [actionSheet setAccessibilityValue:type];
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 0, 0, 0);
    
    pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    [pickerView setBackgroundColor:[UIColor whiteColor]];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    [actionSheet addSubview:pickerView];
    
    UIToolbar *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    pickerDateToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerDateToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"Confirmar" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissActionSheet:)];
    
    [barItems addObject:doneBtn];
    [pickerDateToolbar setItems:barItems animated:YES];
    [actionSheet addSubview:pickerDateToolbar];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 360)];
}

#pragma mark - picker Components
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

#pragma mark - picker Row
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [infoPicker count];
}

#pragma mark - picker Content
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [infoPicker objectAtIndex:row];
}

#pragma mark - picker Dissmiss
- (void)dismissActionSheet:(UISegmentedControl*)sender
{
    if ([actionSheet.accessibilityValue isEqualToString:@"month"])
        [cardInfos setObject:[infoPicker objectAtIndex:[pickerView selectedRowInComponent:0]]
                      forKey:PURCHASE_CARD_INFO_MONTH];
    else
        [cardInfos setObject:[infoPicker objectAtIndex:[pickerView selectedRowInComponent:0]]
                      forKey:PURCHASE_CARD_INFO_YEAR];
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    [tableViewData reloadData];
}

#pragma mark - Button Done
- (IBAction)btnDone:(UIButton *)sender
{
    [self setInfoTextView:txtViewSelected];
    [txtViewSelected resignFirstResponder];
}

#pragma mark - Button Cancel
- (IBAction)btnCancel:(UIButton *)sender
{
    [txtViewSelected setText:@""];
    [self setInfoTextView:txtViewSelected];
}

#pragma mark - Button confirm to Next Screen
- (IBAction)btnConfirm:(UIButton *)sender
{
    [otlWait startAnimating];
    if ([BuyInfoCard validate:cardInfos]) {
        if (![productValue isEqualToString:@""])
            [self connectionBuy];
        else
            [self connectionBudget];
    }else
        [otlWait stopAnimating];
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
        [cardInfos setValue:textField.text forKey:textField.accessibilityValue];
}

#pragma mark - scroll Ajust
- (void)upScreen:(UITextView *)textView
{
    float sizeCenter = [listInfoDataStart count] * 60;
    int extraSize = 20;
    if (textView.inputAccessoryView != NULL)
        extraSize = 60;
    
    CGRect textFieldRect = CGRectMake( textView.frame.origin.x, textView.frame.origin.y + sizeCenter + extraSize,
                                      textView.frame.size.width, textView.frame.size.height);
    
    [AppFunctions SCROLL_RECT_TO_CENTER:textFieldRect
                               animated:YES
                              tableView:tableViewData];
}

#pragma mark - Init list traveller's
- (void)startListTraveller
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
        [_rgs        appendString:[NSString stringWithFormat:@" 1,"]];
        [_cpfs       appendString:[NSString stringWithFormat:@"%@,",[[traveler objectForKey:CADASTRO_PERSON_CPF]
                                                                     stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [_emails     appendString:[NSString stringWithFormat:@"%@,",[[traveler objectForKey:CADASTRO_PERSON_MAIL]
                                                                     stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [_telefones  appendString:[NSString stringWithFormat:@"%@,",[[traveler objectForKey:CADASTRO_PERSON_FONE]
                                                                     stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
}

#pragma mark - Connection to prepare Budget
- (void)connectionBudget
{
    [self startListTraveller];
    linkBudget = [NSString stringWithFormat:WS_URL_BUY_BUDGET_INFO,
                   KEY_CODE_ACTION, KEY_EMPTY, KEY_CODE_SITE_TRAVEL, KEY_CODE_PORTAL,
                  [purchaseProduct objectForKey:PURCHASE_DATA_TRAVEL_INFO_PLAN_CODE],
                  [[purchaseAllInfo objectForKey:PURCHASE_INFO_PRODUCT]  objectForKey:PURCHASE_DATA_TRAVEL_DATA_START],
                  [[purchaseAllInfo objectForKey:PURCHASE_INFO_PRODUCT]  objectForKey:PURCHASE_DATA_TRAVEL_DATA_END],
                  [purchaseProduct objectForKey:PURCHASE_DATA_TRAVEL_PAX],
                  _nomes, _sobrenomes, _idades, _sexos,
                  _rgs, _cpfs, _emails, _telefones,
                  [[purchaseAllInfo objectForKey:PURCHASE_INFO_PRODUCT]  objectForKey:PURCHASE_DATA_TRAVEL_DESTINY],
                  KEY_EMPTY, [[purchaseAllInfo objectForKey:PURCHASE_INFO_SELLER]objectForKey:@"codigoVendedor"]];
    linkBudget = [NSString stringWithFormat:WS_URL, WS_URL_BUY_NEW_BUDGET, linkBudget];
    [self startConnection:linkBudget step:1];
}

#pragma mark - Connection to prepare Info Purchase
- (void)connectionInfoPurchase
{
    linkProduct = [NSString stringWithFormat:WS_URL_BUY_PURCHASE_INFO,
                   KEY_CODE_SITE_TRAVEL,
                   productID,
                   KEY_CODE_STATUS,
                   _nomes, _sobrenomes, _idades, _sexos,
                   _rgs, _cpfs, _emails, _telefones,
                   KEY_EMPTY];
    linkProduct = [NSString stringWithFormat:WS_URL, WS_URL_BUY_NEW_PURCHASE, linkProduct];
    [self startConnection:linkProduct step:2];
}

#pragma mark - Connection to prepare Purchase
- (void)connectionBuy
{
    [otlWait stopAnimating];
    linkPurchase = [NSString stringWithFormat:WS_URL_BUY_REGISTER_INFO,
                    KEY_CODE_SITE_TRAVEL,
                    [[purchaseAllData objectForKey:PURCHASE_INFO_PRODUCT_RESERVE]objectForKey:TAG_BUY_PURCHASE_CODE_RESERVA],
                    KEY_BUY_TYPE,
                    [cardInfos objectForKey:PURCHASE_CARD_INFO_FLAG],
                    productValue,
                    [cardInfos objectForKey:PURCHASE_CARD_INFO_PACERLS],
                    [cardInfos objectForKey:PURCHASE_CARD_INFO_NUMBER],
                    [cardInfos objectForKey:PURCHASE_CARD_INFO_MONTH],
                    [cardInfos objectForKey:PURCHASE_CARD_INFO_YEAR],
                    [cardInfos objectForKey:PURCHASE_CARD_INFO_NAME],
                    [cardInfos objectForKey:PURCHASE_CARD_INFO_COD]];
    linkPurchase = [NSString stringWithFormat:WS_URL, WS_URL_BUY_REGISTER, linkPurchase];
    [self startConnection:linkPurchase step:3];
}

#pragma mark - Start Connection
- (void)startConnection:(NSString *)_link step:(int)_step
{
    NSDictionary *labelConnections;
    if (_step == 1)
        labelConnections = @{APP_CONNECTION_TAG_START  : BUY_POTA_CONNECTION_START,
                             APP_CONNECTION_TAG_WAIT 	 : BUY_POTA_CONNECTION_WAIT,
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

#pragma mark - recive Budget
- (void)reciveBudget:(NSDictionary *)info
{
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
    [self connectionInfoPurchase];
}

#pragma mark - recive Budget
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

#pragma mark - recive Buy
- (void)reciveBuy:(NSDictionary *)info
{
    NSString *VOLCHER = [info objectForKey:TAG_BUY_VOUCHER];
    if (VOLCHER == NULL || [VOLCHER isEqualToString:@"-"]) {
        [AppFunctions LOG_MESSAGE:@"Erro no web service de cartão."
                          message:@"O web service não retornou nenhum volcher."
                           cancel:ERROR_BUTTON_CANCEL];
        return;
    }
    
    [self initValues];
    
    [purchaseAllData setObject:VOLCHER forKey:PURCHASE_INFO_VOLCHER];
    
    [AppFunctions CLEAR_INFORMATION];
    [AppFunctions SAVE_INFORMATION:purchaseAllData
                               tag:PURCHASE];
    
    if ([purchaseType isEqualToString:PURCHASE_TYPE_TRAVEL])
        [self addInfoTravel];
    else if ([purchaseType isEqualToString:PURCHASE_TYPE_HOTEL])
        [self addInfoHotel];
    else if ([purchaseType isEqualToString:PURCHASE_TYPE_PACKGE])
        [self addInfoPackge];
    
    [AppFunctions LOG_MESSAGE:BUY_CARD_TITLE_SUCCESS
                      message:[NSString stringWithFormat:BUY_CARD_MESSAGE_SUCCESS, [purchaseAllData objectForKey:PURCHASE_INFO_VOLCHER]]
                       cancel:ERROR_BUTTON_CANCEL];
    
    [self performSegueWithIdentifier:STORY_BOARD_BUY_VOLCHER sender:self];
}

- (void)addInfoTravel
{
    NSMutableArray *data = [[NSMutableArray alloc]initWithArray:listSavePurchase];
    
    [data addObject:@{ PURCHASE_INFO_AGENCY            : [purchaseAllData objectForKey:PURCHASE_INFO_AGENCY],
                       PURCHASE_INFO_PURCHASE_CONTRACT : [purchaseAllData objectForKey:PURCHASE_INFO_PURCHASE_CONTRACT],
                       PURCHASE_INFO_PURCHASE_DETAILS  : [purchaseAllData objectForKey:PURCHASE_INFO_PURCHASE_DETAILS],
                       PURCHASE_INFO_BUDGET            : [purchaseAllData objectForKey:PURCHASE_INFO_BUDGET],
                       PURCHASE_INFO_PRODUCT           : [purchaseAllData objectForKey:PURCHASE_INFO_PRODUCT],
                       PURCHASE_INFO_PRODUCT_RESERVE   : [purchaseAllData objectForKey:PURCHASE_INFO_PRODUCT_RESERVE],
                       PURCHASE_INFO_SELLER            : [purchaseAllData objectForKey:PURCHASE_INFO_SELLER],
                       PURCHASE_TYPE_PERSON_DATA       : [purchaseAllData objectForKey:PURCHASE_TYPE_PERSON_DATA],
                       PURCHASE_INFO_VOLCHER           : [purchaseAllData objectForKey:PURCHASE_INFO_VOLCHER],
                       PURCHASE_TYPE                   : [purchaseAllData objectForKey:PURCHASE_TYPE],
                    }];
    
    BOOL result = [data writeToFile:[AppFunctions PLIST_SAVE:PLIST_PURCHASES]
                         atomically:YES];
    if (!result)
        NSLog(@"Save fail");
}

- (void)addInfoHotel
{
    [purchaseAllData setObject:@" " forKey:PURCHASE_INFO_PURCHASE_DETAILS];
}

- (void)addInfoPackge
{
    [purchaseAllData setObject:@" " forKey:PURCHASE_INFO_PURCHASE_DETAILS];
}

- (void)initValues
{
    listSavePurchase = [AppFunctions PLIST_ARRAY_LOAD:PLIST_PURCHASES];
    if (listSavePurchase == nil)
        listSavePurchase = [AppFunctions PLIST_ARRAY_PATH:PLIST_PURCHASES type:@"plist"];
}

@end
