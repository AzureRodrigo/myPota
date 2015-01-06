//
//  HotelSearchData.m
//  webServiceControl
//
//  Created by Rodrigo Pimentel on 07/03/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "HotelSearchData.h"

@implementation HotelSearchData

- (id)init
{
    self = [super init];
    if (self) {
        self.listRoons = [NSMutableDictionary new];
    }
    return self;
}

- (void)addRoom:(int)numberRoom
{
    HotelOccupation * tmp = [HotelOccupation new];
    tmp.numberRoom = numberRoom;
    tmp.numberAdults = 2;
    tmp.numberChilds = 0;
    tmp.ageChilds = [NSMutableArray new];
    
    [self.listRoons setObject:tmp forKey:[NSString stringWithFormat:@"%d",numberRoom]];
}

- (HotelOccupation *)getRoom:(int)numberRoom
{
    return [self.listRoons objectForKey:[NSString stringWithFormat:@"%d",numberRoom]];
}

- (void) deleteRoom:(int)numberRoom
{
    [self.listRoons removeObjectForKey:[NSString stringWithFormat:@"%d",numberRoom]];
}

@end
