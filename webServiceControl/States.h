//
//  States.h
//  CadastrodeVendedor
//
//  Created by Rodrigo Pimentel on 14/02/14.
//  Copyright (c) 2014 esfera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"
#import "Agencias.h"
#import "Vendedor.h"

@interface States : NSObject

@property (strong, nonatomic) NSMutableArray *listCitys;
@property (strong, nonatomic) NSMutableArray *tagsCity;

-(void)addCity:(NSDictionary *)allInfo;
-(City *)getCity:(int)ID;
-(NSArray *)getCitysName;
-(void)resetList;

@property (strong, nonatomic) NSMutableArray *listAgencias;
-(void)addAgencia:(NSDictionary *)allInfo;
-(City *)getAgencia:(int)ID;
-(void)resetListAgencia;

@property (strong, nonatomic) NSMutableArray *listVendedor;
-(void)addVendedor:(NSDictionary *)allInfo;
-(Vendedor *)getVendedor:(int)ID;
-(void)resetListVendedor;

-(Vendedor *)addPOTASelling:(NSDictionary *)allInfo;
-(Agencias *)addPOTAAgencia:(NSDictionary *)allInfo;

@end