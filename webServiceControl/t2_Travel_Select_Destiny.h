//
//  t2_Travel_Select_Destiny.h
//  myPota
//
//  Created by Rodrigo Pimentel on 12/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "t2_Travel_Select_Destiny_Cell.h"
#import "t0_Travel.h"

@interface t2_Travel_Select_Destiny : UIViewController< UITableViewDelegate, UITableViewDataSource>
{
    t0_Travel *backScreen;
    IBOutlet UITableView             *tableViewData;
    IBOutlet UILabel                 *lblLoad;
    IBOutlet UIActivityIndicatorView *otlLoad;
    
    NSDictionary                     *myAgency;
    NSMutableArray                   *listPlans;
    
#pragma mark - connection
    NSURL                   *url;
    NSURLRequest            *request;
    NSURLConnection         *connection;
    NSMutableData           *receivedData;
    NSString                *IDWS;
}

@end
