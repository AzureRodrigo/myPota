//
//  travelPackges.m
//  myPota
//
//  Created by Rodrigo Pimentel on 09/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "t4_Travel_Select_Plan.h"

@implementation t4_Travel_Select_Plan

- (void)initScreenData
{
    
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setSeparatorColor:[UIColor clearColor]];
    
    backScreen      = (t0_Travel *)[AppFunctions BACK_SCREEN:self number:1];
    purchaseData    = [backScreen getPurchaseData];
    
    
    link            = [[purchaseData objectForKey:PURCHASE_INFO_PRODUCT]objectForKey:PURCHASE_DATA_TRAVEL_LINK_PLAN];
    
    NSLog(@"link %@", link);
    
    listPlans       = [NSMutableArray new];
    [self startConnection];
    [otlLoad startAnimating];
    
    [otlPlans       setText:[[purchaseData objectForKey:PURCHASE_INFO_PRODUCT] objectForKey:PURCHASE_DATA_TRAVEL_DESTINY]];
    [lblDataStart   setText:[[purchaseData objectForKey:PURCHASE_INFO_PRODUCT] objectForKey:PURCHASE_DATA_TRAVEL_DATA_START]];
    [lblDataEnd     setText:[[purchaseData objectForKey:PURCHASE_INFO_PRODUCT] objectForKey:PURCHASE_DATA_TRAVEL_DATA_END]];
    [lblPax         setText:[[purchaseData objectForKey:PURCHASE_INFO_PRODUCT] objectForKey:PURCHASE_DATA_TRAVEL_PAX]];
    [lblDays        setText:[[purchaseData objectForKey:PURCHASE_INFO_PRODUCT] objectForKey:PURCHASE_DATA_TRAVEL_DAYS]];
    
    [otlPlans   setAdjustsFontSizeToFitWidth:YES];
    [lblDataStart setAdjustsFontSizeToFitWidth:YES];
    [lblDataEnd setAdjustsFontSizeToFitWidth:YES];
    [lblPax     setAdjustsFontSizeToFitWidth:YES];
    [lblDays    setAdjustsFontSizeToFitWidth:YES];
}

#pragma mark - didLoad
- (void)viewDidLoad
{
    [self initScreenData];
    [super viewDidLoad];
}

#pragma mark -configNavBar
- (void)configNavBar
{
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:@"Planos Disponiveis"
                                                               attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                            NSFontAttributeName: [UIFont fontWithName:FONT_NAME_BOLD size:18]}];
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_GENERIC
                                     title:title
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
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - willAppear
- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [super viewWillAppear:animated];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listPlans count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    t4_Travel_Select_Plan_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    travelPlans *plan = [listPlans objectAtIndex:[indexPath row]];
    [cell.lblName setText:plan.nomePlano];
    float value = [[plan.valorPlanoReais stringByReplacingOccurrencesOfString:@","
                                                                   withString:@"."] floatValue];
    [cell.lblPricePlano setText:[NSString stringWithFormat:@"R$ %.02f",value]];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    [cell.lblMaxAge setText:plan.limiteIdade];
    [cell.lblPriceCobertura setText:plan.valorCobertura];
    
    
    [cell.btnInfo setTag:[indexPath row]];
    [cell.btnBuy  setTag:[indexPath row]];
    
    [cell.btnInfo addTarget:self action:@selector(btnInfoSel:)
           forControlEvents:UIControlEventTouchUpInside];
    [cell.btnBuy addTarget:self action:@selector(btnBuySel:)
          forControlEvents:UIControlEventTouchUpInside];
    
    [cell.lblName setAdjustsFontSizeToFitWidth:YES];
    [cell.lblPriceCobertura setAdjustsFontSizeToFitWidth:YES];
    [cell.lblPricePlano setAdjustsFontSizeToFitWidth:YES];
    [cell.lblMaxAge setAdjustsFontSizeToFitWidth:YES];
    
    return cell;
}

- (IBAction)btnInfoSel:(UIButton *)sender
{
    planSELECT = [listPlans objectAtIndex:sender.tag];
    [[purchaseData objectForKey:PURCHASE_INFO_PRODUCT] setObject:planSELECT forKey:PURCHASE_DATA_TRAVEL_PLAN_SELECTED];
    [AppFunctions GO_TO_SCREEN:self destiny:SEGUE_T4_TO_T5];
}

- (IBAction)btnBuySel:(UIButton *)sender
{
    planSELECT = [listPlans objectAtIndex:sender.tag];
    
    [[purchaseData objectForKey:PURCHASE_INFO_PRODUCT] setObject:@{ PURCHASE_DATA_TRAVEL_INFO_PLAN_CODE         : planSELECT.codigoPlano,
                                                                    PURCHASE_DATA_TRAVEL_INFO_PLAN_DESCRITION   : planSELECT.descricaoPlano,
                                                                    PURCHASE_DATA_TRAVEL_INFO_PLAN_NAME         : planSELECT.nomePlano,
                                                                    PURCHASE_DATA_TRAVEL_INFO_PLAN_VALUE        : planSELECT.valorPlanoReais,
                                                                    PURCHASE_DATA_TRAVEL_INFO_PLAN_MAX_AGE      : planSELECT.limiteIdade,
                                                                    PURCHASE_DATA_TRAVEL_INFO_PLAN_VALUE_SECURE : planSELECT.valorCobertura }
                                                          forKey:PURCHASE_DATA_TRAVEL_PLAN_SELECTED];
    
    [purchaseData setObject:PURCHASE_TYPE_TRAVEL forKey:PURCHASE_TYPE];
    
    NSLog(@"%@", purchaseData);
//    [self startConnectionPlan];
}

#pragma mark - connection Plan and Geral
- (void)startConnectionPlan
{
    NSString* IDWS = @"TESTE_WS_VITALCARD";//[[purchaseData objectForKey:PURCHASE_INFO_AGENCY]objectForKey:AGENCY_DATA_IDWS];
    if ([IDWS isEqualToString:@""])
        IDWS = KEY_ID_WS_TRAVEL;
    NSString *linkInfoPlan = [NSString stringWithFormat:WS_URL_TRAVEL_INFO, KEY_CODE_SITE_TRAVEL,
                              KEY_CODE_PRODUCT_TRAVEL, [[[purchaseData objectForKey:PURCHASE_INFO_PRODUCT]objectForKey:PURCHASE_DATA_TRAVEL_PLAN_SELECTED] objectForKey:PURCHASE_DATA_TRAVEL_INFO_PLAN_CODE]];
    
    linkInfoPlan           = [NSString stringWithFormat:WS_URL, WS_URL_TRAVEL, linkInfoPlan];
    
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : TRAVEL_PACKGES_CONNECTION_START,
                                       APP_CONNECTION_TAG_WAIT 	 : TRAVEL_PACKGES_CONNECTION_WAIT,
                                       APP_CONNECTION_TAG_RECIVE : TRAVEL_PACKGES_CONNECTION_RECIVE,
                                       APP_CONNECTION_TAG_FINISH : TRAVEL_PACKGES_CONNECTION_FINISH,
                                       APP_CONNECTION_TAG_ERROR  : TRAVEL_PACKGES_CONNECTION_ERROR };
    
    [appConnection START_CONNECT:linkInfoPlan timeForOu:15.F labelConnection:labelConnections showView:YES block:^(NSData *result) {
        if (result == nil) {
            [AppFunctions LOG_MESSAGE:ERROR_1013_TITLE
                              message:ERROR_1013_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
            
        } else {
            NSDictionary *allPlans  = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:TAG_TRAVEL_PLAN_INFO];
            NSMutableArray *tagInfo = [NSMutableArray new];
            for (NSDictionary *tmp in [allPlans objectForKey:TAG_TRAVEL_PLAN_INFO])
                [tagInfo addObject:[@{
                                      @"code"  : [tmp objectForKey:@"CodCobertura"],
                                      @"info"  : [tmp objectForKey:@"DscCobertura"],
                                      @"price" : [tmp objectForKey:@"VlrCobertura"],
                                      @"descrition" : [tmp objectForKey:@"ObsCobertura"]
                                      } mutableCopy]];
            
            [purchaseData setObject:tagInfo forKey:PURCHASE_INFO_PURCHASE_DETAILS];
            
            [self startConnectionContract];
        }
    }];
}

#pragma mark - connection Contratc
- (void)startConnectionContract
{
    NSString *IDWS = @"TESTE_WS_VITALCARD";//[[purchaseData objectForKey:PURCHASE_INFO_AGENCY]objectForKey:AGENCY_DATA_IDWS];
    if ([IDWS isEqualToString:@""])
        IDWS = KEY_ID_WS_TRAVEL;
    
    NSString *linkInfoPlan = [NSString stringWithFormat:WS_URL_TRAVEL_INFO_CONTRACT, KEY_CODE_SITE_TRAVEL,KEY_CODE_PORTAL,KEY_EMPTY,
                              [[[purchaseData objectForKey:PURCHASE_INFO_PRODUCT]objectForKey:PURCHASE_DATA_TRAVEL_PLAN_SELECTED] objectForKey:PURCHASE_DATA_TRAVEL_INFO_PLAN_CODE]];
    linkInfoPlan           = [NSString stringWithFormat:WS_URL, WS_URL_TRAVEL_CONTRACT, linkInfoPlan];
    
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : TRAVEL_PACKGES_CONNECTION_START,
                                       APP_CONNECTION_TAG_WAIT 	 : TRAVEL_PACKGES_CONNECTION_WAIT,
                                       APP_CONNECTION_TAG_RECIVE : TRAVEL_PACKGES_CONNECTION_RECIVE,
                                       APP_CONNECTION_TAG_FINISH : TRAVEL_PACKGES_CONNECTION_FINISH,
                                       APP_CONNECTION_TAG_ERROR  : TRAVEL_PACKGES_CONNECTION_ERROR };
    
    [appConnection START_CONNECT:linkInfoPlan timeForOu:15.F labelConnection:labelConnections showView:YES block:^(NSData *result) {
        if (result == nil) {
            [AppFunctions LOG_MESSAGE:ERROR_1013_TITLE
                              message:ERROR_1013_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
        } else {
            NSDictionary *allError  = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:@"Erro"];
            for (NSString *tmp in [allError objectForKey:@"CodErro"])
            {
                [AppFunctions LOG_MESSAGE:ERROR_1013_TITLE
                                  message:tmp
                                   cancel:ERROR_BUTTON_CANCEL];
                return;
            }
            NSDictionary *allPlans  = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:TAG_TRAVEL_PLAN_INFO_CONTRACT];
            NSMutableArray *tagInfo = [NSMutableArray new];
            for (NSDictionary *tmp in [allPlans objectForKey:TAG_TRAVEL_PLAN_INFO_CONTRACT])
                [tagInfo addObject:[@{
                                      CONTRATO_INFO_COD_SITE               : [tmp objectForKey:@"CodSite"],
                                      CONTRATO_INFO_COD_PORTAL             : [tmp objectForKey:@"CodPortal"],
                                      CONTRATO_INFO_COD_FORNECEDOR         : [tmp objectForKey:@"CodFornecedor"],
                                      CONTRATO_INFO_NOME_FORNECEDOR        : [tmp objectForKey:@"NomFornecedor"],
                                      CONTRATO_INFO_COD_PRODUTO            : [tmp objectForKey:@"CodProduto"],
                                      CONTRATO_INFO_COD_CONTRATO           : [tmp objectForKey:@"CodContrato"],
                                      CONTRATO_INFO_TIPO_CONTRATO_PRODUTO  : [tmp objectForKey:@"TpoProdutoContrato"],
                                      CONTRATO_INFO_TIPO_CONTRATO          : [tmp objectForKey:@"TitContrato"],
                                      CONTRATO_INFO_DESCRICAO              : [[tmp objectForKey:@"DscContrato"] dataUsingEncoding:NSUTF8StringEncoding]
                                      } mutableCopy]];
            
            [purchaseData setObject:tagInfo forKey:PURCHASE_INFO_PURCHASE_CONTRACT];
            
            [AppFunctions CLEAR_INFORMATION];
            [AppFunctions SAVE_INFORMATION:purchaseData
                                       tag:PURCHASE];
            
            [self performSegueWithIdentifier:STORY_BOARD_TRAVEL_CADASTRE sender:self];
        }
    }];
}

#pragma mark - connection
- (void)startConnection
{
    [lblLoad setText:@"Carregando planos aguarde"];
    
    NSDictionary *labelConnections = @{APP_CONNECTION_TAG_START  : TRAVEL_PACKGES_CONNECTION_START,
                                       APP_CONNECTION_TAG_WAIT 	 : TRAVEL_PACKGES_CONNECTION_WAIT,
                                       APP_CONNECTION_TAG_RECIVE : TRAVEL_PACKGES_CONNECTION_RECIVE,
                                       APP_CONNECTION_TAG_FINISH : TRAVEL_PACKGES_CONNECTION_FINISH,
                                       APP_CONNECTION_TAG_ERROR  : TRAVEL_PACKGES_CONNECTION_ERROR };
    
    [appConnection START_CONNECT:link timeForOu:15.F labelConnection:labelConnections showView:NO block:^(NSData *result) {
        
        if (result == nil) {
            [AppFunctions LOG_MESSAGE:ERROR_1013_TITLE
                              message:ERROR_1013_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
            
            [lblLoad setText:ERROR_1013_MESSAGE];
            [otlLoad stopAnimating];
            [otlLoad setHidden:YES];
            [tableViewData  reloadData];
        }else {
            
            NSDictionary *allPlans = (NSDictionary *)[[AzParser alloc] xmlDictionary:result tagNode:TAG_TRAVEL_PLAN];
            for (NSDictionary *tmp in [allPlans objectForKey:TAG_TRAVEL_PLAN])
            {
                travelPlans *plan = [[travelPlans alloc]initVendedor:tmp];
                [listPlans addObject:plan];
            }
            
            [lblLoad setHidden:YES];
            [otlLoad stopAnimating];
            [otlLoad setHidden:YES];
            
            
            [listPlans sortUsingComparator:^(id obj1, id obj2){
                
                travelPlans *p1 = (travelPlans *)obj1;
                travelPlans *p2 = (travelPlans *)obj2;
                
                if ([p1.valorPlanoReais floatValue] > [p2.valorPlanoReais floatValue])
                    return (NSComparisonResult)NSOrderedDescending;
                if ([p1.valorPlanoReais floatValue] < [p2.valorPlanoReais floatValue])
                    return (NSComparisonResult)NSOrderedAscending;
                
                return (NSComparisonResult)NSOrderedSame;
            }];
            
            
            [tableViewData reloadData];
        }
    }];
}

#pragma mark - get purchase data
- (NSMutableDictionary *)getPurchaseData
{
    return purchaseData;
}

@end