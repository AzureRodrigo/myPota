//
//  Agencias.m
//  CadastrodeVendedor
//
//  Created by Rodrigo Pimentel on 17/02/14.
//  Copyright (c) 2014 esfera. All rights reserved.
//

#import "Agencias.h"

@implementation Agencias

- (Agencias *)initAgencia:(NSDictionary *)info
{
    Agencias *tmp = [Agencias new];
    tmp.data = [info mutableCopy];
    return tmp;
}

@end
