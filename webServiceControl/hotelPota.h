//
//  hotelPota.h
//  myPota
//
//  Created by Rodrigo Pimentel on 10/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AzParser.h"
#import "AzCalendar.h"
#import "hotelPotaCellAge.h"
#import "hotelPotaCellRoom.h"
#import "hotelPotaCellData.h"
#import "hotelPotaCellNext.h"

@interface hotelPota : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray                 *PickerAgeList;
    NSMutableArray          *AgeChildren;
#pragma mark -otlTableView
    IBOutlet UITableView    *tableViewData;
#pragma mark -menuOption
    NSDateFormatter         *formatDate;
    NSLocale                *locale;
    NSDate                  *dateInfo;
#pragma mark -otlDestiny
    NSString                *otlDestinyCity;
    IBOutlet UILabel        *otlDestinyCountry;
#pragma mark -otlPax
    IBOutlet UILabel        *otlPax;
#pragma mark -otlPaxAdults
    IBOutlet UIButton       *otlBtnMinusAdults;
    IBOutlet UIButton       *otlBtnPlusAdults;
    IBOutlet UILabel        *otlNumberAdults;
#pragma mark -otlPaxChildren
    IBOutlet UIButton       *otlBtnMinusChildren;
    IBOutlet UIButton       *otlBtnPlusChildren;
    IBOutlet UILabel        *otlNumberChildren;
#pragma mark -wsVariables
    NSString                *wsCodSite;
    NSString                *wsDataChecking;
    NSString                *wsCodCity;
    NSString                *wsNumberNights;
    NSString                *wsTypeRooms;
    NSString                *wsLink;
    NSString                *wsRoomsOccupation;
    NSString                *wsLinkToken;
    NSString                *wsLinkHotel;
    NSString                *wsCounterNew;
#pragma mark -wsConnection
    NSURL                   *ctUrl;
    NSURLRequest            *ctRequest;
    NSMutableData           *ctReceivedData;
    NSURLConnection         *ct;

#pragma mark -Config Hotel
    NSMutableDictionary     *calendarData;
    NSMutableDictionary     *hotelData;
#pragma mark -variables
    int                     maxRoons;
    NSMutableDictionary     *roomInfo;
    
    NSMutableDictionary *purchaseData;
}

#pragma mark -wsHoteis
@property (strong, nonatomic) NSString       *wsToken;
@property (strong, nonatomic) NSString       *wsCounter;
@property (strong, nonatomic) NSString       *wsCounterNew;
@property (strong, nonatomic) NSString       *wsFinal;
@property (strong, nonatomic) NSMutableArray *infoHotel;

#pragma mark -btnAdults
- (IBAction)btnMinusAdults:(id)sender;
- (IBAction)btnPlusAdults:(id)sender;
#pragma mark -btnChilds
- (IBAction)btnMinusChilds:(id)sender;
- (IBAction)btnPlusChilds:(id)sender;

#pragma mark -functionsScreen
- (void)defineDestinyData:(NSString *)dataCity dataCountry:(NSString *)dataCountry cityCod:(NSString *)cityCod;

#pragma mark -functionMoreScreen
- (void)initConnectionReset;
- (void)setDateTravel:(NSDate *)start end:(NSDate *)end;

@end
