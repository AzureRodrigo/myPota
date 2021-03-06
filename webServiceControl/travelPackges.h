//
//  travelPackges.h
//  myPota
//
//  Created by Rodrigo Pimentel on 09/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "travelPota.h"
#import "travelPlans.h"
#import "travelPackgesCell.h"

@interface travelPackges : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
#pragma mark - screen components
    travelPota *backScreen;
    IBOutlet UITableView                *tableViewData;
    IBOutlet UILabel                    *lblLoad;
    IBOutlet UIActivityIndicatorView    *otlLoad;
    IBOutlet UILabel                    *otlPlans;
    IBOutlet UILabel                    *lblDataStart;
    IBOutlet UILabel                    *lblDataEnd;
    IBOutlet UILabel                    *lblPax;
    IBOutlet UILabel                    *lblDays;
    
#pragma mark - connection
    NSURL                   *url;
    NSURLRequest            *request;
    NSURLConnection         *connection;
    NSMutableData           *receivedData;
    NSString                *link;
    NSMutableArray          *listPlans;
    travelPlans             *planSELECT;
    NSString                *maxValue;
    NSString                *minValue;
#pragma mark - purchase Data
    NSMutableDictionary     *purchaseData;
    NSMutableDictionary     *purchaseAllData;
}

#pragma mark - get purchase data
- (NSMutableDictionary *)getPurchaseData;

@end