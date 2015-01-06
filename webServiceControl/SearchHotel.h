//
//  SearchHotel.h
//  webServiceControl
//
//  Created by Rodrigo Pimentel on 11/02/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "occupationRoom.h"

@interface SearchHotel : NSObject

@property NSString *origin;
@property NSString *destination;
//@property NSDate *start;
//@property NSDate *end;

@property int numberRooms;
@property int numberRoomsMax;
@property int numberPeopleRoom;
@property int numberPeopleRoomMax;
@property int numberPeopleRoomAdults;
@property int roomID;

@property int roomSelectedId;
@property int limitAge;

-(occupationRoom *)getRoom:(int)ID;

@property NSMutableArray *roomOccupation;

+(SearchHotel *) searchHotelData;
- (void)addDataRoomOcupation:(int)adults childs:(int)childs myID:(int)myID;
- (void)removeDataOcupation:(int)_id;
- (void)resetData;
@end
