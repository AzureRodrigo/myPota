//
//  AzCalendar.h
//  myPota
//
//  Created by Rodrigo Pimentel on 16/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSLCalendarView.h"

@protocol AzCalendarDelegate
    - (void)btnCalendarCancel:(id)view clickedButtonAtIndex:(NSInteger)buttonIndex;
    - (void)btnCalendarConfirm:(id)view clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface AzCalendar : UIViewController <DSLCalendarViewDelegate>
{
    NSDateFormatter *formatDate;
    NSLocale        *locale;
    NSDate          *dateInfo;
    DSLCalendarView *calendarView;
}

@property (strong, nonatomic) NSDate *dateInfoStart;
@property (strong, nonatomic) NSDate *dateInfoEnd;

@property (copy) void (^onButtonTouchUpInside)(AzCalendar *alertView, int buttonIndex) ;

@property (nonatomic, assign) id <AzCalendarDelegate> delegate;

- (id)initWithView:(UIView *)frame;
- (id)initWithScreen:(UIView *)frame;

+ (NSString *)getDateFormat:(NSDate *)date;
+ (NSString *)getDateFormatNumeric:(NSDate *)date;
+ (NSString *)getWeakName:(NSDate *)date;
+ (NSString *)getDayName:(NSDate *)date;
+ (NSString *)formatDate:(NSString *)dataID;

@end