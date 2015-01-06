//
//  City.h
//  CadastrodeVendedor
//
//  Created by Rodrigo Pimentel on 14/02/14.
//  Copyright (c) 2014 esfera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (strong, nonatomic) NSString *codigo;
@property (strong, nonatomic) NSString *nome;
@property (strong, nonatomic) NSString *nomeES;
@property (strong, nonatomic) NSString *nomeEN;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *codigoPais;
@property (strong, nonatomic) NSString *nomePais;
@property (strong, nonatomic) NSString *siglaPais;
@property (strong, nonatomic) NSString *siglaEstado;

@end
