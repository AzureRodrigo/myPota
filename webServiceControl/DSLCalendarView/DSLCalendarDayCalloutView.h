#import "AppCalendarConfig.h"

@interface DSLCalendarDayCalloutView : UIView
{
    UIImageView *imgSel;
    UILabel     *lblDay;
}

- (void)setDay:(NSDateComponents*)day;

@end
