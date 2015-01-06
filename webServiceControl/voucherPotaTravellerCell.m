//
//  voucherPotaTravellerCell.m
//  myPota
//
//  Created by Rodrigo Pimentel on 18/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "voucherPotaTravellerCell.h"

@implementation voucherPotaTravellerCell

- (void)startInfo:(NSString *)_ID name:(NSString *)_name age:(NSString *)_age mail:(NSString *)_mail fone:(NSString *)_fone cpf:(NSString *)_cpf
{
    [self.lblID     setText:[NSString stringWithFormat:@"Viajante: %@",_ID]];
    [self.lblName   setText:_name];
    [self.lblAge    setText:_age];
    [self.lblMail   setText:_mail];
    [self.lblFone   setText:_fone];
    [self.lblCPF    setText:_cpf];
}

@end
