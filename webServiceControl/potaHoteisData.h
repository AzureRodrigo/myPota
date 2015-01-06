//
//  potaHoteisData.h
//  myPota
//
//  Created by Rodrigo Pimentel on 23/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface potaHoteisData : NSObject

@property (strong, nonatomic) NSString *codigoCidadeFornecedor;
@property (strong, nonatomic) NSString *codigoHotel;
@property (strong, nonatomic) NSString *codigoHotelFornecedor;
@property (strong, nonatomic) NSString *codigoPlano;
@property (strong, nonatomic) NSString *dataCheckin;
@property (strong, nonatomic) NSString *dataCheckout;
@property (strong, nonatomic) NSString *descricaoHotel;
@property (strong, nonatomic) NSString *enderecoHotel;
@property (strong, nonatomic) NSString *estrelasHotel;
@property (strong, nonatomic) NSString *faxHotel;
@property (strong, nonatomic) NSString *idProvedor;
@property (strong, nonatomic) NSString *imagemHotel;
@property (strong, nonatomic) NSString *indRecomendado;
@property (strong, nonatomic) NSString *latitudeHotel;
@property (strong, nonatomic) NSString *localizacoes;
@property (strong, nonatomic) NSString *logotipoFornecedor;
@property (strong, nonatomic) NSString *longitudeHotel;
@property (strong, nonatomic) NSString *moeda;
@property (strong, nonatomic) NSString *nomeHotel;
@property (strong, nonatomic) NSString *nomeSeguradora;
@property (strong, nonatomic) NSString *precoTotal;
@property (strong, nonatomic) NSString *qtdNoites;
@property (strong, nonatomic) NSString *seqPesquisa;
@property (strong, nonatomic) NSString *streetViewHotel;
@property (strong, nonatomic) NSString *taxasInclusa;
@property (strong, nonatomic) NSString *telefoneHotel;
@property (strong, nonatomic) NSString *tokenFornecedor;
@property (strong, nonatomic) NSString *urlMapaHotel;
@property (strong, nonatomic) NSString *urlSiteHotel;
@property (strong, nonatomic) NSString *zipCodeHotel;

- (potaHoteisData *)initHoteis:(NSDictionary *)info;

@end
