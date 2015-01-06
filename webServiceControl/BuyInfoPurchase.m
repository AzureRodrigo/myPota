//
//  BuyInfoPurchase.m
//  myPota
//
//  Created by Rodrigo Pimentel on 11/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "BuyInfoPurchase.h"

@implementation BuyInfoPurchase

- (void)startInfo:(float)_title parcel:(int)_x
{
    NSString *txt = @"x";
    if (_x == 1)
     txt = @"x";
    
    [_lblValue setText:[NSString stringWithFormat:@"R$ %.2f parcelado em %d%@.", _title, _x, txt]];
    [_otlActivity setHidden:YES];
}

@end
