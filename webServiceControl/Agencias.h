//
//  Agencias.h
//  CadastrodeVendedor
//
//  Created by Rodrigo Pimentel on 17/02/14.
//  Copyright (c) 2014 esfera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Agencias : NSObject

@property (strong, nonatomic) NSMutableDictionary* data;

- (Agencias *)initAgencia:(NSDictionary *)info;

@end
