//
//  voucherPotaSellerData.m
//  myPota
//
//  Created by Rodrigo Pimentel on 18/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "voucherPotaSellerData.h"

@implementation voucherPotaSellerData

- (void)startCell:(NSString *)_imageAgency imgSecure:(NSString *)_imageSecure name:(NSString *)_name street:(NSString *)_street adress:(NSString *)_adress mail:(NSString *)_mail seller:(NSString *)_seller reserveCode:(NSString *)_reserveCode dataPurchase:(NSString *)_data
{
    if (![_imageAgency isEqualToString:@""])
        [AppFunctions LOAD_IMAGE_ASYNC:[NSString stringWithFormat:WS_URL_PERFIL_LOGO,_imageAgency] completion:^(UIImage *image) {
            [self.imgAgency setImage:image];
        }];
    
    if (![_imageSecure isEqualToString:@""])
        [AppFunctions LOAD_IMAGE_ASYNC:[NSString stringWithFormat:WS_URL_PERFIL_LOGO,_imageSecure] completion:^(UIImage *image) {
            [self.imgSecure setImage:image];
        }];
    
    [self.lblName setText:_name];
    [self.lblStreet setText:_street];
    [self.lblAdress setText:_adress];
    [self.lblMail setText:_mail];
    [self.lblSeller setText:_seller];
    [self.lblNumberReserva setText:_reserveCode];
    [self.lblBught setText:_data];
}

@end
