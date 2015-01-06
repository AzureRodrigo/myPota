//
//  BuyInfoCustos.m
//  myPota
//
//  Created by Rodrigo Pimentel on 11/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "BuyInfoCustos.h"

@implementation BuyInfoCustos

- (void)startCell:(NSDictionary *)_data title:(NSString *)_title
{
    [_lblTitle setText:_title];
    
    NSString *days = @"dias";
    if ([[_data objectForKey:PURCHASE_DATA_TRAVEL_DAYS]intValue] <= 1)
        days = @"dia";
    
    [_lblPlanDay setText:[NSString stringWithFormat:@"%@ (%@ %@)",
                          [_data objectForKey:@"nome"],
                          [_data objectForKey:PURCHASE_DATA_TRAVEL_DAYS],
                          days]];
    
    NSString *travellers = @"viajantes";
    if ([[_data objectForKey:PURCHASE_DATA_TRAVEL_PAX]intValue] <= 1)
        travellers = @"viajante";
    
    [_lblTravellerAge setText:[NSString stringWithFormat:@"%@ %@ (%@)",
                               [_data objectForKey:PURCHASE_DATA_TRAVEL_PAX],
                               travellers,
                               [_data objectForKey:@"idadeMaxima"]]];
    
    [_lblValueTravel setText:[NSString stringWithFormat:@"R$ %.2f", ([[_data objectForKey:@"valor"] floatValue]/[[_data objectForKey:PURCHASE_DATA_TRAVEL_PAX] floatValue])]];
    
    [_lblValueTotal setText:[NSString stringWithFormat:@"R$ %.2f", [[_data objectForKey:@"valor"] floatValue]]];
}

@end
