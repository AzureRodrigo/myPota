//
//  cadastrePurchase.h
//  myPota
//
//  Created by Rodrigo Pimentel on 06/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "t4_Travel_Select_Plan.h"

#pragma mark - travel cell
#import "cadastreCell_TravelPeople.h"
#import "cadastreCell_TravelCustos.h"


#pragma mark - hotel cell

#pragma mark - package cell
#import "p2_Package_Info_Cell_Price.h"
#import "p2_Package_Info_Cell_Button.h"

#pragma mark - generic cell
#import "cadastreCell_Info.h"
#import "cadastreCell_Confirm.h"

#define CADASTRO_INFO_TITLE          @"title"
#define CADASTRO_INFO_SCREEN         @"path"

#define CADASTRO_NEXT_SCREEN_COBERTURAS @"goTo Coberturas"
#define CADASTRO_NEXT_SCREEN_CONDICOES  @"goTo Condições"
#define CADASTRO_NEXT_SCREEN_PACK_COND  @"goTo PACK Condiction"
#define CADASTRO_NEXT_SCREEN_PACK_INFO  @"goTo PACK Informaçoes"
#define CADASTRO_NEXT_SCREEN_PACK_DAY   @"goTo PACK Dia a Dia"

#define SIZE_CELL_HEIGHT_TAG_0_CLOSE 40
#define SIZE_CELL_HEIGHT_TAG_0_OPEN  515

#define SIZE_START 158
#define SIZE_PLUS  20

@interface cadastrePurchase : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{

#pragma mark - Screen Purchase Data
    NSMutableDictionary *purchaseData;
    NSDictionary        *purchaseInfo;
    NSString            *purchaseType;
    
#pragma mark - Screen Data
    IBOutlet UITableView *tableViewData;
    NSString             *lblTitlePurchase;
    NSString             *lblTitleConfirm;

#pragma mark - Next Screen Info
    NSString             *lblNextScreenType;
    
#pragma mark - type Data
    NSMutableArray       *listPeopleData;
    NSMutableDictionary  *listPurchaseData;
    NSArray              *listInfoData;
    
    NSDictionary        *infoCircuit;
    int                  infoCircuitPriceSize;
    
#pragma mark - textView
    UITextField          *txtViewSelected;
}

#pragma mark - function for next screen
- (NSString *)getTypeInfoScreen;
- (NSString *)getLinkData;

@end
