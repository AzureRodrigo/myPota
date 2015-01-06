//
//  Vendedor.h
//  CadastrodeVendedor
//
//  Created by Rodrigo Pimentel on 18/02/14.
//  Copyright (c) 2014 esfera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vendedor : NSObject

@property (strong, nonatomic) NSMutableDictionary *data;

- (Vendedor *)initVendedor:(NSDictionary *)info;

@end
