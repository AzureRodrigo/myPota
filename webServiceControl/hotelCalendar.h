//
//  travelCalendar.h
//  myPota
//
//  Created by Rodrigo Pimentel on 07/07/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hotelPota.h"
#import "AzCalendar.h"

@interface hotelCalendar : UIViewController <AzCalendarDelegate>
{
    hotelPota               *backScreen;
    AzCalendar              *calendarBody;
}

@end
