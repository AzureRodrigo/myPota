//
//  travelPackges.h
//  myPota
//
//  Created by Rodrigo Pimentel on 09/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "t0_Travel.h"
#import "travelPlans.h"
#import "t4_Travel_Select_Plan_Cell.h"

@interface t4_Travel_Select_Plan : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
#pragma mark - screen components
    t0_Travel *backScreen;
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
    NSDictionary                        *myAgency;
    NSString                            *IDWS;
}

#pragma mark - get purchase data
- (NSMutableDictionary *)getPurchaseData;

@end