//
//  BuyInfoTravellers.m
//  myPota
//
//  Created by Rodrigo Pimentel on 11/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "BuyInfoTravellers.h"

@implementation BuyInfoTravellers

- (void)startCell:(NSDictionary *)infos ID:(int)_id
{
    if (_id == 1)
        [_imgLine setHidden:NO];
    [_lblTravellerNumber setText:[NSString stringWithFormat:@"Viajante %d",_id]];
    [_lblTravellerName setText:[infos objectForKey:CADASTRO_PERSON_FIRST_NAME]];
    [_lblTravellerFone setText:[infos objectForKey:CADASTRO_PERSON_FONE]];
    [_lblTravellerMail setText:[infos objectForKey:CADASTRO_PERSON_MAIL]];
}

@end
