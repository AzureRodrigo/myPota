//
//  travelPota.m
//  myPota
//
//  Created by Rodrigo Pimentel on 08/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "travelPota.h"

@interface travelPota ()

@end

@implementation travelPota

#pragma mark - didLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDate *toDay = [NSDate new];
    NSDate *toMorrow = [toDay dateByAddingTimeInterval:60*60*24*1];
    [self setDateTravel:toDay end:toMorrow];
}

#pragma mark -configNavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_VIAGEM
                                     title:@""
                                superTitle:@""
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_CLEAR
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:@selector(menuOpen:)
                                backButton:YES];
}

- (IBAction)menuOpen:(id)sender
{
    [AppMenuView openMenu:self
                   sender:sender];
}

- (IBAction)btnBackScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - willAppear
- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [loadCalendar setHidden:YES];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [loadCalendar stopAnimating];
    [super viewWillDisappear:animated];
}

#pragma mark - Type
- (IBAction)btnType:(id)sender
{
    [self performSegueWithIdentifier:STORY_BOARD_TRAVEL_TYPE sender:self];
}

#pragma mark - Destiny
- (IBAction)btnDestiny:(id)sender
{
    [self performSegueWithIdentifier:STORY_BOARD_TRAVEL_DESTINY sender:self];
}

#pragma mark - Data
- (void)setDateTravel:(NSDate *)start end:(NSDate *)end
{
    if (start == nil || end == nil){
        return;
    }
    [otlDataStarDay     setText:[AzCalendar getDayName:start]];
    [otlDataStarMoth    setText:[AzCalendar getDateFormatNumeric:start]];
    [otlDataEndDay      setText:[AzCalendar getDayName:end]];
    [otlDataEndMoth     setText:[AzCalendar getDateFormatNumeric:end]];
}

- (IBAction)btnDataStart:(id)sender
{
    [loadCalendar setHidden:NO];
    [loadCalendar startAnimating];
    [self performSegueWithIdentifier:STORY_BOARD_TRAVEL_CALENDAR sender:self];
}

- (int) numberPeople
{
    return [otlPeopleMinus.text intValue] + [otlPeopleMore.text intValue] + 1;
}

#pragma mark - controll Peoples
- (void) verifyTravellers
{
    if ([self numberPeople] <= [TRAVEL_MAX_PEOPLE intValue])
    {
        [otlBtnMorePlus   setEnabled:YES];
        [otlBtnMinorPlus  setEnabled:YES];
    }
    else
    {
        [otlBtnMorePlus   setEnabled:NO];
        [otlBtnMinorPlus  setEnabled:NO];
    }
    
    if ([otlPeopleMore.text intValue] > 0)
        [otlBtnMoreMinus  setEnabled:YES];
    else
        [otlBtnMoreMinus  setEnabled:NO];
    
    if ([otlPeopleMinus.text intValue] > 0)
        [otlBtnMinorMinus  setEnabled:YES];
    else
        [otlBtnMinorMinus setEnabled:NO];
    
    [otlNumberPax setText:[NSString stringWithFormat:@"%d",
                           [otlPeopleMore.text intValue] + [otlPeopleMinus.text intValue]]];
}

#pragma mark - Age 75 minus
- (IBAction)btnAgeMinorMinus:(id)sender
{
    if ([otlPeopleMinus.text intValue] >= 1)
        otlPeopleMinus.text = [NSString stringWithFormat:@"%d",[otlPeopleMinus.text intValue] - 1];
    [self verifyTravellers];
}

- (IBAction)btnAgeMinorPlus:(id)sender
{
    if ([self numberPeople] <= [TRAVEL_MAX_PEOPLE intValue])
        otlPeopleMinus.text = [NSString stringWithFormat:@"%d",[otlPeopleMinus.text intValue] + 1];
    [self verifyTravellers];
}

#pragma mark - Age 75 more
- (IBAction)btnAgeMoreMinus:(id)sender
{
    if ([otlPeopleMore.text intValue] >= 1)
        otlPeopleMore.text = [NSString stringWithFormat:@"%d",[otlPeopleMore.text intValue] - 1];
    [self verifyTravellers];
}

- (IBAction)btnAgeMorePlus:(id)sender
{
    if ([self numberPeople] <= [TRAVEL_MAX_PEOPLE intValue])
        otlPeopleMore.text = [NSString stringWithFormat:@"%d",[otlPeopleMore.text intValue] + 1];
    [self verifyTravellers];
}

#pragma mark - set data other screen
- (void)setType:(NSString *)name
{
    [otlType setText:name];
}

- (void)setDestiny:(NSString *)name
{
    [otlDestiny setText:name];
}

#pragma mark - NextScreen
- (BOOL)verifySearch
{
    if ([[otlType text] isEqualToString:@"Selecione"]){
        [AppFunctions LOG_MESSAGE:ERROR_1037_TITLE
                          message:ERROR_1037_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    if ([[otlDestiny text] isEqualToString:@"Selecione"]){
        [AppFunctions LOG_MESSAGE:ERROR_1019_TITLE
                          message:ERROR_1019_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    if ([otlDataStarMoth.text isEqualToString:otlDataEndMoth.text]){
        [AppFunctions LOG_MESSAGE:ERROR_1020_TITLE
                          message:ERROR_1020_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    if (([otlPeopleMinus.text intValue] + [otlPeopleMore.text intValue]) < 1)
    {
        [AppFunctions LOG_MESSAGE:ERROR_1021_TITLE
                          message:ERROR_1021_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    return YES;
}

- (void)setPurchaseData:(NSMutableDictionary *)seller
{
    purchaseData = @{ PURCHASE_INFO_PRODUCT : [@{
                              PURCHASE_DATA_TRAVEL_TYPE           : otlType.text,
                              PURCHASE_DATA_TRAVEL_DESTINY        : otlDestiny.text,
                              PURCHASE_DATA_TRAVEL_DATA_START     : otlDataStarMoth.text,
                              PURCHASE_DATA_TRAVEL_DATA_END       : otlDataEndMoth.text,
                              PURCHASE_DATA_TRAVEL_DAYS           : [NSString stringWithFormat:@"%0.f",[self getDiferenceData:otlDataStarMoth.text end:otlDataEndMoth.text]],
                              PURCHASE_DATA_TRAVEL_PAX            : [NSString stringWithFormat:@"%d",[otlPeopleMinus.text intValue] + [otlPeopleMore.text intValue]],
                              PURCHASE_DATA_TRAVEL_PAX_YOUNG      : otlPeopleMinus.text,
                              PURCHASE_DATA_TRAVEL_PAX_OLD        : otlPeopleMore.text,
                              PURCHASE_DATA_TRAVEL_LINK_PLAN      : link
                              } mutableCopy],
                      PURCHASE_INFO_SELLER                : [seller objectForKey:PURCHASE_INFO_SELLER],
                      PURCHASE_INFO_AGENCY                : [seller objectForKey:PURCHASE_INFO_AGENCY]
                      };
}

- (void)searchPlans
{
    NSMutableDictionary *seller = [AppFunctions PLIST_LOAD:PLIST_SELLER_NAME];
    IDWS = [[seller objectForKey:PURCHASE_INFO_AGENCY]objectForKey:AGENCY_DATA_IDWS];
    if ([IDWS isEqualToString:@""])
        IDWS = KEY_ID_WS_TRAVEL;
    
    link = [NSString stringWithFormat:WS_URL_TRAVEL_BUY,
            IDWS, KEY_CODE_SITE_TRAVEL,
            KEY_EMPTY, otlDataStarMoth.text,otlDataEndMoth.text,
            otlPeopleMinus.text, otlPeopleMore.text, otlDestiny.text];
    
    link = [NSString stringWithFormat:WS_URL, WS_URL_TRAVEL_VALUES, link];
    [self setPurchaseData:seller];
    
    [self performSegueWithIdentifier:STORY_BOARD_TRAVEL_PLANOS sender:self];
}

- (IBAction)btnContinue:(id)sender
{
    if ([self verifySearch])
    {
        [self searchPlans];
    }
}

#pragma mark - get purchase data
- (NSMutableDictionary *)getPurchaseData
{
    return [purchaseData mutableCopy];
}

- (float)getDiferenceData:(NSString *)start end:(NSString *)end
{
    NSDateFormatter *formatDate   = [[NSDateFormatter alloc] init];
    NSLocale *locale              = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_Br"];
    [formatDate setLocale:locale];
    [formatDate setDateFormat:@"dd/MM/yyyy"];
    NSDate *startData   = [formatDate dateFromString:start];
    NSDate *endData     = [formatDate dateFromString:end];
    
    double SECONDS_TO_DAY = 60 * 60 * 24;
    double TIME           = [endData timeIntervalSinceDate:startData];
    
    return TIME/SECONDS_TO_DAY;
}

@end
