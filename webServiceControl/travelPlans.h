//
//  travelPlans.h
//  myPota
//
//  Created by Rodrigo Pimentel on 12/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface travelPlans : NSObject

@property (nonatomic, strong) NSString *codigoPlano;
@property (nonatomic, strong) NSString *codigoSite;
@property (nonatomic, strong) NSString *descricaoPlano;
@property (nonatomic, strong) NSString *nomePlano;
@property (nonatomic, strong) NSString *valorPlanoReais;
@property (nonatomic, strong) NSString *limiteIdade;
@property (nonatomic, strong) NSString *valorCobertura;

- (travelPlans *)initVendedor:(NSDictionary *)info;

@end