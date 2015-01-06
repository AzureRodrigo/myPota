//
//  States.m
//  CadastrodeVendedor
//
//  Created by Rodrigo Pimentel on 14/02/14.
//  Copyright (c) 2014 esfera. All rights reserved.
//

#import "States.h"

@implementation States

@synthesize listCitys, listAgencias, listVendedor;
@synthesize tagsCity;
-(id)init
{
    self = [super init];
    if (self)
    {
        listCitys    = [NSMutableArray new];
        tagsCity     = [[NSMutableArray alloc]initWithArray:@[ @"codigoCidade", @"nomeCidade", @"nomeCidadeES",
                                                               @"nomeCidadeEN", @"latitudeCidade", @"longitudeCidade",
                                                               @"codigoPais", @"nomePais", @"siglaPais", @"siglaEstado"]];
        listAgencias = [NSMutableArray new];
        listVendedor = [NSMutableArray new];
    }
    return self;
}

#pragma mark -city
-(void)addCity:(NSDictionary *)allInfo
{
    City *tmp = [City new];
    tmp.codigo      = [allInfo objectForKey:@"codigoCidade"];
    tmp.nome        = [allInfo objectForKey:@"nomeCidade"];
    tmp.nomeES      = [allInfo objectForKey:@"nomeCidadeES"];
    tmp.nomeEN      = [allInfo objectForKey:@"nomeCidadeEN"];
    tmp.latitude    = [allInfo objectForKey:@"latitudeCidade"];
    tmp.longitude   = [allInfo objectForKey:@"longitudeCidade"];
    tmp.codigoPais  = [allInfo objectForKey:@"codigoPais"];
    tmp.nomePais    = [allInfo objectForKey:@"nomePais"];
    tmp.siglaPais   = [allInfo objectForKey:@"siglaPais"];
    tmp.siglaEstado = [allInfo objectForKey:@"siglaEstado"];
    [listCitys addObject:tmp];
}

-(City *)getCity:(int)ID
{
    return [listCitys objectAtIndex:ID];
}

-(NSArray *)getCitysName
{
    NSMutableArray *tmp = [NSMutableArray new];
    for (City *city in listCitys) {
        [tmp addObject:city.nome];
    }
    return tmp;
}

-(void)resetList
{
    listCitys = [NSMutableArray new];
}

#pragma mark -agencias
-(void)addAgencia:(NSDictionary *)allInfo;
{
    Agencias *tmp = [Agencias new];
    tmp.data = [allInfo mutableCopy];
    [listAgencias addObject:tmp];
}

-(City *)getAgencia:(int)ID
{
    return [listAgencias objectAtIndex:ID];
}

-(void)resetListAgencia
{
    listAgencias = [NSMutableArray new];
}

#pragma mark - vendedor
-(void)addVendedor:(NSDictionary *)allInfo;
{
    Vendedor *tmp = [Vendedor new];
    tmp.data      = [allInfo mutableCopy];
    [listVendedor addObject:tmp];
}

-(Vendedor *)getVendedor:(int)ID
{
    return [listVendedor objectAtIndex:ID];
}

-(void)resetListVendedor
{
    listVendedor = [NSMutableArray new];
}

#pragma mark - addPOTA
-(Vendedor *)addPOTASelling:(NSDictionary *)allInfo
{
    Vendedor *selling = [Vendedor new];
    selling.data      = [allInfo mutableCopy];

    [listVendedor addObject:selling];
    return selling;
}

-(Agencias *)addPOTAAgencia:(NSDictionary *)allInfo
{
    Agencias *tmp = [Agencias new];
    tmp.data = [allInfo mutableCopy];

    [listAgencias addObject:tmp];
    
    return tmp;
}

@end
