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
    IBOutlet UILabel     *lblTitle;
    IBOutlet UITableView *tableViewData;
    IBOutlet UIWebView   *webView;
    NSArray              *listInfo;
    NSMutableDictionary  *infoData;
    
    d0_Deal_Data         *backScreen;
    NSString             *typeScreen;
}

@end
