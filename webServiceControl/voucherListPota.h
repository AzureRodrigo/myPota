//
//  voucherListPota.h
//  myPota
//
//  Created by Rodrigo Pimentel on 21/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "voucherListPotaCell.h"

@interface voucherListPota : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
    IBOutlet UISearchBar *searchBar;
    IBOutlet UITableView *tableView;
    NSMutableArray       *listPurchase;
    NSMutableArray       *listPurchaseSearch;
#pragma mark - keyBoardScroll
    UITextField             *txtViewSelected;
    CGRect                  frame;
}

@end
