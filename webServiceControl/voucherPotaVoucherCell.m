//
//  voucherPotaVoucherCell.m
//  myPota
//
//  Created by Rodrigo Pimentel on 18/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "voucherPotaVoucherCell.h"

@implementation voucherPotaVoucherCell


- (void)startInfo:(NSString *)voucher code:(NSString *)code
{
    [self.lblPassword setText:voucher];
    [self.lblCode setText:code];
}

@end
