//
//  hotelPotaDestiny.h
//  webServiceControl
//
//  Created by Rodrigo Pimentel on 14/03/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AzParser.h"
#import "hotelDestinyCell.h"
#import "HotelSeachCidades.h"
#import "hotelPota.h"

@interface hotelPotaDestiny : UIViewController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
{
    hotelPota               *backScreen;
    IBOutlet UISearchBar    *searchBarData;
    IBOutlet UITableView    *tableViewData;
    IBOutlet UILabel        *lblStatus;
    NSString                *link;
    NSString                *city;
    int                     size;
    NSDictionary            *allCitys;
    NSURL                   *url;
    NSURLRequest            *request;
    NSURLConnection         *connection;
    NSMutableData           *receivedData;
    NSMutableArray          *Citys;
    NSMutableDictionary     *hotelSearchData;
    NSString                *dataCity;
#pragma mark - keyBoardScroll
    UITextField             *txtViewSelected;
    CGRect                  frame;
}

@end
