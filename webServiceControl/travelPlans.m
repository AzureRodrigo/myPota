//
//  travelPlans.m
//  myPota
//
//  Created by Rodrigo Pimentel on 12/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "travelPlans.h"

@implementation travelPlans

@synthesize codigoPlano,codigoSite,descricaoPlano,nomePlano,valorPlanoReais;

- (travelPlans *)initVendedor:(NSDictionary *)info
{
    travelPlans *new = [travelPlans new];
    
    new.codigoPlano        = [info objectForKey:@"codigoPlano"];
    new.codigoSite         = [info objectForKey:@"codigoSite"];
    new.descricaoPlano     = [info objectForKey:@"descricaoPlano"];
    new.nomePlano          = [info objectForKey:@"nomePlano"];
    new.valorPlanoReais    = [info objectForKey:@"valorPlanoReais"];
    new.limiteIdade        = [info objectForKey:@"infoLimiteIdade"];
    new.valorCobertura     = [info objectForKey:@"valorCobertura"];

    return new;
}

@end
