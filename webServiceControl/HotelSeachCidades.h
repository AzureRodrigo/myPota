//
//  HotelSeachCidades.h
//  webServiceControl
//
//  Created by Rodrigo Pimentel on 14/03/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelSeachCidades : NSObject

@property (strong, nonatomic) NSString *codigoCity;
@property (strong, nonatomic) NSString *nameCity;
@property (strong, nonatomic) NSString *nameContry;
@property (strong, nonatomic) NSString *codigoCountry;
@property (strong, nonatomic) NSString *nameState;

- (id)initData:(NSString *)codigoCity nameCity:(NSString *)nameCity codigoCountry:(NSString *)codigoCountry nameCountry:(NSString *)nameContry nameState:(NSString *)nameState;

@end
