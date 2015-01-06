#import "DSLCalendarDayView.h"
#import "DSLCalendarRange.h"
#import "NSDate+DSLCalendarView.h"

@class DSLCalendarDayView;
@class DSLCalendarRange;

@interface DSLCalendarMonthView : UIView
{
    CGFloat _dayViewHeight;
    __strong Class _dayViewClass;
    
    //create day
    NSDateComponents *startDay;
    NSDate           *firstDate;
    NSInteger numberOfDaysInMonth;
    NSInteger startColumn;
    NSArray *columnWidths;
    CGPoint nextDayViewOrigin;
    CGRect fullFrame;
}

@property (nonatomic, strong) NSMutableDictionary       *dayViewsDictionary;
@property (nonatomic, copy, readonly) NSDateComponents  *month;
@property (nonatomic, strong, readonly) NSSet           *dayViews;


- (id)initWithMonth:(NSDateComponents*)month width:(CGFloat)width dayViewClass:(Class)dayViewClass dayViewHeight:(CGFloat)dayViewHeight;
- (DSLCalendarDayView*)dayViewForDay:(NSDateComponents*)day;
- (void)updateDaySelectionStatesForRange:(DSLCalendarRange*)range;

@end

