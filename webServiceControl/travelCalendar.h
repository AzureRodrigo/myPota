//
//  travelCalendar.h
//  myPota
//
//  Created by Rodrigo Pimentel on 07/07/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "travelPota.h"
#import "AzCalendar.h"

@interface travelCalendar : UIViewController <AzCalendarDelegate>
{
    travelPota              *backScreen;
    AzCalendar              *calendarBody;
}

@end
