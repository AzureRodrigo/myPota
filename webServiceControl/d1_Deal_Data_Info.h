//
//  purchasePurchaseInfo.h
//  myPota
//
//  Created by Rodrigo Pimentel on 12/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "d1_Deal_Data_Info_Cell.h"
#import "d0_Deal_Data.h"

@interface d1_Deal_Data_Info : UIViewController <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>
{
    IBOutlet UITableView *tableViewData;
    IBOutlet UIWebView   *webView;
    NSMutableDictionary  *infoData;
    
    NSArray              *tableList;
    int                  tableOn;
    int                  tableCellSize;
    
    id                    backScreen;
    NSString              *typeScreen;
    NSString              *typeProduct;
    NSDictionary          *dataScreen;
}

@end
