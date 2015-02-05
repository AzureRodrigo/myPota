#import "DSLCalendarMonthView.h"

@interface DSLCalendarMonthView ()
@end

@implementation DSLCalendarMonthView

#pragma mark - Initialisation
- (id)initWithMonth:(NSDateComponents*)month width:(CGFloat)width dayViewClass:(Class)dayViewClass dayViewHeight:(CGFloat)dayViewHeight
{
    if (self = [super initWithFrame:CGRectMake(0, 0, width, dayViewHeight)])
    {
        _month              = [month copy];
        _dayViewHeight      = dayViewHeight;
        _dayViewsDictionary = [[NSMutableDictionary alloc] init];
        _dayViewClass       = dayViewClass;
        startDay            = [[NSDateComponents alloc] init];
        [self createDayViews];
    }
    
    return self;
}


#pragma mark - initDayView
- (void)createDayViews
{
    startDay.calendar   = self.month.calendar;
    startDay.year       = self.month.year;
    startDay.month      = self.month.month;
    startDay.day        = 1;
    
    firstDate = [startDay.calendar dateFromComponents:startDay];
    startDay  = [firstDate dslCalendarView_dayWithCalendar:self.month.calendar];
    
    numberOfDaysInMonth = [startDay.calendar rangeOfUnit:NSDayCalendarUnit
                                                  inUnit:NSMonthCalendarUnit
                                                 forDate:[startDay date]].length;
    
    startColumn = startDay.weekday - startDay.calendar.firstWeekday;
    
    if (startColumn < 0)
        startColumn += NUMBER_DAYS_WEAK;
    
    [self setColumnSize:NUMBER_DAYS_WEAK];
    nextDayViewOrigin = CGPointZero;
    
    for (int column = 0; column < startColumn; column++)
        nextDayViewOrigin.x += [[columnWidths objectAtIndex:column] floatValue];
    
    for (;startDay.day <= numberOfDaysInMonth;)
    {
        for (NSInteger column = startColumn; column < NUMBER_DAYS_WEAK; column++) {
            if (startDay.month == self.month.month)
            {
                DSLCalendarDayView *tmp = [self addCellDay:(int)column];
                [self.dayViewsDictionary setObject:tmp forKey:[self dayViewKeyForDay:startDay]];
                [self addSubview:tmp];
            }
            startDay.day        += 1;
            nextDayViewOrigin.x += [[columnWidths objectAtIndex:column] floatValue];
        }
        nextDayViewOrigin.x = 0;
        nextDayViewOrigin.y += _dayViewHeight;
        startColumn = 0;
    }
    
    fullFrame = CGRectZero;
    fullFrame.size.height = nextDayViewOrigin.y;
    for (NSNumber *width in columnWidths)
        fullFrame.size.width += width.floatValue;
    
    [self setFrame:fullFrame];
}

#pragma mark - addDayCell
- (DSLCalendarDayView *)addCellDay:(int)column
{
    CGRect dayFrame             = CGRectZero;
    dayFrame.origin             = nextDayViewOrigin;
    dayFrame.size.width         = [[columnWidths objectAtIndex:column] floatValue];
    dayFrame.size.height        = _dayViewHeight;
    DSLCalendarDayView *dayView = [[DSLCalendarDayView alloc]initCustom:dayFrame];
    dayView.day = startDay;
    if (column == 0)
        dayView.positionInWeek = DSLCalendarDayViewStartOfWeek;
    else if (column == NUMBER_DAYS_WEAK - 1)
        dayView.positionInWeek = DSLCalendarDayViewEndOfWeek;
    else
        dayView.positionInWeek = DSLCalendarDayViewMidWeek;
    
    return dayView;
}

- (void)updateDaySelectionStatesForRange:(DSLCalendarRange*)range
{
    for (DSLCalendarDayView *dayView in self.dayViews)
    {
        if ([range containsDate:dayView.dayAsDate])
        {
            BOOL isStartOfRange = [range.startDay isEqual:dayView.day];
            BOOL isEndOfRange   = [range.endDay   isEqual:dayView.day];
            if (isStartOfRange && isEndOfRange)
                dayView.selectionState = DSLCalendarDayViewWholeSelection;
            else if (isStartOfRange)
                dayView.selectionState = DSLCalendarDayViewStartOfSelection;
            else if (isEndOfRange)
                dayView.selectionState = DSLCalendarDayViewEndOfSelection;
            else
                dayView.selectionState = DSLCalendarDayViewWithinSelection;
        } else
            dayView.selectionState = DSLCalendarDayViewNotSelected;
    }
}

#pragma mark - setColumnSize
- (void)setColumnSize:(NSInteger)columnCount
{
    NSMutableArray *dict = [NSMutableArray new];
    CGFloat width = floorf(self.bounds.size.width / (CGFloat)columnCount);
    
    for (int i = 0; i < columnCount ; i++)
        [dict addObject:@(width)];
    
    columnWidths = [dict copy];
}

#pragma mark - Properties
- (NSSet*)dayViews
{
    return [NSSet setWithArray:self.dayViewsDictionary.allValues];
}

- (NSString*)dayViewKeyForDay:(NSDateComponents*)day
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle        = NSDateFormatterShortStyle;
    formatter.timeStyle        = NSDateFormatterNoStyle;
    
    return [formatter stringFromDate:[day date]];
}

- (DSLCalendarDayView*)dayViewForDay:(NSDateComponents*)day
{
    return [self.dayViewsDictionary objectForKey:[self dayViewKeyForDay:day]];
}

@end
