//
//  packInfoDatas.h
//  myPota
//
//  Created by Rodrigo Pimentel on 03/12/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "packInfo.h"
#import "packInfoDatasCell.h"

@interface packInfoDatas : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    packInfo *backScreen;
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
