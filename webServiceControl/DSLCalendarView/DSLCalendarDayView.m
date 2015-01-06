#import "DSLCalendarDayView.h"

@interface DSLCalendarDayView ()
@end

@implementation DSLCalendarDayView

#pragma mark - init
- (id)initCustom:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initCellBackground];
        [self initCellLabels];
        [self setBackgroundColor:[UIColor clearColor]];
        _positionInWeek = DSLCalendarDayViewMidWeek;
        textFont        = [UIFont boldSystemFontOfSize:CALENDAR_NUMBERS_SIZE];
    }
    return self;
}

#pragma mark - setLabel
- (UILabel *)setLabelData:(CGRect)frame size:(float)size font:(NSString *)font alignment:(int)alignment color:(UIColor *)color
{
    UILabel *object = [[UILabel alloc] initWithFrame:frame];
    [object setFont:[UIFont fontWithName:font size:size]];
    [object setTextAlignment:alignment];
    [object setTextColor:color];
    return object;
}

#pragma mark - initCellLabels
- (void)initCellLabels
{
    self.lblMonth = [self setLabelData:CGRectMake(0, self.frame.size.height * .05f, 45, 21)
                                  size:17
                                  font:FONT_NAME
                             alignment:NSTextAlignmentCenter
                                 color:[UIColor colorWithRed:98.f/255.f green:129.f/255.f blue:255.f/255.f alpha:1.0f]];
    
    self.lblDay = [self setLabelData:CGRectMake(0, self.frame.size.height * .25f, 45, 38)
                                size:20
                                font:FONT_NAME
                           alignment:NSTextAlignmentCenter
                               color:[UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f]];
    
    
    self.lblToday  = [self setLabelData:CGRectMake(0, self.frame.size.height * .68f, 45, 21)
                                   size:17
                                   font:FONT_NAME
                              alignment:NSTextAlignmentCenter
                                  color:[UIColor colorWithRed:182.f/255.f green:2.f/255.f blue:2.f/255.f alpha:1.f]];
    
    [self addSubview:self.lblMonth];
    [self addSubview:self.lblDay];
    [self addSubview:self.lblToday];
}

#pragma mark - initCellBackground
- (void)initCellBackground
{
    UIImage *tmpLine = [UIImage imageNamed:@"dot_line"];
    self.imgLine     = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 1)];
    [self.imgLine setImage:tmpLine];
    
    UIImage *tmpLef  = [UIImage imageNamed:@"dayLeft"];
    self.imgLeft     = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width  * .5f) - 15.f,
                                                                      self.frame.size.height * .3f, 40, 30)];
    [self.imgLeft setImage:tmpLef];
    
    UIImage *tmpRig  = [UIImage imageNamed:@"dayRight"];
    self.imgRight    = [[UIImageView alloc] initWithFrame:CGRectMake(-5,
                                                                     self.frame.size.height * .3f, 40, 30)];
    [self.imgRight setImage:tmpRig];
    
    UIImage *tmpMid  = [UIImage imageNamed:@"dayMid"];
    self.imgMid      = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height * .3f,
                                                                     self.frame.size.width, 30)];
    [self.imgMid setImage:tmpMid];
    
    UIImage *tmpSel  = [UIImage imageNamed:@"daySelect"];
    self.imgSelect   = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width  * .5f - 15.f,
                                                                     self.frame.size.height * .3f, 30, 30)];
    [self.imgSelect setImage:tmpSel];
    
    [self addSubview:self.imgLine];
    [self addSubview:self.imgLeft];
    [self addSubview:self.imgRight];
    [self addSubview:self.imgMid];
    [self addSubview:self.imgSelect];
}

#pragma mark - setSelectionState
- (void)setSelectionState:(DSLCalendarDayViewSelectionState)selectionState
{
    _selectionState = selectionState;
    [self setNeedsDisplay];
}

#pragma mark - setDay
- (void)setDay:(NSDateComponents *)day
{
    _calendar  = [day calendar];
    _dayAsDate = [day date];
    _day = nil;
    _labelText = [NSString stringWithFormat:@"%ld", (long)day.day];
    _labelDayText = @"hoje";
}

#pragma mark - getDay
- (NSDateComponents*)day
{
    if (_day == nil)
        _day = [_dayAsDate dslCalendarView_dayWithCalendar:_calendar];
    return _day;
}

#pragma mark - getDayData
- (NSDate*)dayAsDate
{
    return _dayAsDate;
}

#pragma mark - Draw'sUpdate
- (void)drawRect:(CGRect)rect
{
    if ([self isMemberOfClass:[DSLCalendarDayView class]])
    {
        [self setBackgroudData];
        [self setColorLabel];
        [self setDayData];
    }
}

#pragma mark - orderDay
- (int)orderDay
{
    return [[self normalizedDateWithDate:[self dayAsDate]] compare:[self normalizedDateWithDate:[NSDate new]]];
}

#pragma mark - decideColor
- (UIColor *)decideColor:(UIColor *)color disable:(UIColor *)disable
{
    if ([self orderDay] == NSOrderedAscending)
        return disable;
    else
        return color;
}

#pragma mark - setBackgroundColor
- (void)setBackGroundColor
{
    [CALENDAR_COLOR_MONTH setFill];
    UIRectFill(self.bounds);
}

#pragma mark - ConfigBackground
- (void)setBackgroudData
{
    [self setBackGroundColor];
    
    if (self.selectionState == DSLCalendarDayViewNotSelected)
        [self setVisible:NO mid:NO right:NO left:NO];
    else if (self.selectionState == DSLCalendarDayViewStartOfSelection)
        [self setVisible:YES mid:NO right:NO left:YES];
    else if (self.selectionState == DSLCalendarDayViewEndOfSelection)
        [self setVisible:YES mid:NO right:YES left:NO];
    else if (self.selectionState == DSLCalendarDayViewWithinSelection)
        [self setVisible:NO mid:YES right:NO left:NO];
    else if (self.selectionState == DSLCalendarDayViewWholeSelection)
        [self setVisible:YES mid:NO right:NO left:NO];
}

#pragma mark - setVisibleImages
- (void)setVisible:(BOOL)select mid:(BOOL)mid right:(BOOL)right left:(BOOL)left
{
    [self.imgSelect setHidden:!select];
    [self.imgMid    setHidden:!mid];
    [self.imgRight  setHidden:!right];
    [self.imgLeft   setHidden:!left];
    [self.imgLine   setHidden:NO];
}

#pragma mark - setLabelColor
- (void)setColorLabel //mexer aqui pra deixar mais bonito
{
    if ([self orderDay] == NSOrderedSame) {
        [self.lblToday setHidden:NO];
        [self.lblToday setText:_labelDayText];
    }
    if ([self orderDay] == NSOrderedAscending)
        dayColor = CALENDAR_NUMBERS_COLOR_DAY_DISABLE;
    else {
        if (self.selectionState == DSLCalendarDayViewNotSelected)
            dayColor = CALENDAR_NUMBERS_COLOR_NORMAL;
        else
            dayColor = CALENDAR_NUMBERS_COLOR_SELECT;
    }
    
    [self.lblDay setTextColor:dayColor];
}

#pragma mark - setDayInfo
- (void)setDayData
{
    if ([_labelText isEqualToString:@"1"]){
        [self.lblMonth setHidden:NO];
        [self.lblMonth setText:[self getMonth:[self dayAsDate]]];
    }
    [self.lblDay setText: _labelText];
}

#pragma mark - get day number
- (int)getDayNumber:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    return  (int)[components day];
}

#pragma mark - get month string
- (NSString *)getMonth:(NSDate *)date
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSLocale *formatLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_Br"];
    [df setLocale:formatLocale];
    [df setDateFormat:@"MMM"];
    return [df stringFromDate:date];
}

#pragma mark - Normalize Datas
- (NSDate*)normalizedDateWithDate:(NSDate*)date
{
    NSCalendar *calendarData = [NSCalendar currentCalendar];
    
    NSDateComponents* components = [calendarData components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                   fromDate: date];
    return [calendarData dateFromComponents:components];
}

@end
