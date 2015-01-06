#import "AppCalendarConfig.h"
#import "NSDate+DSLCalendarView.h"

enum
{
    DSLCalendarDayViewNotSelected = 0,
    DSLCalendarDayViewWholeSelection,
    DSLCalendarDayViewStartOfSelection,
    DSLCalendarDayViewWithinSelection,
    DSLCalendarDayViewEndOfSelection,
} typedef DSLCalendarDayViewSelectionState;

enum
{
    DSLCalendarDayViewStartOfWeek = 0,
    DSLCalendarDayViewMidWeek,
    DSLCalendarDayViewEndOfWeek,
} typedef DSLCalendarDayViewPositionInWeek;


@interface DSLCalendarDayView : UIView
{
    __strong UIColor            *dayColor;
    __strong UIFont             *textFont;
    
    //verificar
    __strong NSCalendar         *_calendar;
    __strong NSDate             *_dayAsDate;
    __strong NSDateComponents   *_day;
    __strong NSString           *_labelText;
    __strong NSString           *_labelDayText;
    __strong NSString           *_labelWeak;
    //verificar
}

- (id)initCustom:(CGRect)frame;

@property (strong, nonatomic) IBOutlet UILabel      *lblMonth;
@property (strong, nonatomic) IBOutlet UILabel      *lblDay;
@property (strong, nonatomic) IBOutlet UILabel      *lblToday;
@property (strong, nonatomic) IBOutlet UIImageView  *imgMid;
@property (strong, nonatomic) IBOutlet UIImageView  *imgLeft;
@property (strong, nonatomic) IBOutlet UIImageView  *imgRight;
@property (strong, nonatomic) IBOutlet UIImageView  *imgSelect;
@property (strong, nonatomic) IBOutlet UIImageView  *imgLine;



//verificar
@property (nonatomic, copy)   NSDateComponents                 *day;
@property (nonatomic, assign) DSLCalendarDayViewPositionInWeek positionInWeek;
@property (nonatomic, assign) DSLCalendarDayViewSelectionState selectionState;
@property (nonatomic, assign, getter = isInCurrentMonth) BOOL  inCurrentMonth;
@property (nonatomic, strong, readonly) NSDate                 *dayAsDate;
//verificar
@end
