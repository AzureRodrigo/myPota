//
//  packInfoDatas.h
//  myPota
//
//  Created by Rodrigo Pimentel on 03/12/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "p2_Package_Info.h"
#import "p4_Packages_Data_Cell.h"

@interface p4_Packages_Data : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    p2_Package_Info *backScreen;
    IBOutlet UITableView *tableViewData;
    IBOutlet UILabel                 *lblLoad;
    IBOutlet UIActivityIndicatorView *otlLoad;
    
    
    NSMutableArray          *listDatas;
    
    NSURL                   *url;
    NSURLRequest            *request;
    NSURLConnection         *connection;
    NSMutableData           *receivedData;
}


@end
