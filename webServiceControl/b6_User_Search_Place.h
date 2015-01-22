//
//  searchStateData.h
//  myPota
//
//  Created by Rodrigo Pimentel on 08/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "b5_User_Search_Data.h"
#import "searchStateCityCell.h"

@interface b6_User_Search_Place : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
    b5_User_Search_Data     *backScreen;
    BOOL                    stateSelect;
    NSMutableArray          *listDataSearch;
    NSMutableArray          *listData;
    IBOutlet UITableView    *tableViewData;
    IBOutlet UISearchBar    *searchBarData;
    IBOutlet UILabel *lblInfo;
    
#pragma mark - textView
    UITextField          *txtViewSelected;
    CGRect               frame;
}

@end
