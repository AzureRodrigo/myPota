//
//  BuyInfoEnd.m
//  myPota
//
//  Created by Rodrigo Pimentel on 11/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "BuyInfoEnd.h"

@implementation BuyInfoEnd

- (void)startInfo:(NSString *)_title id:(int)_id
{
    [_lblTitle setText:_title];
    if (_id > 0)
        [_imgHeader setHidden:YES];
}

@end
