//
//  App_Data_WS.h
//  mypota
//
//  Created by Rodrigo Pimentel on 05/01/15.
//  Copyright (c) 2015 web. All rights reserved.
//

#ifndef mypota_App_Data_WS_h
#define mypota_App_Data_WS_h

#pragma mark - Base
#define WS_URL              @"%@%@"
#define WS_URL_BASE         @"http://www.touroperator.com.br/webservice"
#define WS_URL_BASE_HOTEL   @"http://hotel.touroperator.com.br/ws"
#define WS_URL_BASE_IMAGE   @"http://www.touroperator.com.br/arquivos/img/agencia/%@"

#pragma mark - Cadastre Block b0
#define WS_b0_CADASTRE      [NSString stringWithFormat:WS_URL, WS_URL_BASE,@"/app.asmx/CadastroConsumidor?"]
#define WS_b0_CADASTRE_USER @"emailConsumidor=%@&senhaConsumidor=%@&codigoConsumidor=%@&codigoMD5Consumidor=%@&acao=%@&nomeConsumidor=%@&cpfConsumidor=%@&cepConsumidor=%@&dataNascimentoConsumidor=%@&chaveAcesso=%@&tipoRetorno=%@&tipoAcesso=%@"

#pragma mark - Cadastre Block c0
#define WS_c0_CADASTRE        [NSString stringWithFormat:WS_URL, WS_URL_BASE,@"/app.asmx/CadastroVendedor?"]
#define WS_c0_CADASTRE_SELLER @"acao=%@&loginVendedor=%@&senhaVendedor=%@&chaveAcesso=%@&tipoRetorno=%@"

#pragma mark - Cadastre Block b0&c0
#define WS_b0_c0_REGISTER      [NSString stringWithFormat:WS_URL, WS_URL_BASE,@"/app.asmx/RegistraCelular?"]
#define WS_b0_c0_REGISTER_FONE @"codigoMd5=%@&codigoCelular=%@&acao=%@&chaveAcesso=%@&tipoRetorno=%@"

#endif
