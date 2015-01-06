//
//  HotelSeachCidades.m
//  webServiceControl
//
//  Created by Rodrigo Pimentel on 14/03/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "HotelSeachCidades.h"

@implementation HotelSeachCidades

- (id)initData:(NSString *)codigoCity nameCity:(NSString *)nameCity codigoCountry:(NSString *)codigoCountry nameCountry:(NSString *)nameContry nameState:(NSString *)nameState
{
    self = [super init];
    if (self) {
        self.codigoCity    = codigoCity;
        self.nameCity      = nameCity;
        self.nameContry    = nameContry;
        self.codigoCountry = codigoCountry;
        self.nameState     = nameState;
    }
    return self;
}

@end
