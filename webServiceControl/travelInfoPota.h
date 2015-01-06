//
//  travelInfoPota.h
//  myPota
//
//  Created by Rodrigo Pimentel on 13/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "travelPackges.h"
#import "travelInfoPotaCell.h"

@interface travelInfoPota : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    travelPackges                       *backScreen;
    travelPlans                         *planSELECT;
    IBOutlet UITableView                *tableViewData;
    IBOutlet UILabel                    *lblLoad;
    IBOutlet UIActivityIndicatorView    *otlLoad;
    IBOutlet UILabel                    *lblMaxPrice;
#pragma mark - connection
    NSURL                               *url;
    NSURLRequest                        *request;
    NSURLConnection                     *connection;
    NSMutableData                       *receivedData;
    NSString                            *link;
    
    NSMutableArray                      *listInfo;
    NSMutableDictionary                 *listClients;
    IBOutlet UILabel                    *lblPlano;
    NSMutableDictionary                 *purchaseData;
}

@end
