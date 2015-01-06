//
//  volcherPota.h
//  myPota
//
//  Created by Rodrigo Pimentel on 12/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "voucherPotaVoucherCell.h"
#import "voucherPotaPlanCell.h"
#import "voucherPotaTravellerCell.h"

#import "cadastreCell_TravelCustos.h"
#import "BuyInfoEnd.h"

#import "voucherPotaSellerData.h"

#define INFO_TITLE          @"title"
#define INFO_SCREEN         @"path"

#define CADASTRO_NEXT_SCREEN_SECURE     @"goTo Segurança"
#define CADASTRO_NEXT_SCREEN_COBERTURAS @"goTo Coberturas"
#define CADASTRO_NEXT_SCREEN_CONDICOES  @"goTo Condições"

@interface volcherPota : UIViewController <UITableViewDelegate, UITableViewDataSource,  UITextFieldDelegate>
{
    NSMutableDictionary  *purchaseData;
    NSString             *purchaseType;
    
    NSArray              *purchaseTravellers;
    NSDictionary         *purchaseAgency;
    NSDictionary         *purchaseSeller;
    
    //travell data
    NSMutableDictionary  *purchaseInfo;
    NSString             *lblTitlePurchase;
    NSArray              *listInfoDataEnd;
    NSMutableDictionary  *listPurchaseData;
    NSArray              *purchaseDetails;
    IBOutlet UITableView *tableData;
    //info  Screen
    NSString *lblNextScreenType;
}

- (NSString *)getTypeInfoScreen;

@end
