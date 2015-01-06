//
//  travelPotaType.h
//  myPota
//
//  Created by Rodrigo Pimentel on 07/07/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "travelPotaTypeCell.h"
#import "travelPota.h"

@interface travelPotaType :  UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    travelPota           *backScreen;
    IBOutlet UITableView *tableViewData;
    
    IBOutlet UILabel                 *lblLoad;
    IBOutlet UIActivityIndicatorView *otlLoad;
    
    NSMutableArray                   *listTypes;
    
#pragma mark - connection
    NSURL                   *url;
    NSURLRequest            *request;
    NSURLConnection         *connection;
    NSMutableData           *receivedData;
    NSString                *IDWS;
}

@end
