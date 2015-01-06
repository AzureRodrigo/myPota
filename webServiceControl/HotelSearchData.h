
//
//  HotelSearchData.h
//  webServiceControl
//
//  Created by Rodrigo Pimentel on 07/03/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotelOccupation.h"

@interface HotelSearchData : NSObject

#pragma mark -roomOcupation
@property NSMutableDictionary *listRoons;
- (void)addRoom:(int)numberRoom;
- (HotelOccupation *)getRoom:(int)numberRoom;
- (void) deleteRoom:(int)numberRoom;

@end
