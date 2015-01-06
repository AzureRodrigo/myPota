@interface DSLCalendarRange : NSObject
{
    __strong NSDate *_startDate;
    __strong NSDate *_endDate;
}

@property (nonatomic, copy) NSDateComponents *startDay;
@property (nonatomic, copy) NSDateComponents *endDay;

- (id)initWithStartDay:(NSDateComponents*)start endDay:(NSDateComponents*)end;
- (BOOL)containsDay:(NSDateComponents*)day;
- (BOOL)containsDate:(NSDate*)date;

@end
