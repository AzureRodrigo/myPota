//
//  AzCalendar.m
//  myPota
//
//  Created by Rodrigo Pimentel on 16/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "AzCalendar.h"

@interface AzCalendar ()

@end

@implementation AzCalendar

- (id)initWithView:(UIView *)frame
{
    self = [super init];
    if (self)
    {
        self.view = frame;
        [self initCalendarScreen];
        [calendarView setDelegate:self];
    }
    return self;
}

- (id)initWithScreen:(UIView *)frame
{
    self = [super init];
    if (self)
    {
        self.view = frame;
        [self initCalendarScreen];
        [calendarView setDelegate:self];
    }
    return self;
}

- (void) initCalendarScreen
{
    formatDate = [[NSDateFormatter alloc] init];
    locale     = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_Br"];
    [formatDate setLocale:locale];
    dateInfo   = [NSDate date];

    calendarView = [[DSLCalendarView alloc]initWithFrame:CGRectMake( 2.5 ,self.view.frame.size.height * .015f,
                                                                    self.view.frame.size.width,
                                                                    self.view.frame.size.height)];
    [self.view addSubview:calendarView];
    
}

- (NSString *)getDayName:(NSDate *)date
{
    [formatDate setDateFormat:@"EEEE"];
    return [formatDate stringFromDate:date];
}

- (NSString *)getWeakName:(NSDate *)date
{
    [formatDate setDateFormat:@"MMMM"];
    return [formatDate stringFromDate:date];
}

- (NSString *)getDateFormat:(NSDate *)date
{
    [formatDate setDateFormat:@"dd"];
    NSString *txtDate = [formatDate stringFromDate:date];
    [formatDate setDateFormat:@"MMMM/yyyy"];
    return [NSString stringWithFormat:@"%@ de %@",txtDate,[[formatDate stringFromDate:date]capitalizedString]];
}

- (IBAction)btnCalendarCancel:(id)sender
{
    if (self.delegate != NULL) {
        [self.delegate btnCalendarCancel:self clickedButtonAtIndex:[sender tag]];
    }
    
    if (self.onButtonTouchUpInside != NULL) {
        self.onButtonTouchUpInside(self, (int)[sender tag]);
    }
}

- (IBAction)btnCalendarConfirm:(id)sender
{
    if (self.delegate != NULL)
        [self.delegate btnCalendarConfirm:self clickedButtonAtIndex:[sender tag]];
    
    if (self.onButtonTouchUpInside != NULL)
        self.onButtonTouchUpInside(self, (int)[sender tag]);
}

#pragma mark - Calendar touchUP
- (void)calendarView:(DSLCalendarView *)_calendarView didSelectRange:(DSLCalendarRange *)range
{
    if (range != nil)
    {
        int date = [AppFunctions DIFERENCE_DATE_IN_DAYS:range.startDay end:range.endDay];
        if (date > TRAVEL_MAX_DAY) {
            [calendarView resetChoice];
            [AppFunctions LOG_MESSAGE:ERROR_1035_TITLE
                              message:[NSString stringWithFormat:ERROR_1035_MESSAGE,TRAVEL_MAX_DAY]
                               cancel:ERROR_BUTTON_CANCEL];
            return;
        }
    else {
            self.dateInfoStart = range.startDay.date;
            self.dateInfoEnd   = range.endDay.date;
        }
    }
}

+ (NSString *)getDayName:(NSDate *)date
{
    NSDateFormatter *formatDateTMP = CALENDAR_INIT
    NSLocale        *localeTMP     = CALENDAR_LOCATION
    [formatDateTMP setLocale: localeTMP];
    [formatDateTMP setDateFormat:@"EEEE"];
    return      [formatDateTMP stringFromDate:date];
}

+ (NSString *)getWeakName:(NSDate *)date
{
    NSDateFormatter *formatDateTMP = CALENDAR_INIT
    NSLocale        *localeTMP     = CALENDAR_LOCATION
    [formatDateTMP setLocale: localeTMP];
    [formatDateTMP setDateFormat:@"MMMM"];
    return      [formatDateTMP stringFromDate:date];
}

+ (NSString *)getDateFormat:(NSDate *)date
{
    NSDateFormatter *formatDateTMP = CALENDAR_INIT
    NSLocale        *localeTMP     = CALENDAR_LOCATION
    [formatDateTMP setLocale: localeTMP];
    [formatDateTMP     setDateFormat:@"dd"];
    NSString        *txtDate = [formatDateTMP stringFromDate:date];
    [formatDateTMP     setDateFormat:@"MMMM/yyyy"];
    return [NSString stringWithFormat:@"%@ de %@",txtDate,[[formatDateTMP stringFromDate:date]capitalizedString]];
}

+ (NSString *)getDateFormatNumeric:(NSDate *)date;
{
    NSDateFormatter *formatDateTMP = CALENDAR_INIT
    NSLocale        *localeTMP     = CALENDAR_LOCATION
    [formatDateTMP setLocale: localeTMP];
    [formatDateTMP     setDateFormat:@"dd/MM/yyyy"];
    return [formatDateTMP stringFromDate:date];
}

+ (NSString *)formatDate:(NSString *)dataID
{
    NSDateFormatter *formatDateTMP   = [[NSDateFormatter alloc] init];
    NSLocale *localeTMP              = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_Br"];
    [formatDateTMP setLocale:localeTMP];
    NSString *city = [dataID stringByReplacingOccurrencesOfString:@" de " withString:@"/"];
    [formatDateTMP setDateFormat:@"dd/MMMM/yyyy"];
    NSDate *txtDate = [formatDateTMP dateFromString:city];
    [formatDateTMP setDateFormat:@"dd/MM/yyyy"];
    return  [formatDateTMP stringFromDate:txtDate];
}


@end
