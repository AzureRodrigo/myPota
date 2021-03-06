//
//  packInfo.h
//  myPota
//
//  Created by Rodrigo Pimentel on 27/10/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "packInfoButtonCell.h"
#import "packInfoRoomCell.h"
#import "packInfoPriceCell.h"
#import "packInfoConfirmCell.h"
#import "packInfoDataCell.h"
#import "packInfoHeaderCell.h"

#define SIZE_START 97
#define SIZE_PLUS  20

@interface packInfo : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    //Header
//    IBOutlet UIButton *circuitImage;
//    IBOutlet UILabel  *circuitType;
    NSString  *circuitDays;
    NSString  *circuitName;
//    IBOutlet UILabel  *circuitInfo;
    //Bottom
    IBOutlet UITableView *tableViewData;
    
    //lists
    NSDictionary         *listData;
    NSDictionary         *infoType;
    NSMutableDictionary         *infoCircuit;
    
    NSArray              *titles;
    NSMutableArray       *roons;
    NSString             *selected;
    NSString             *IDWS;
    NSString             *linkImagesCircuits;
    NSString             *linkCitysInclude;
    NSString             *linkDataCircuts;
    NSString             *linkRoomCircuts;
    
    NSString             *linkGeneralConditions;
    NSString             *linkDayForDay;
    NSString             *linkIsInclude;
    
    NSString             *valuePurchase;
    int                  cellPriceSize;
    
    //purchase
    NSMutableDictionary *seller;
    NSMutableDictionary *purchaseData;
    NSMutableDictionary *infoData;
    
    //contracts
    NSString *htmlGeneralConditions;
    NSString *htmlIsInclude;
    NSString *htmlDayForDay;
    
    //LinkNextScre
    NSString *nextLink;
}

- (NSString *)getSelected;
- (NSString *)getSelectedLink;
- (NSString *)getNextLink;
- (void)setInfoData:(NSMutableDictionary *)info;

@end
