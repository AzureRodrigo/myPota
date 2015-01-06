//
//  hotelPotaListResult.h
//  myPota
//
//  Created by Rodrigo Pimentel on 17/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hotelPotaListResultCell.h"
#import "hotelPota.h"
#import "AzParser.h"
#import "potaHoteisData.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>
#import "CustomIOS7AlertView.h"

@interface hotelPotaListResult : UIViewController <UISearchBarDelegate,CustomIOS7AlertViewDelegate>
{
    NSMutableDictionary *InfoPurchase;
    NSMutableArray      *InfoHoteis;
    NSMutableDictionary *InfoToken;
    NSMutableDictionary *InfoProduct;
    
#pragma mark -filter
    CustomIOS7AlertView *filterView;
    UIButton *buttonNameAZ;
    UIButton *buttonNameZA;
    UIButton *buttonStarUp;
    UIButton *buttonStarDown;
    UIButton *buttonMoneyUp;
    UIButton *buttonMoneyDown;
    IBOutlet UIButton *otlBtnFilter;
    
    IBOutlet UIActivityIndicatorView *LoadBar;
#pragma mark -hudInfoChoice
    IBOutlet UISearchBar *searchBarData;
    BOOL searchSelect;

    IBOutlet UILabel *lblDataStart;
    IBOutlet UILabel *lblDataEnd;
    
    IBOutlet UILabel *lblCity;
    IBOutlet UILabel *lblNumberPeople;
    IBOutlet UILabel *lblNumberRooms;
    IBOutlet UILabel *lblNumberDays;
    
#pragma mark -hudInfoHotel
    IBOutlet UITableView *tableViewData;
    IBOutlet UILabel *lblNumberHotel;
    IBOutlet UILabel *lblNumberHotelLbl;
    
    NSMutableArray      *listHoteis;
    NSMutableArray      *listHoteisSearch;
    NSMutableArray      *listHoteisNew;
    NSMutableDictionary *listImages;
    
    NSString *wsLink;
    NSString *wsCodSite;
    NSString *wsToken;
    NSString *wsCounter;
    NSString *wsCounterNew;
    NSString *wsFinal;
    NSString *wsLinkHotel;
    
    NSURL           *ctUrl;
    NSURLRequest    *ctRequest;
    NSMutableData   *ctReceivedData;
    NSURLConnection *ct;
    
    NSString *wsFilter;
    BOOL     wsFilterUp;
#pragma mark -nextScreen
    NSNumber *IDRoom;
#pragma mark - textView
    UITextField          *txtViewSelected;
    CGRect               frame;
}

- (IBAction)btnMap:(id)sender;
- (IBAction)btnOptionFilters:(id)sender;

@end
