#import "NSDate+DSLCalendarView.h"

@implementation NSDate (DSLCalendarView)

- (NSDateComponents*)dslCalendarView_dayWithCalendar:(NSCalendar*)calendar {
    return [calendar components:NSCalendarCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit fromDate:self];
}

- (NSDateComponents*)dslCalendarView_monthWithCalendar:(NSCalendar*)calendar {
    return [calendar components:NSCalendarCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
}

@end
