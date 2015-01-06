//
//  travelPota.h
//  myPota
//
//  Created by Rodrigo Pimentel on 08/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AzCalendar.h"

@interface travelPota : UIViewController
{
#pragma mark - Tipo
    IBOutlet UILabel *otlType;
#pragma mark - Destiny
    IBOutlet UILabel *otlDestiny;
#pragma mark - Data Start
    IBOutlet UILabel *otlDataStarDay;
    IBOutlet UILabel *otlDataStarMoth;
#pragma mark - Data End
    IBOutlet UILabel *otlDataEndDay;
    IBOutlet UILabel *otlDataEndMoth;
#pragma mark - Number Pax
    IBOutlet UILabel *otlNumberPax;
#pragma mark - Age 75 minus
    IBOutlet UILabel  *otlPeopleMinus;
    IBOutlet UIButton *otlBtnMinorMinus;
    IBOutlet UIButton *otlBtnMinorPlus;
#pragma mark - Age 75 more
    IBOutlet UILabel  *otlPeopleMore;
    IBOutlet UIButton *otlBtnMoreMinus;
    IBOutlet UIButton *otlBtnMorePlus;
#pragma mark - Buy
    IBOutlet UIButton *otlButtonContinue;
#pragma mark - Variables
    NSString *link;
    NSDate   *dateStart;
    NSDate   *dateEnd;
    IBOutlet UIActivityIndicatorView *loadCalendar;
#pragma mark - purchase data;
    NSDictionary *purchaseData;
    NSString     *IDWS;
}

#pragma mark - Type
- (IBAction)btnType:(id)sender;
#pragma mark - Destiny
- (IBAction)btnDestiny:(id)sender;
#pragma mark - Data
- (IBAction)btnDataStart:(id)sender;
#pragma mark - Age 75 minus
- (IBAction)btnAgeMinorMinus:(id)sender;
- (IBAction)btnAgeMinorPlus:(id)sender;
#pragma mark - Age 75 more
- (IBAction)btnAgeMoreMinus:(id)sender;
- (IBAction)btnAgeMorePlus:(id)sender;
#pragma mark - Data
- (void)setDateTravel:(NSDate *)start end:(NSDate *)end;
#pragma mark - set data other screen
- (void)setType:(NSString *)name;
- (void)setDestiny:(NSString *)name;
#pragma mark - get purchase data
- (NSMutableDictionary *)getPurchaseData;
#pragma mark - NextScreen
- (IBAction)btnContinue:(id)sender;

@end
