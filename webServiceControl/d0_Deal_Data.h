//  d0_Deal_Data.h
//  myPota
//
//  Created by Rodrigo Pimentel on 11/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark cell's
#import "BuyInfoStart.h"
#import "BuyInfoCard.h"
#import "BuyInfoCustos.h"
#import "BuyInfoTravellers.h"
#import "BuyInfoEnd.h"
#import "BuyInfoPurchase.h"
#import "p2_Package_Info_Cell_Price.h"

#import "Vendedor.h"

#define PURCHASE_INFO_TITLE          @"title"
#define PURCHASE_INFO_SCREEN         @"path"

#define CADASTRO_NEXT_SCREEN_SECURE     @"goTo Segurança"
#define CADASTRO_NEXT_SCREEN_COBERTURAS @"goTo Coberturas"
#define CADASTRO_NEXT_SCREEN_CONDICOES  @"Condições Gerais"


@interface d0_Deal_Data : UIViewController <UITableViewDelegate, UITableViewDataSource,  UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
#pragma mark - Screen Purchase Data
    NSMutableDictionary     *purchaseAllData;
    NSDictionary            *purchaseAllInfo;
    NSString                *purchaseType;
    NSArray                 *purchaseTravellers;
    NSString	            *lblTitleTravellers;
    NSMutableDictionary     *purchaseProduct;
    NSString                *lblTitlePurchase;
    NSArray                 *listInfoDataStart;
    NSArray                 *listInfoDataEnd;
    NSMutableDictionary     *cardInfos;
    NSDictionary            *myAgency;
    NSDictionary            *mySeller;
    NSMutableDictionary     *purchaseInfo;
    int                     cellPriceSize;
    
    
#pragma mark - Screen Data
    IBOutlet UITableView    *tableViewData;
    UITextField             *txtViewSelected;
    UIActivityIndicatorView *otlWait;
    
    UIView                  *maskView;
    UIPickerView            *_providerPickerView;
    UIToolbar               *_providerToolbar;
    
    NSMutableArray          *infoPicker;
    NSString                *lblNextScreenType;
#pragma mark - Connection
    NSString                *IDWS;
    NSString                *linkBudget;
    NSMutableDictionary     *listBudget;
    NSString                *productID;
    NSString                *productValue;
    NSString                *linkProduct;
    NSMutableDictionary     *listProduct;
    NSString                *linkPurchase;
    NSMutableDictionary     *listPurchase;
    NSString                *link;
    
    NSMutableString *_nomes;
    NSMutableString *_sobrenomes;
    NSMutableString *_idades;
    NSMutableString *_sexos;
    NSMutableString *_rgs;
    NSMutableString *_cpfs;
    NSMutableString *_emails;
    NSMutableString *_telefones;
    
#pragma mark - Save Purchase
    NSMutableDictionary *listSavePurchase;
}

- (NSDictionary *)getInfos;

@end
