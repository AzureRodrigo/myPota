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
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:@"Calendario"
                                                               attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                            NSFontAttributeName: [UIFont fontWithName:FONT_NAME_BOLD size:18]}];
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_GENERIC
                                     title:title
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_CLEAR
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:nil
                                backButton:YES];
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
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.dimBackground = YES;
    HUD.delegate  = self;
    HUD.labelText = @"Carregando datas.";
    [HUD show:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self calendarBodyData];
    });
    
    [super viewWillAppear:animated];
}

- (void)calendarBodyData
{
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake (0,0,
                                                             self.view.frame.size.width,
                                                             self.view.frame.size.height)];
    View.backgroundColor    = [UIColor clearColor];
    [self.view addSubview:View];
    
    calendarBody = [[AzCalendar alloc]initWithScreen:View];
    [calendarBody setDelegate:self];
    
    [HUD hide:YES];
}

- (void)btnCalendarConfirm:(AzCalendar *)view clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [backScreen setDateTravel:[calendarBody dateInfoStart] end:[calendarBody dateInfoEnd]];
    
}

- (void)btnCalendarCancel:(AzCalendar *)view clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

@end