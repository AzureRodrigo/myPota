//
//  Vendedor.m
//  CadastrodeVendedor
//
//  Created by Rodrigo Pimentel on 18/02/14.
//  Copyright (c) 2014 esfera. All rights reserved.
//

#import "Vendedor.h"

@implementation Vendedor

- (Vendedor *)initVendedor:(NSDictionary *)info
{
    Vendedor *tmp = [Vendedor new];
    tmp.data      = [info mutableCopy];
    return tmp;
}

@end
