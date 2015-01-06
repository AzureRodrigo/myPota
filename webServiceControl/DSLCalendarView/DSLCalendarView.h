#import "AppCalendarConfig.h"
#import "DSLCalendarRange.h"
#import "NSDate+DSLCalendarView.h"
#import "DSLCalendarDayCalloutView.h"
#import "DSLCalendarMonthSelectorView.h"
#import "DSLCalendarMonthView.h"
#import "DSLCalendarDayView.h"

@protocol DSLCalendarViewDelegate;

@interface DSLCalendarView : UIView
{
    CGFloat _dayViewHeight;
    NSDateComponents *_visibleMonth;
}
@property (nonatomic, weak) id<DSLCalendarViewDelegate>delegate;
@property (nonatomic, copy) NSDateComponents *visibleMonth;
@property (nonatomic, strong) DSLCalendarRange *selectedRange;
@property (nonatomic, assign) BOOL showDayCalloutView;

@property (nonatomic, strong) DSLCalendarDayCalloutView *dayCalloutView;
@property (nonatomic, copy) NSDateComponents *draggingFixedDay;


@property bool isSelectStart;
@property bool isSelectFinish;
@property (nonatomic, copy) NSDateComponents *draggingStartDay;
@property (nonatomic, copy) NSDateComponents *draggingEndDay;
@property (nonatomic, copy) NSDate *dateStart;
@property (nonatomic, copy) NSDate *dateEnd;

@property (nonatomic, assign) BOOL draggedOffStartDay;

@property (nonatomic, strong) NSMutableDictionary *monthViews;
@property (nonatomic, strong) UIView *monthContainerView;
@property (nonatomic, strong) UIView *monthContainerViewContentView;
@property (nonatomic, strong) DSLCalendarMonthSelectorView *monthSelectorView;

+ (Class)monthSelectorViewClass;
+ (Class)monthViewClass;
+ (Class)dayViewClass;

- (void)setVisibleMonth:(NSDateComponents *)visibleMonth animated:(BOOL)animated;
- (void)resetChoice;
@end

@protocol DSLCalendarViewDelegate <NSObject>

@optional

- (void)calendarView:(DSLCalendarView*)calendarView  didSelectRange:(DSLCalendarRange*)range;
- (void)calendarView:(DSLCalendarView *)calendarView willChangeToVisibleMonth:(NSDateComponents*)month duration:(NSTimeInterval)duration;
- (void)calendarView:(DSLCalendarView *)calendarView didChangeToVisibleMonth:(NSDateComponents*)month;
- (DSLCalendarRange*)calendarView:(DSLCalendarView*)calendarView didDragToDay:(NSDateComponents*)day selectingRange:(DSLCalendarRange*)range;
- (BOOL)calendarView:(DSLCalendarView *)calendarView shouldAnimateDragToMonth:(NSDateComponents*)month;

@end
