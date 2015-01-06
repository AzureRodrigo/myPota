//
//  cadastrePurchaseInfo.h
//  myPota
//
//  Created by Rodrigo Pimentel on 12/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "cadastreInfoCellTravel.h"
#import "cadastrePurchase.h"

@interface cadastrePurchaseInfo : UIViewController <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>
{
    IBOutlet UILabel     *lblTitle;
    IBOutlet UITableView *tableViewData;
    IBOutlet UIWebView   *webView;
    NSArray              *listInfo;
    NSMutableDictionary  *infoData;
    
    cadastrePurchase     *backScreen;
    NSString             *typeScreen;
}

@end
