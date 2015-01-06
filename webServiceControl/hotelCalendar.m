//
//  travelCalendar.m
//  myPota
//
//  Created by Rodrigo Pimentel on 07/07/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "hotelCalendar.h"

@implementation hotelCalendar

- (void)initScreenData
{
    backScreen = (hotelPota *)[AppFunctions BACK_SCREEN:self number:1];
}

#pragma mark -configNavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR_CALENDAR:self
                                     image:IMAGE_NAVIGATION_BAR_CALENDAR
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_CALENDAR
                                buttonBack:@selector(btnBackScreen:)];
}

- (IBAction)btnBackScreen:(id)sender
{
    [backScreen setDateTravel:[calendarBody dateInfoStart] end:[calendarBody dateInfoEnd]];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - willAppear
- (void)viewWillAppear:(BOOL)animated
{
    [self initScreenData];
    [self configNavBar];
    [self calendarBodyData];
    [super viewWillAppear:animated];
}

- (void)calendarBodyData
{
    UIView *menu = [[UIView alloc] initWithFrame:CGRectMake (0,0,
                                                             self.view.frame.size.width,
                                                             self.view.frame.size.height)];
    menu.backgroundColor    = [UIColor clearColor];
    calendarBody            = [[AzCalendar alloc]initWithScreen:menu];
    [calendarBody           setDelegate:self];
    
    [self.view addSubview:menu];
}

- (void)btnCalendarConfirm:(AzCalendar *)view clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    [backScreen setDateTravel:[calendarBody dateInfoStart] end:[calendarBody dateInfoEnd]];
    
}

- (void)btnCalendarCancel:(AzCalendar *)view clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}


@end
