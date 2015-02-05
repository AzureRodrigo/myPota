#import "DSLCalendarView.h"

@interface DSLCalendarView ()
@end

@implementation DSLCalendarView

#pragma mark - super init frame
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        [self commonInit];
    return self;
}

#pragma mark - inicia o layout
- (void)commonInit
{
    _dayViewHeight      = self.frame.size.height/DAY_CELL_SIZE;
    _visibleMonth       = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:[NSDate date]];
    _visibleMonth.day   = 1;
    _showDayCalloutView = YES;
    
    self.monthSelectorView = [[DSLCalendarMonthSelectorView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    
    self.monthSelectorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:self.monthSelectorView];
    
    [self.monthSelectorView.backButton addTarget:self action:@selector(didTapMonthBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.monthSelectorView.forwardButton addTarget:self action:@selector(didTapMonthForward:) forControlEvents:UIControlEventTouchUpInside];

    CGRect frame        = self.bounds;
    frame.origin.x      = 0;
    frame.origin.y      = CGRectGetMaxY(self.monthSelectorView.frame);
    frame.size.height  -= frame.origin.y;
    self.monthContainerView = [[UIView alloc] initWithFrame:frame];
    self.monthContainerView.clipsToBounds = YES;
    [self addSubview:self.monthContainerView];
    
    self.monthContainerViewContentView = [[UIView alloc] initWithFrame:self.monthContainerView.bounds];
    [self.monthContainerView addSubview:self.monthContainerViewContentView];

    self.monthViews = [[NSMutableDictionary alloc] init];
    
    [self updateMonthLabelMonth:_visibleMonth];
    [self positionViewsForMonth:_visibleMonth fromMonth:_visibleMonth animated:NO];
}

#pragma mark - Properties
+ (Class)monthSelectorViewClass
{
    return [DSLCalendarMonthSelectorView class];
}

+ (Class)monthViewClass
{
    return [DSLCalendarMonthView class];
}

+ (Class)dayViewClass
{
    return [DSLCalendarDayView class];
}

- (void)setSelectedRange:(DSLCalendarRange *)selectedRange {
    _selectedRange = selectedRange;
    
    for (DSLCalendarMonthView *monthView in self.monthViews.allValues)
        [monthView updateDaySelectionStatesForRange:self.selectedRange];
}

#pragma mark - Inicia o dia selecionado
- (void)setDraggingFixedDay:(NSDateComponents *)draggingFixedDay
{
    _draggingFixedDay = [draggingFixedDay copy];
    if (draggingFixedDay == nil)
        [self.dayCalloutView setHidden:YES];
}

#pragma mark - Controle do mês a ser mostrado
- (NSDateComponents*)visibleMonth
{
    return [_visibleMonth copy];
}

- (void)setVisibleMonth:(NSDateComponents *)visibleMonth
{
    [self setVisibleMonth:visibleMonth animated:NO];
}

- (void)setVisibleMonth:(NSDateComponents *)visibleMonth animated:(BOOL)animated {
    NSDateComponents *fromMonth = [_visibleMonth copy];
    _visibleMonth = [visibleMonth.date dslCalendarView_monthWithCalendar:self.visibleMonth.calendar];
    
    [self updateMonthLabelMonth:_visibleMonth];
    [self positionViewsForMonth:_visibleMonth fromMonth:fromMonth animated:animated];
}

#pragma mark - Controle do mês a ser mostrado
- (void)didTapMonthBack:(id)sender
{
    NSDateComponents *newMonth = self.visibleMonth;
    newMonth.month--;
    [self setVisibleMonth:newMonth animated:YES];
}

- (void)didTapMonthForward:(id)sender
{
    NSDateComponents *newMonth = self.visibleMonth;
    newMonth.month++;
    [self setVisibleMonth:newMonth animated:YES];
}

#pragma mark - Atualiza a label do mes e do ano
- (void)updateMonthLabelMonth:(NSDateComponents*)month
{
    [self.monthSelectorView setMonth:[month.calendar dateFromComponents:month]];
}

#pragma mark - Define os messes e o ano
- (NSString*)monthViewKeyForMonth:(NSDateComponents*)month
{
    month = [month.calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:month.date];
    return [NSString stringWithFormat:@"%ld.%ld", (long)month.year, (long)month.month];
}

#pragma mark - Cria as view's dos messes
- (DSLCalendarMonthView*)cachedOrCreatedMonthViewForMonth:(NSDateComponents*)month
{
    month = [month.calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:month.date];
    NSString *monthViewKey = [self monthViewKeyForMonth:month];
    DSLCalendarMonthView *monthView = [self.monthViews objectForKey:monthViewKey];
    if (monthView == nil)
    {
        monthView = [[[[self class] monthViewClass] alloc] initWithMonth:month width:self.bounds.size.width dayViewClass:[[self class] dayViewClass] dayViewHeight:_dayViewHeight];
        [self.monthViews setObject:monthView forKey:monthViewKey];
        [self.monthContainerViewContentView addSubview:monthView];
        [monthView updateDaySelectionStatesForRange:self.selectedRange];
    }
    return monthView;
}

#pragma mark - Seta as view position em Move para o (próximo mês||mês anterior)
- (void)positionViewsForMonth:(NSDateComponents*)month fromMonth:(NSDateComponents*)fromMonth animated:(BOOL)animated {
    fromMonth = [fromMonth copy];
    month = [month copy];
    
    CGFloat nextVerticalPosition    = 0;
    CGFloat startingVerticalPostion = 0;
    CGFloat restingVerticalPosition = 0;
    CGFloat restingHeight           = 0;
    
    NSComparisonResult  monthComparisonResult = [month.date compare:fromMonth.date];
    NSTimeInterval      animationDuration     = (monthComparisonResult == NSOrderedSame || !animated) ? 0.0 : 0.5;
    NSMutableArray     *activeMonthViews      = [[NSMutableArray alloc] init];
    
    // Cria e posiciona os messes na view
    for (NSInteger monthOffset = -1; monthOffset <= 1; monthOffset += 1) {
        NSDateComponents *offsetMonth = [month copy];
        offsetMonth.month = offsetMonth.month + monthOffset;
        offsetMonth = [offsetMonth.calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:offsetMonth.date];

        if (![self monthStartsOnFirstDayOfWeek:offsetMonth])
            nextVerticalPosition -= _dayViewHeight;

        // cria e seta posção do mês
        DSLCalendarMonthView *monthView = [self cachedOrCreatedMonthViewForMonth:offsetMonth];
        [activeMonthViews addObject:monthView];
        [monthView.superview bringSubviewToFront:monthView];

        CGRect frame = monthView.frame;
        frame.origin.y = nextVerticalPosition;
        nextVerticalPosition += frame.size.height;
        monthView.frame = frame;
        
        // Cria a animação para scroll do mês
        if (monthOffset == 0)
        {
            restingVerticalPosition = monthView.frame.origin.y;
            restingHeight += monthView.bounds.size.height;
        }
        else if (monthOffset == 1 && monthComparisonResult == NSOrderedAscending)
        {
            // seta para o mes seguinte
            startingVerticalPostion = monthView.frame.origin.y;
            if ([self monthStartsOnFirstDayOfWeek:offsetMonth])
                startingVerticalPostion -= _dayViewHeight;
        }
        else if (monthOffset == -1 && monthComparisonResult == NSOrderedDescending)
        {
            // seta para o mes anterior
            startingVerticalPostion = monthView.frame.origin.y;
            if ([self monthStartsOnFirstDayOfWeek:offsetMonth])
                startingVerticalPostion -= _dayViewHeight;
        }
        //Cria mês anterior e próximo
        if (monthOffset == 0 && [self monthStartsOnFirstDayOfWeek:offsetMonth])
        {
            restingVerticalPosition -= _dayViewHeight;
            restingHeight += _dayViewHeight;
        }
        else if (monthOffset == 1 && [self monthStartsOnFirstDayOfWeek:offsetMonth])
            restingHeight += _dayViewHeight;
    }
    
    // Ajusta o tamanho para caber todos os dias
    CGRect frame      = self.monthContainerViewContentView.frame;
    frame.size.height = CGRectGetMaxY([[activeMonthViews lastObject] frame]);
    self.monthContainerViewContentView.frame = frame;
    
    // Remove os messes que não são mais exibidos
    NSArray *monthViewKeyes = self.monthViews.allKeys;
    for (NSString *key in monthViewKeyes)
    {
        UIView *monthView = [self.monthViews objectForKey:key];
        if (![activeMonthViews containsObject:monthView])
        {
            [monthView removeFromSuperview];
            [self.monthViews removeObjectForKey:key];
        }
    }

    // Position the content view to show where we're animating from
    if (monthComparisonResult != NSOrderedSame) {
        CGRect frame = self.monthContainerViewContentView.frame;
        frame.origin.y = -startingVerticalPostion;
        self.monthContainerViewContentView.frame = frame;
    }

    self.userInteractionEnabled = NO;

    [UIView animateWithDuration:animationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        for (NSInteger index = 0; index < activeMonthViews.count; index++)
        {
            DSLCalendarMonthView *monthView = [activeMonthViews objectAtIndex:index];
            for (DSLCalendarDayView *dayView in monthView.dayViews)
                dayView.inCurrentMonth = (index == 2);
        }

        //Seta a exibição de conteúdo para mostrar o mês atual
        CGRect frame    = self.monthContainerViewContentView.frame;
        frame.origin.y  = -restingVerticalPosition;
        self.monthContainerViewContentView.frame = frame;
        
        // Ajusta o tamanho do mês visivel
        frame = self.monthContainerView.frame;
        frame.size.height = restingHeight;
        self.monthContainerView.frame = frame;
        
        // Ajusta o tamanho do mês que será mostrado
        frame = self.frame;
        frame.size.height = CGRectGetMaxY(self.monthContainerView.frame);
        self.frame = frame;
        
        // seta o delegate para o mês alvo
        if (monthComparisonResult != NSOrderedSame && [self.delegate respondsToSelector:@selector(calendarView:willChangeToVisibleMonth:duration:)])
            [self.delegate calendarView:self willChangeToVisibleMonth:[month copy] duration:animationDuration];
    } completion:^(BOOL finished){
        self.userInteractionEnabled = YES;
        if (finished)
        {
            // seta o delegate para o mês alvo
            if (monthComparisonResult != NSOrderedSame && [self.delegate respondsToSelector:@selector(calendarView:didChangeToVisibleMonth:)])
                [self.delegate calendarView:self didChangeToVisibleMonth:[month copy]];
        }
    }];
}

#pragma mark - Verifica se o mês está correto
- (BOOL)monthStartsOnFirstDayOfWeek:(NSDateComponents*)month
{
    month = [month.calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:month.date];
    return (month.weekday - month.calendar.firstWeekday == 0);
}

#pragma mark - Normalize Datas
- (NSDate*)normalizedDateWithDate:(NSDate*)date
{
    NSCalendar *calendarData = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendarData components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                   fromDate: date];
    return [calendarData dateFromComponents:components];
}

#pragma mark - Touches Began
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    DSLCalendarDayView *touchedView = [self dayViewForTouches:touches];
    if (touchedView == nil)
    {
        self.draggingFixedDay = nil;
        return;
    }
    
    if ([[self normalizedDateWithDate:[NSDate new]] compare:[self normalizedDateWithDate:touchedView.dayAsDate ]] == NSOrderedAscending ||
        [[self normalizedDateWithDate:[NSDate new]] compare:[self normalizedDateWithDate:touchedView.dayAsDate ]] == NSOrderedSame)
    {
        DSLCalendarRange *newRange = self.selectedRange;
        self.draggingFixedDay   = touchedView.day;
        if (!self.isSelectStart) {
            
            self.isSelectStart    = YES;
            self.draggingStartDay = touchedView.day;
            self.draggingEndDay   = touchedView.day;
            self.dateStart        = touchedView.dayAsDate;
            self.dateEnd          = touchedView.dayAsDate;
            
        } else if (self.isSelectStart) {
            if ([[self normalizedDateWithDate:self.dateStart] compare:[self normalizedDateWithDate:touchedView.dayAsDate ]] == NSOrderedDescending)
            {
                self.draggingStartDay = touchedView.day;
                self.dateStart        = touchedView.dayAsDate;
            }
            else if ([[self normalizedDateWithDate:self.dateStart] compare:[self normalizedDateWithDate:touchedView.dayAsDate ]] == NSOrderedAscending)
            {
                self.isSelectFinish = YES;
                self.draggingEndDay = touchedView.day;
                self.dateEnd        = touchedView.dayAsDate;
            }
        }
        
        newRange = [[DSLCalendarRange alloc] initWithStartDay:self.draggingStartDay endDay:self.draggingEndDay];
        self.selectedRange = newRange;
        
        [self positionCalloutViewForDayView:touchedView];
    }
}

#pragma mark - Touches Move
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.draggingFixedDay == nil)
        return;
    
    DSLCalendarDayView *touchedView = [self dayViewForTouches:touches];
    
    if (touchedView == nil)
    {
        self.draggingFixedDay = nil;
        return;
    }
    
    if ([[self normalizedDateWithDate:[NSDate new]] compare:[self normalizedDateWithDate:touchedView.dayAsDate ]] == NSOrderedAscending ||
        [[self normalizedDateWithDate:[NSDate new]] compare:[self normalizedDateWithDate:touchedView.dayAsDate ]] == NSOrderedSame)
    {
        DSLCalendarRange *newRange;
        
        if ([self.draggingEndDay.date compare:self.draggingFixedDay.date] == NSOrderedAscending ||
            [self.draggingEndDay.date compare:self.draggingFixedDay.date] == NSOrderedSame) {
            if ([self.draggingStartDay.date compare:touchedView.dayAsDate] == NSOrderedAscending ||
                [self.draggingStartDay.date compare:touchedView.dayAsDate] == NSOrderedSame) {
                self.draggingFixedDay = touchedView.day;
                self.draggingEndDay = touchedView.day;
                self.dateEnd        = touchedView.dayAsDate;
            } else {
                self.draggingEndDay   = self.draggingStartDay;
                self.dateEnd          = self.dateStart;
                self.draggingFixedDay = touchedView.day;
                self.draggingStartDay = touchedView.day;
                self.dateStart        = touchedView.dayAsDate;
            }
            
        }else if ([self.draggingStartDay.date compare:self.draggingFixedDay.date] == NSOrderedDescending ||
                  [self.draggingStartDay.date compare:self.draggingFixedDay.date] == NSOrderedSame) {
            if ([self.draggingEndDay.date compare:touchedView.dayAsDate] == NSOrderedDescending ||
                [self.draggingEndDay.date compare:touchedView.dayAsDate] == NSOrderedSame) {
                self.draggingStartDay = touchedView.day;
                self.dateStart        = touchedView.dayAsDate;
            } else {
                self.draggingStartDay   = self.draggingEndDay;
                self.dateStart          = self.dateEnd;
                self.draggingFixedDay   = touchedView.day;
                self.draggingEndDay     = touchedView.day;
                self.dateEnd            = touchedView.dayAsDate;
            }
        } else if ([self.draggingEndDay.date compare:self.draggingFixedDay.date] == NSOrderedDescending && [self.draggingEndDay.date compare:touchedView.dayAsDate] == NSOrderedAscending) {
            self.draggingFixedDay   = touchedView.day;
        } else if ([self.draggingEndDay.date compare:self.draggingFixedDay.date] == NSOrderedAscending || [self.draggingEndDay.date compare:touchedView.dayAsDate] == NSOrderedDescending) {
            self.draggingFixedDay   = touchedView.day;
        }
        
        newRange = [[DSLCalendarRange alloc] initWithStartDay:self.draggingStartDay endDay:self.draggingEndDay];
        self.selectedRange = newRange;
        [self positionCalloutViewForDayView:touchedView];
        
        if ([self.delegate respondsToSelector:@selector(calendarView:didSelectRange:)])
            [self.delegate calendarView:self didSelectRange:self.selectedRange];
    }
}

#pragma mark - Touches End
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.draggingFixedDay == nil)
        return;
    
    DSLCalendarDayView *touchedView = [self dayViewForTouches:touches];
    
    if (touchedView == nil)
    {
        self.draggingFixedDay = nil;
        return;
    }
    
    self.draggingFixedDay = nil;
    
    
    if (touchedView.day.year != _visibleMonth.year || touchedView.day.month != _visibleMonth.month)
    {
        BOOL animateToAdjacentMonth = YES;
        if ([self.delegate respondsToSelector:@selector(calendarView:shouldAnimateDragToMonth:)])
            animateToAdjacentMonth = [self.delegate calendarView:self shouldAnimateDragToMonth:[touchedView.dayAsDate dslCalendarView_monthWithCalendar:_visibleMonth.calendar]];
        
        if (animateToAdjacentMonth)
        {
            if ([touchedView.dayAsDate compare:_visibleMonth.date] == NSOrderedAscending)
            {
                if ([_visibleMonth.date compare:[NSDate new]] == NSOrderedDescending)
                    [self didTapMonthBack:nil];
            }
            else
                [self didTapMonthForward:nil];
        }
    }
    if ([self.delegate respondsToSelector:@selector(calendarView:didSelectRange:)])
        [self.delegate calendarView:self didSelectRange:self.selectedRange];
}

#pragma mark - Calota Lógica
- (DSLCalendarDayView*)dayViewForTouches:(NSSet*)touches
{
    if (touches.count != 1)
        return nil;
    
    UITouch *touch = [touches anyObject];
    
    if (!CGRectContainsPoint(self.monthContainerView.frame, [touch locationInView:self.monthContainerView.superview]))
        return nil;
    
    for (DSLCalendarMonthView *monthView in self.monthViews.allValues)
    {
        UIView *view = [monthView hitTest:[touch locationInView:monthView] withEvent:nil];
        if (view == nil)
            continue;
        if (view != monthView)
        {
            if ([view isKindOfClass:[DSLCalendarDayView class]])
                return (DSLCalendarDayView*)view;
        }
    }
    
    return nil;
}

#pragma mark - Calota com o dia selecionado no dedo
- (void)positionCalloutViewForDayView:(DSLCalendarDayView*)dayView
{
    if([self showDayCalloutView] && dayView != nil)
    {
        CGRect calloutFrame       = [self convertRect:dayView.frame fromView:dayView.superview];
        calloutFrame.origin.y    -= calloutFrame.size.height * .8f;
        calloutFrame.size.height *= 1.5;
        
        if (self.dayCalloutView == nil) {
            self.dayCalloutView = [[DSLCalendarDayCalloutView alloc]initWithFrame:calloutFrame];
            [self addSubview:self.dayCalloutView];
        }else
            [self bringSubviewToFront:self.dayCalloutView];
        
        self.dayCalloutView.frame = calloutFrame;
        [self.dayCalloutView setDay:dayView.day];
        
        [self.dayCalloutView setHidden:NO];
    }
}

#pragma mark - Reset Selection
- (void)resetChoice
{
    self.isSelectStart      = NO;
    self.draggingStartDay   = nil;
    self.draggingFixedDay   = nil;
    self.draggingEndDay     = nil;
    self.selectedRange      = nil;
}

@end
