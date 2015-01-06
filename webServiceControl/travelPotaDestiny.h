//
//  travelPotaDestiny.h
//  myPota
//
//  Created by Rodrigo Pimentel on 12/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "travelPotaDestinyCell.h"
#import "travelPota.h"

@interface travelPotaDestiny : UIViewController< UITableViewDelegate, UITableViewDataSource>
{
    travelPota *backScreen;
    IBOutlet UITableView            *tableViewData;
    IBOutlet UILabel                *lblLoad;
    IBOutlet UIActivityIndicatorView *otlLoad;
    
    NSMutableArray *listPlans;
    
#pragma mark - connection
    NSURL                   *url;
    NSURLRequest            *request;
    NSURLConnection         *connection;
    NSMutableData           *receivedData;
    NSString                *IDWS;
}

@end
