//
//  HotelOccupation.h
//  webServiceControl
//
//  Created by Rodrigo Pimentel on 07/03/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelOccupation : NSObject

@property int numberRoom;

@property int numberAdults;
@property int numberChilds;

@property NSMutableArray *ageChilds;

@end
