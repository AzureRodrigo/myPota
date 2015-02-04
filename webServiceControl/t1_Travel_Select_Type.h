//
//  travelPotaType.h
//  myPota
//
//  Created by Rodrigo Pimentel on 07/07/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "t1_Travel_Select_Type_Cell.h"
#import "t0_Travel.h"

@interface t1_Travel_Select_Type :  UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    t0_Travel           *backScreen;
    IBOutlet UITableView *tableViewData;
    
    IBOutlet UILabel                 *lblLoad;
    IBOutlet UIActivityIndicatorView *otlLoad;
    
    NSDictionary                     *myAgency;
    NSMutableArray                   *listTypes;
    
#pragma mark - connection
    NSURL                   *url;
    NSURLRequest            *request;
    NSURLConnection         *connection;
    NSMutableData           *receivedData;
    NSString                *IDWS;
}

@end
