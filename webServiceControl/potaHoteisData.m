//
//  potaHoteisData.m
//  myPota
//
//  Created by Rodrigo Pimentel on 23/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "potaHoteisData.h"

@implementation potaHoteisData

- (potaHoteisData *)initHoteis:(NSDictionary *)info
{
    potaHoteisData *tmp = [potaHoteisData new];
    
    tmp.codigoCidadeFornecedor = [info objectForKey:@"codigoCidadeFornecedor"];
    tmp.codigoHotel            = [info objectForKey:@"codigoHotel"];
    tmp.codigoHotelFornecedor  = [info objectForKey:@"codigoHotelFornecedor"];
    tmp.codigoPlano            = [info objectForKey:@"codigoPlano"];
    tmp.dataCheckin            = [info objectForKey:@"dataCheckin"];
    tmp.dataCheckout           = [info objectForKey:@"dataCheckout"];
    tmp.descricaoHotel         = [info objectForKey:@"descricaoHotel"];
    tmp.enderecoHotel          = [info objectForKey:@"enderecoHotel"];
    tmp.faxHotel               = [info objectForKey:@"faxHotel"];
    tmp.idProvedor             = [info objectForKey:@"idProvedor"];
    tmp.imagemHotel            = [info objectForKey:@"imagemHotel"];
    tmp.indRecomendado         = [info objectForKey:@"indRecomendado"];
    tmp.latitudeHotel          = [info objectForKey:@"latitudeHotel"];
    tmp.localizacoes           = [info objectForKey:@"localizacoes"];
    tmp.logotipoFornecedor     = [info objectForKey:@"logotipoFornecedor"];
    tmp.longitudeHotel         = [info objectForKey:@"longitudeHotel"];
    tmp.nomeHotel              = [info objectForKey:@"nomeHotel"];
    tmp.nomeSeguradora         = [info objectForKey:@"nomeSeguradora"];
    tmp.qtdNoites              = [info objectForKey:@"qtdNoites"];
    tmp.seqPesquisa            = [info objectForKey:@"seqPesquisa"];
    tmp.streetViewHotel        = [info objectForKey:@"streetViewHotel"];
    tmp.taxasInclusa           = [info objectForKey:@"taxasInclusa"];
    tmp.telefoneHotel          = [info objectForKey:@"telefoneHotel"];
    tmp.tokenFornecedor        = [info objectForKey:@"tokenFornecedor"];
    tmp.urlMapaHotel           = [info objectForKey:@"urlMapaHotel"];
    tmp.urlSiteHotel           = [info objectForKey:@"urlSiteHotel"];
    tmp.zipCodeHotel           = [info objectForKey:@"zipCodeHotel"];
    tmp.precoTotal             = [info objectForKey:@"precoTotal"];
    tmp.moeda                  = [info objectForKey:@"moeda"];
    tmp.estrelasHotel          = [info objectForKey:@"estrelasHotel"];

    if ([tmp.estrelasHotel isEqualToString:@"-1"])
        tmp.estrelasHotel = @"0";
    
    return tmp;
}

@end
