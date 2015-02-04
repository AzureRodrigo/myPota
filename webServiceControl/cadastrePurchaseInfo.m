//
//  cadastrePurchaseInfo.m
//  myPota
//
//  Created by Rodrigo Pimentel on 12/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "cadastrePurchaseInfo.h"

@implementation cadastrePurchaseInfo

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
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setSeparatorColor:[UIColor clearColor]];
    
    backScreen     = (cadastrePurchase *)[AppFunctions BACK_SCREEN:self number:1];
    typeScreen     = [backScreen getTypeInfoScreen];
    
    
    NSLog(@"%@",typeScreen);
    
    infoData       = [[NSMutableDictionary alloc]initWithDictionary:[AppFunctions LOAD_INFORMATION:PURCHASE]];
    listInfo       = [infoData objectForKey:PURCHASE_INFO_PURCHASE_DETAILS];
    if ([typeScreen isEqualToString:CADASTRO_NEXT_SCREEN_COBERTURAS]){
        [webView setHidden:YES];
        [lblTitle setText:@"Coberturas do Plano"];
    } else if ([typeScreen isEqualToString:CADASTRO_NEXT_SCREEN_CONDICOES]) {
        [tableViewData setHidden:YES];
        [lblTitle setText:@"Condições Gerais"];
        NSArray *infoContract      = [infoData objectForKey:PURCHASE_INFO_PURCHASE_CONTRACT];
        NSMutableDictionary *infos = [infoContract objectAtIndex:0];
        NSData *htmlFile         = [infos objectForKey:CONTRATO_INFO_DESCRICAO];
        [webView loadData:htmlFile MIMEType: @"text/html" textEncodingName: @"UTF-8" baseURL:nil];
        [webView setScalesPageToFit:YES];
    } else if ([typeScreen isEqualToString:CADASTRO_NEXT_SCREEN_PACK_COND]){
        NSDictionary *list = [[backScreen getLinkData]copy];
        [lblTitle setText:@"Condições Gerais"];
        [webView loadHTMLString:[list objectForKey:PACKAGE_INFO_HTML_GENERAL_CONDICTIONS] baseURL:nil];
        [webView setScalesPageToFit:YES];
        
    } else if ([typeScreen isEqualToString:CADASTRO_NEXT_SCREEN_PACK_INFO]){
        NSDictionary *list = [[backScreen getLinkData]copy];
        [lblTitle setText:@"Informações Sobre o Roteiro"];
        [webView loadHTMLString:[list objectForKey:PACKAGE_INFO_HTML_IS_INCLUDE] baseURL:nil];
        [webView setScalesPageToFit:YES];
        
    } else if ([typeScreen isEqualToString:CADASTRO_NEXT_SCREEN_PACK_DAY]){
        NSDictionary *list = [[backScreen getLinkData]copy];
        [lblTitle setText:@"Dia a Dia"];
        [webView loadHTMLString:[list objectForKey:PACKAGE_INFO_HTML_DAY_FOR_DAY] baseURL:nil];
        [webView setScalesPageToFit:YES];
    }
    
}

#pragma mark - Number of Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([typeScreen isEqualToString:CADASTRO_NEXT_SCREEN_COBERTURAS])
        return 1;
    return 0;
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
    if ([typeScreen isEqualToString:CADASTRO_NEXT_SCREEN_COBERTURAS])
        return 60;
    return 100;
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([typeScreen isEqualToString:CADASTRO_NEXT_SCREEN_COBERTURAS])
        return [listInfo count];
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([typeScreen isEqualToString:CADASTRO_NEXT_SCREEN_COBERTURAS]) {
        cadastreInfoCellTravel *cell = [tableView dequeueReusableCellWithIdentifier:@"CellTravel" forIndexPath:indexPath];
        NSMutableDictionary *infos = [listInfo objectAtIndex:[indexPath row]];
        [infos objectForKey:@"code"];
        [cell.lblName setText:[infos objectForKey:@"info"]];
        [cell.lblSub setText:[infos objectForKey:@"price"]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }
    return nil;
}


#pragma mark - Cell config sector 4
- (UITableViewCell *)setSection4:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    cadastreCell_Confirm *cell = [tableView dequeueReusableCellWithIdentifier:@"CellConfirm"
                                                                 forIndexPath:indexPath];
//    [cell setBackgroundColor:[UIColor clearColor]];
//    [cell.otlButtonConfirm addTarget:self action:@selector(btnConfirm:)
//                    forControlEvents:UIControlEventTouchUpInside];
//    [cell.otlButtonConfirm setTitle:lblTitleConfirm forState:UIControlStateNormal];
//    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([typeScreen isEqualToString:CADASTRO_NEXT_SCREEN_COBERTURAS]) {
        NSMutableDictionary *infos = [listInfo objectAtIndex:[indexPath row]];
        if (![[infos objectForKey:@"descrition"] isEqualToString:@""])
            [AppFunctions LOG_MESSAGE:[infos objectForKey:@"info"]
                              message:[infos objectForKey:@"descrition"]
                               cancel:ERROR_BUTTON_CANCEL];
    }
}


@end
