//
//  purchasePurchaseInfo.m
//  myPota
//
//  Created by Rodrigo Pimentel on 12/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "d1_Deal_Data_Info.h"

@implementation d1_Deal_Data_Info

- (void)configNavBar
{
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:typeScreen
                                                               attributes:@{ NSForegroundColorAttributeName: [UIColor whiteColor],
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

#pragma mark - WillAppear
- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [tableViewData reloadData];
    [super viewWillAppear:animated];
}

- (void)configScreenData
{
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    [tableViewData setSeparatorColor:[UIColor clearColor]];
    
    backScreen     = [AppFunctions BACK_SCREEN:self number:1];
    dataScreen     = [backScreen getInfos];
    typeScreen     = [dataScreen objectForKey:@"type"];
    typeProduct    = [[dataScreen objectForKey:@"content"]objectForKey:PURCHASE_TYPE];
    infoData       = [dataScreen objectForKey:@"content"];
    
//    NSLog(@"%@",infoData);
    
    tableList     = [NSArray new];
    tableOn       = 0;
    tableCellSize = 60;
    
    if ([typeScreen isEqualToString:CADASTRO_NEXT_SCREEN_CONDICOES]) {
        [webView setHidden:NO];
        NSArray *infoContract = [infoData objectForKey:PURCHASE_INFO_PURCHASE_CONTRACT];
        [self configWebView:[infoContract objectAtIndex:0]];
    }
    //    } else if ([typeScreen isEqualToString:CADASTRO_NEXT_SCREEN_CONDICOES]) {
    //        [tableViewData setHidden:YES];
    //        NSArray *infoContract      = [infoData objectForKey:PURCHASE_INFO_PURCHASE_CONTRACT];
    //        NSMutableDictionary *infos = [infoContract objectAtIndex:0];
    //        NSData *htmlFile         = [infos objectForKey:CONTRATO_INFO_DESCRICAO];
    //        [webView loadData:htmlFile MIMEType: @"text/html" textEncodingName: @"UTF-8" baseURL:nil];
    //        [webView setScalesPageToFit:YES];
    //    }else if ([typeScreen isEqualToString:CADASTRO_NEXT_SCREEN_SECURE]) {
    //
    //    }
}

#pragma mark - DidLoad
- (void)viewDidLoad
{
    [self configScreenData];
    [super viewDidLoad];
}

#pragma mark - config TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableOn;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableCellSize;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([typeScreen isEqualToString:CADASTRO_NEXT_SCREEN_COBERTURAS])
        [self configCell_Cobertura:tableView cellForRowAtIndexPath:indexPath];
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([typeScreen isEqualToString:CADASTRO_NEXT_SCREEN_COBERTURAS])
        [self pressCell_Cobertura:indexPath];
}

#pragma mark - config Cell
- (UITableViewCell *)configCell_Cobertura:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [tableView dequeueReusableCellWithIdentifier:@"CellTravel" forIndexPath:indexPath];
    return cell;
}

#pragma mark - press Cell
- (void)pressCell_Cobertura:(NSIndexPath *)indexPath
{
    
}

#pragma mark - config WebView
- (void)configWebView:(NSDictionary *)content
{
    if ([typeProduct isEqualToString:PURCHASE_TYPE_TRAVEL]){
        NSData *htmlFile         = [content objectForKey:CONTRATO_INFO_DESCRICAO];
        [webView loadData:htmlFile MIMEType: @"text/html" textEncodingName: @"UTF-8" baseURL:nil];
        [webView setScalesPageToFit:YES];
    }else if ([typeProduct isEqualToString:PURCHASE_TYPE_HOTEL]){
        
    }else if ([typeProduct isEqualToString:PURCHASE_TYPE_PACKGE]){
        [webView loadHTMLString:[content objectForKey:@"string"] baseURL:nil];
        [webView setScalesPageToFit:YES];
    }
}

@end
