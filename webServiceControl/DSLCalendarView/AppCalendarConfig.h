//
//  AppCalendarConfig.h
//  myPota
//
//  Created by Rodrigo Pimentel on 23/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//


#ifndef myPota_AppCalendarConfig_h
#define myPota_AppCalendarConfig_h

#pragma mark - CALENDAR DAY VIEW
#define NUMBER_DAYS_WEAK                        7

#pragma mark - background color
#define CALENDAR_COLOR_MONTH                    [UIColor colorWithWhite:245.0/255.0 alpha:1.0]
#define CALENDAR_COLOR_MONTH_LAST               [UIColor colorWithWhite:225.0/255.0 alpha:1.0]
#define CALENDAR_COLOR_MONTH_DISABLE            [UIColor colorWithWhite:205.0/255.0 alpha:1.0]
#pragma mark - background select
#define CALENDAR_SELECTED_DAY_LEFT              @"DSLCalendarDaySelection-left"
#define CALENDAR_SELECTED_DAY_RIGHT             @"DSLCalendarDaySelection-right"
#define CALENDAR_SELECTED_DAY_MID               @"DSLCalendarDaySelection-middle"
#define CALENDAR_SELECTED_DAY                   @"DSLCalendarDaySelection"

#define CALENDAR_SELECTED_DAY_MAKE              UIEdgeInsetsMake(20, 20, 20, 20)
#define CALENDAR_SELECTED_DAY_HEIGHT            35.f
#define CALENDAR_SELECTED_DAY_RECT              CGRectMake(0.f, (self.frame.size.height/2) - (CALENDAR_SELECTED_DAY_HEIGHT/2), self.frame.size.width, CALENDAR_SELECTED_DAY_HEIGHT)

#pragma mark - defines Boarder
#define CALENDAR_BOARD_SIZE                     .5f
#define CALENDAR_BOARD_COLOR_NORMAL             [UIColor colorWithWhite:255.0/255.0 alpha:1.0]
#define CALENDAR_BOARD_COLOR_SELECT             [UIColor colorWithWhite:205.0/255.0 alpha:1.0]
#define CALENDAR_BOARD_COLOR_OTHER_MONTH        [UIColor colorWithWhite:185.0/255.0 alpha:1.0]
#define CALENDAR_BOARD_COLOR_MONTH_DISABLE      [UIColor colorWithWhite:120/255.0 alpha:1.0]

#pragma mark - defines Numbers
#define CALENDAR_NUMBERS_COLOR_MONTH_NORMAL     [UIColor colorWithRed:120/255.f green:120/255.f blue:150/255.f alpha:1]
#define CALENDAR_NUMBERS_COLOR_MONTH_SELECT     [UIColor colorWithRed:100/255.f green:100/255.f blue:150/255.f alpha:1]
#define CALENDAR_NUMBERS_COLOR_MONTH_DISABLE    [UIColor colorWithRed:200/255.f green:200/255.f blue:150/255.f alpha:1]

#define CALENDAR_NUMBERS_COLOR_DAY_NORMAL       [UIColor colorWithRed:200/255.f green:50/255.f  blue:50/255.f alpha:1]
#define CALENDAR_NUMBERS_COLOR_DAY_SELECT       [UIColor colorWithRed:200/255.f green:100/255.f blue:100/255.f alpha:1]
#define CALENDAR_NUMBERS_COLOR_DAY_DISABLE      [UIColor colorWithRed:200/255.f green:200/255.f blue:200/255.f alpha:1]
#define CALENDAR_NUMBERS_COLOR_NORMAL           [UIColor colorWithWhite:66.0/255.0 alpha:1.0]
#define CALENDAR_NUMBERS_COLOR_SELECT           [UIColor whiteColor]

#define CALENDAR_NUMBERS_SIZE                   17
#define CALENDAR_NUMBERS_SIZE_BOX               20
#define CALENDAR_NUMBERS_COLOR_TODAY            [UIColor colorWithRed:200/255.f green:50/255.f blue:50/255.f alpha:1]
#define CALENDAR_NUMBERS_COLOR_TODAY_SELECT     [UIColor colorWithRed:250/255.f green:100/255.f blue:100/255.f alpha:1]

#pragma mark - CALENDAR VIEW
#define DAY_CELL_SIZE 7.5

#pragma mark - CALENDAR CONFIG
#define CALENDAR_INIT                           [[NSDateFormatter alloc] init];
#define CALENDAR_LOCATION                       [[NSLocale alloc] initWithLocaleIdentifier:@"pt_Br"];

#endif