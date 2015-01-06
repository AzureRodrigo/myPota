//
//  SearchHotel.m
//  webServiceControl
//
//  Created by Rodrigo Pimentel on 11/02/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "SearchHotel.h"

@implementation SearchHotel

@synthesize origin, destination, numberRooms, numberRoomsMax, numberPeopleRoom, numberPeopleRoomMax, numberPeopleRoomAdults, roomOccupation;

+(SearchHotel *) searchHotelData
{
    static SearchHotel *myData = nil;
    if (!myData) {
        myData = [[super alloc]init];
    }
    return myData;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (void) addDataRoomOcupation:(int)adults childs:(int)childs myID:(int)myID {
    occupationRoom *tmp =[[occupationRoom alloc]init];
    tmp.numberAdults = adults;
    tmp.numberChilds = childs;
    tmp.numberID = myID;
    
    [roomOccupation addObject:tmp];
}

- (void)removeDataOcupation:(int)_id {
    [[SearchHotel searchHotelData]getRoom:_id].numberAdults = 1;
    [[SearchHotel searchHotelData]getRoom:_id].numberChilds = 0;
    [[SearchHotel searchHotelData]getRoom:_id].AgeChilds = [[NSMutableArray alloc]init];
}

- (void) initData {
    numberRooms    = 1;
    numberRoomsMax = 4;
    numberPeopleRoom = 1;
    numberPeopleRoomMax = 4;
    numberPeopleRoomAdults = 1;
    _limitAge = 11;
    roomOccupation = [[NSMutableArray alloc]init];
    
    for (int i=0; i<numberRooms; i ++){
        [self addDataRoomOcupation:1 childs:0 myID:i];
    }
}

-(void) resetData {
    roomOccupation = [[NSMutableArray alloc]init];
    
}

-(occupationRoom *)getRoom:(int)ID {
    return [roomOccupation objectAtIndex:ID];
}

@end
