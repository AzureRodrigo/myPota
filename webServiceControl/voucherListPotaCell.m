//
//  voucherListPotaCell.m
//  myPota
//
//  Created by Rodrigo Pimentel on 25/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "voucherListPotaCell.h"

@implementation voucherListPotaCell

- (void)startCell:(NSDictionary *)info
{
    [_lblType    setText:[info objectForKey:PURCHASE_TYPE]];
    [_lblVoucher setText:[info objectForKey:PURCHASE_INFO_VOLCHER]];
    
    NSDateFormatter *formatDate = [[NSDateFormatter alloc] init];
    NSLocale        *locale     = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_Br"];
    [formatDate setLocale:locale];
    [formatDate setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSDate* dateOutput = [formatDate  dateFromString:[info objectForKey:TAG_BUY_PURCHASE_DATA_START]];
    [formatDate setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSString *dateBuy = [formatDate stringFromDate:dateOutput];
    [_lblData    setText:dateBuy];
    
    [_lblCod     setText:[info objectForKey:TAG_BUY_PURCHASE_CODE_RESERVA]];
    [_lblValue   setText:[NSString stringWithFormat:@"R$ %.2f",[[info objectForKey:TAG_BUY_PURCHASE_VALOR] floatValue]]];
}

@end
