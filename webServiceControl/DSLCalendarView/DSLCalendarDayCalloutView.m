#import "DSLCalendarDayCalloutView.h"

@interface DSLCalendarDayCalloutView ()
@end

@implementation DSLCalendarDayCalloutView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        [self initCellData];
    
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

- (void)initCellData
{
    lblDay = [self setLabelData:CGRectMake(0, self.frame.size.height * .15f, self.frame.size.width, 30)
                           size:20
                           font:FONT_NAME
                      alignment:NSTextAlignmentCenter
                          color:[UIColor colorWithRed:66.f/255.f green:66.f/255.f blue:66.f/255.f alpha:1.0f]
                           text:@""];
    
    UIImage *tmpLine = [UIImage imageNamed:@"select.png"];
    imgSel           = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * .05f, self.frame.size.height * .1f,
                                                                     42, 50)];
    [imgSel setImage:tmpLine];

    [self addSubview:imgSel];
    [self addSubview:lblDay];

}

- (void)setDay:(NSDateComponents *)day
{
    [lblDay setText:[NSString stringWithFormat:@"%d", (int)day.day]];
}

@end
