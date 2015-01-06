//
//  packTypes.h
//  myPota
//
//  Created by Rodrigo Pimentel on 21/10/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "packTypesCell.h"

@interface packTypes : UIViewController <UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITextField             *textDestiny;
    IBOutlet UIButton                *oltBtnSearch;
    IBOutlet UILabel                 *lblSearch;
    IBOutlet UIActivityIndicatorView *otlLoad;
    IBOutlet UITableView             *tableViewData;
    NSMutableArray                   *listTypes;
    NSMutableArray                   *listCircuits;
    
#pragma mark - connection
    NSURL                   *url;
    NSURLRequest            *request;
    NSURLConnection         *connection;
    NSMutableData           *receivedData;
    NSString                *IDWS;
}

- (IBAction)btnSearch:(id)sender;

@end
