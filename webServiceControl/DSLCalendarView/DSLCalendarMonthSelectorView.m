#import "DSLCalendarMonthSelectorView.h"

@interface DSLCalendarMonthSelectorView ()
@end

@implementation DSLCalendarMonthSelectorView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        [self initCellData:frame];
    return self;
}

- (UILabel *)setLabelData:(CGRect)frame size:(float)size font:(NSString *)font alignment:(int)alignment color:(UIColor *)color text:(NSString *)text
{
    UILabel *object = [[UILabel alloc] initWithFrame:frame];
    [object setFont:[UIFont fontWithName:font size:size]];
    [object setTextAlignment:alignment];
    [object setTextColor:color];
    [object  setText:text];
    return object;
}

- (void)initCellData:(CGRect)frame
{
    [self setBackgroundColor:[UIColor clearColor]];
    
    float highMonth = .12f;
    self.lblMonth = [self setLabelData:CGRectMake(0, self.frame.size.height * highMonth, 320, 21)
                                  size:17
                                  font:FONT_NAME
                             alignment:NSTextAlignmentCenter
                                 color:[UIColor colorWithRed:66.f/255.f green:66.f/255.f blue:66.f/255.f alpha:1.0f]
                                  text:@"mês"];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.backButton setTitle:@"back" forState:UIControlStateNormal];
    [self.backButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
    self.backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.backButton.frame  = CGRectMake(0, self.frame.size.height * highMonth,
                                        self.frame.size.width * .3f, 21);
    
    self.forwardButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.forwardButton setTitle:@"next" forState:UIControlStateNormal];
    [self.forwardButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
    self.forwardButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.forwardButton.frame  = CGRectMake(self.frame.size.width * .68f, self.frame.size.height * highMonth,
                                           self.frame.size.width * .3f, 21);
    
    nameDays = @[@"Dom", @"Seg", @"Ter", @"Qua", @"Qui", @"Sex", @"Sab"];
    
    for (int i = 0; i < 7; i++)
    {
        UILabel *day = [self setLabelData:CGRectMake(((self.frame.size.width / 7) * i), self.frame.size.height * .67, 45, 21)
                                     size:10
                                     font:FONT_NAME
                                alignment:NSTextAlignmentCenter
                                    color:[UIColor colorWithRed:66.f/255.f green:66.f/255.f blue:66.f/255.f alpha:1.0f]
                                     text:[nameDays objectAtIndex:i]];
        [self addSubview:day];
    }
    
    [self addSubview:self.lblMonth];
    [self addSubview:self.backButton];
    
    [self addSubview:self.forwardButton];
}

- (void)setMonth:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *formatLocale     = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_Br"];
    [formatter setLocale:formatLocale];
    
    formatter.dateFormat = @"dd";
    int day = [[formatter stringFromDate:date] intValue];
    
    formatter.dateFormat = @"MMMM";
    [self.lblMonth setText:[formatter stringFromDate:date]];
    [self.backButton setTitle:[formatter stringFromDate:[date dateByAddingTimeInterval:-(day * 24 * 60 * 60)]]
                     forState:UIControlStateNormal];
    [self.forwardButton setTitle:[formatter stringFromDate:[date dateByAddingTimeInterval:((32 - day) * 24 * 60 * 60)]]
                        forState:UIControlStateNormal];
    
    [self.lblMonth setText:[NSString stringWithFormat:@"%@ de ",self.lblMonth.text]];
    formatter.dateFormat = @"yyyy";
    [self.lblMonth setText:[NSString stringWithFormat:@"%@%@",self.lblMonth.text,[formatter stringFromDate:date]]];
    [self.lblMonth setTextAlignment:NSTextAlignmentCenter];
}

@end
