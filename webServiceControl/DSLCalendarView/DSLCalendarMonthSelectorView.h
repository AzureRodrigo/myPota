@interface DSLCalendarMonthSelectorView : UIView
{
    NSArray         *nameDays;
}

@property (strong, nonatomic) IBOutlet UILabel  *lblMonth;
@property (nonatomic, strong) IBOutlet UIButton *backButton;
@property (nonatomic, strong) IBOutlet UIButton *forwardButton;

- (void)setMonth:(NSDate *)date;

@end
