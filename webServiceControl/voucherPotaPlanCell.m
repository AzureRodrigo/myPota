//
//  voucherPotaPlanCell.m
//  myPota
//
//  Created by Rodrigo Pimentel on 18/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "voucherPotaPlanCell.h"

@implementation voucherPotaPlanCell

- (void)startInfo:(NSString *)_name ageLimit:(NSString *)_ageLimit destiny:(NSString *)_destiny dataStart:(NSString *)_datastart dataEnd:(NSString *)_dataEnd numberDays:(NSString *)_numberDays numberTravellers:(NSString *)_numbertravellers
{
    [self.lblName               setText:_name];
    [self.lblAgeLimit           setText:_ageLimit];
    [self.lblDestiny            setText:_destiny];
    [self.lblDataStart          setText:_datastart];
    [self.lblDataEnd            setText:_dataEnd];
    [self.lblNumberDays         setText:_numberDays];
    [self.lblNumberTravellers   setText:_numbertravellers];
}
@end
