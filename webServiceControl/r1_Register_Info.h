//
//  cadastrePurchaseInfo.h
//  myPota
//
//  Created by Rodrigo Pimentel on 12/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "r1_Register_Info_Cell.h"
#import "r0_Register.h"

@interface r1_Register_Info : UIViewController <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>
{
    IBOutlet UILabel     *lblTitle;
    IBOutlet UITableView *tableViewData;
    IBOutlet UIWebView   *webView;
    NSArray              *listInfo;
    NSMutableDictionary  *infoData;
    
    r0_Register          *backScreen;
    NSString             *typeScreen;
}

@end
