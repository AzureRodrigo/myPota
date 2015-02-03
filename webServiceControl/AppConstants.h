//
//  AppKeys.h
//  myPota
//
//  Created by Rodrigo Pimentel on 08/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//



//WS_URL_POTA

#ifndef myPota_AppConstants_h
#define myPota_AppConstants_h

#pragma mark - url's

#define WS_URL_POTA             			@"http://www.touroperator.com.br/webservice"
#define WS_URL_POTA_HOTA        			@"http://hotel.touroperator.com.br/ws"
#define WS_URL_PERFIL_LOGO        			@"http://www.touroperator.com.br/arquivos/img/agencia/%@"

#pragma mark - Web Server's

#define WS_URL                  			@"%@%@"
#define WS_URL_SELLER           			[NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/app.asmx/ConsultaAgenciaVendedor?"]

#define WS_URL_CITY             			[NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/app.asmx/ConsultaAgenciaCidade?"]
#define WS_URL_AGENCY           			[NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/app.asmx/ConsultaAgencia?"]
#define WS_URL_MAIL             			[NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/EnviaEmail?"]
#define WS_URL_TOKEN            			[NSString stringWithFormat:WS_URL, WS_URL_POTA_HOTA, @"/ws.asmx/BuscaHotel?"]

#define WS_URL_HOTEL            			[NSString stringWithFormat:WS_URL, WS_URL_POTA_HOTA, @"/ws.asmx/xmlBuscaHotel?"]
#define WS_URL_HOTEL_CITY       			[NSString stringWithFormat:WS_URL, WS_URL_POTA_HOTA, @"/ws.asmx/xmlBuscaCidade?iniciaisCidade=%@"]
#define WS_URL_HOTEL_ROOM       			[NSString stringWithFormat:WS_URL, WS_URL_POTA_HOTA, @"/ws.asmx/xmlBuscaQuarto?"]

#define WS_URL_TRAVEL           			[NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/ConsultaProdutos?"]
#define WS_URL_TRAVEL_CONTRACT          	[NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/ConsultaContrato?"]
#define WS_URL_TRAVEL_VALUES    			[NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/ConsultaValores?"]
#define WS_URL_TRAVEL_DESTINYS    			[NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/ConsultaDestinoSeguro?"]
#define WS_URL_TRAVEL_DESTINYS_TYPE    		[NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/ConsultaTipoProdutoSeguro?"]

#define WS_URL_BUY_NEW_BUDGET   			[NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/CriaOrcamento?"]
#define WS_URL_BUY_NEW_PURCHASE 			[NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/CriaReservaPedido?"]
#define WS_URL_BUY_REGISTER     			[NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/RegistraPagamento?"]

#define WS_URL_CADASTRO                     [NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/app.asmx/CadastraAtualizaConsumidor?"]

#define WS_URL_PACK_TYPES             		[NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/BuscaAreas?"]
#define WS_URL_PACK_CIRCUITS             	[NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/BuscaProduto?"]
#define WS_URL_PACK_DATA                    [NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/BuscaProdutoSaidas?"]
#define WS_URL_PACK_ROOM                    [NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/BuscaProdutoAcomodacoes?"]

#define WS_URL_INFO_CIRCUITS_ALL_CITYS      [NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/BuscaProdutoCidades?"]
#define WS_URL_INFO_CIRCUITS_ALL_CONDICTION [NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/BuscaProdutoCondicoesGerais?"]
#define WS_URL_INFO_CIRCUITS_ALL_IMAGES     [NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/BuscaProdutoImagens?"]
#define WS_URL_INFO_CIRCUITS_ALL_DAY        [NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/BuscaProdutoRoteiro?"]
#define WS_URL_INFO_CIRCUITS_ALL_INCLUDE    [NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/ws.asmx/BuscaProdutoServicoIncluso?"]


#define WS_URL_CHAT_SEND_MESSAGE              [NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/app.asmx/RegistraChat?"]
#define WS_URL_CHAT_RECIVE_MESSAGE            [NSString stringWithFormat:WS_URL, WS_URL_POTA,      @"/app.asmx/BuscarChat?"]


#pragma mark - Web Server's Complement's

#define WS_URL_SELLER_CODE        			@"codigoSite=%@&codigoAgencia=%@&nomeAgencia=%@&chaveAcesso=%@&codigoVendedor=%@&emailVendedor=%@&tipoRetorno=%@"
#define WS_URL_MAIL_SENDER        			@"idWS=%@&CodSite=%@&de=%@&para=%@&assunto=%@&texto=%@&cc=%@&bcc=%@"
#define WS_URL_CITY_SEARCH        			@"codigoSite=%@&codigoPais=%@&siglaEstado=%@&chaveAcesso=%@&tipoRetorno=%@"
#define WS_URL_AGENCY_SEARCH      			@"codigoSite=%@&codigoCidade=%@&nomeBairro=%@&nomeAgencia=%@&codigoAgencia=%@&chaveAcesso=%@&tipoRetorno=%@"
#define WS_URL_AGENCY_SELLERS     			@"codigoSite=%@&codigoAgencia=%@&nomeAgencia=%@&chaveAcesso=%@&codigoVendedor=%@&emailVendedor=%@&tipoRetorno=%@"

#define WS_URL_HOTEL_SEARCH       			@"codigoSite=%@&dataCheckin=%@&codigoCidade=%@&qtdNoites=%@&idHotel=%@&quantTipoIdadeQuarto=%@&senha=%@&tokenTos="
#define WS_URL_HOTEL_TOKEN        			@"codigoSite=%@&tokenTos=%@&sequenciaAtual=%@"
#define WS_URL_HOTEL_IMAGES        			@"/ws/ws.asmx/xmlBuscaImgHotel?codigoHotel=%@"
#define WS_URL_HOTEL_ROOM_INFO              @"codigoSite=%@&tokenTos=%@&idProvedor=%@&codigoHotel=%@"

#define WS_URL_TRAVEL_DESTINY     			@"IdWS=%@&CodSite=%@"
#define WS_URL_TRAVEL_DESTINY_TYPE     		@"IdWS=%@&CodSite=%@&CodPortal=%@&CodArea=%@"
#define WS_URL_TRAVEL_BUY         			@"IdWS=%@&CodSite=%@&TpoProduto=%@&DtaInicial=%@&DtaFinal=%@&QtdAdulto=%@&QtdIdoso=%@&DscDestino=%@"
#define WS_URL_TRAVEL_INFO        			@"IdWS=%@&CodSite=%@&TpoProduto=%@&CodProduto=%@"
#define WS_URL_TRAVEL_INFO_CONTRACT         @"IdWS=%@&CodSite=%@&CodPortal=%@&CodFornecedor=%@&CodProduto=%@"

#define WS_URL_BUY_BUDGET_INFO    			@"IdWS=%@&Acao=%@&CodOrcamento=%@&CodSite=%@&CodPortal=%@&CodProduto=%@&DtaInicio=%@&DtaFim=%@&QtdViajantes=%@&NomeViajantes=%@&SobrenomeViajantes=%@&IdadeViajantes=%@&SexoViajantes=%@&RGViajantes=%@&CPFViajantes=%@&EmailViajante=%@&TelefoneViajante=%@&DscDestino=%@&InfComplementar=%@&CodVendedor=%@"
#define WS_URL_BUY_PURCHASE_INFO  			@"IdWS=%@&CodSite=%@&CodOrcamento=%@&Status=%@&NomeViajantes=%@&SobrenomeViajantes=%@&IdadeViajantes=%@&SexoViajantes=%@&RGViajantes=%@&CPFViajantes=%@&EmailViajante=%@&TelefoneViajante=%@&Faturado=%@"
#define WS_URL_BUY_REGISTER_INFO            @"IdWS=%@&CodSite=%@&CodPedido=%@&TpoPagamento=%@&IdBandeira=%@&VlrPagamento=%@&QtdParcelas=%@&NumCartao=%@&MesValidade=%@&AnoValidade=%@&NomPortador=%@&CodVerificacao=%@"

#define WS_URL_CADASTRO_PERFIL              @"codigoConsumidor=%@&nomeConsumidor=%@&emailConsumidor=%@&cpfConsumidor=%@&cepConsumidor=%@&senhaConsumidor=%@&dataNascimentoConsumidor=%@&chaveAcesso=%@&tipoRetorno=XML&tipoAcesso=M"

#define LINK_CEP_VALIDATION @"http://apps.widenet.com.br/busca-cep/api/cep/%@.xml"

#define WS_URL_PACK_TYPES_INFO             	@"IdWS=%@&CodSite=%@&CodPortal=%@&CodGrupoArea=1"
#define WS_URL_PACK_CIRCUITS_INFO           @"IdWS=%@&CodSite=%@&CodPortal=%@&CodArea=%@&DscPesquisa=%@&OrdColuna=%@&OrdAscendencia=%@"
#define WS_URL_PACK_DATA_INFO               @"IdWS=%@&CodSite=%@&CodProduto=%@"
#define WS_URL_PACK_ROOM_INFO               @"IdWS=%@&CodSite=%@&CodProduto=%@&DtaSelecionada=%@&CodTemporada=%@&CodTipoTemportada=%@&TpoProduto=%@&IndAereo=%@&CodPlanoAereo=%@"


#define WS_URL_INFO_CIRCUITS_ALL_CITYS_INFO      @"IdWS=%@&CodSite=%@&CodProduto=%@&TpoProduto=%@"
#define WS_URL_INFO_CIRCUITS_ALL_CONDICTION_INFO @"IdWS=%@&CodSite=%@&CodProduto=%@&CodPortal=%@"
#define WS_URL_INFO_CIRCUITS_ALL_IMAGES_INFO     @"IdWS=%@&CodSite=%@&CodProduto=%@&TpoProduto=%@"
#define WS_URL_INFO_CIRCUITS_ALL_DAY_INFO        @"IdWS=%@&CodSite=%@&CodProduto=%@&DtaSelecionada=%@"
#define WS_URL_INFO_CIRCUITS_ALL_INCLUDE_INFO    @"IdWS=%@&CodSite=%@&CodProduto=%@&DtaSelecionada=%@"

#define WS_URL_CHAT_SEND_MESSAGE_INFO            @"codigoVendedor=%@&codigoConsumidor=%@&tipoMensagem=%@&descricaoMensagem=%@"
#define WS_URL_CHAT_RECIVE_MESSAGE_INFO          @"codigoVendedor=%@&codigoConsumidor=%@&indEntregue=%@"

#pragma mark - LOG MESSAGE

#define LOG_BUTTON_CANCEL       			@"Ok"
#define LOG_TITLE_MAIL_SUCCESS  			@"E-mail eviado"
#define LOG_TEXT_MAIL_SUCCESS   			@"Seu convite myPota já foi envidado ao seu vendedor favorito"
#define LOG_TITLE_MAIL_FILED    			@"E-mail Arquivado"
#define LOG_TEXT_MAIL_FILED     			@"Você pode visualisar o e-mail na sua caixa de e-mails"

#pragma mark - Tag's Parser

#define TAG_ERRO                			@"erro"
#define TAG_SELLER              			@"vendedor"
#define TAG_CITY                			@"cidade"
#define TAG_AGENCY              			@"agencia"
#define TAG_SEND_MAIL           			@"msg"
#define TAG_SEND_MAIL_SUCCESS   			@"Email enviado"
#define TAG_SEARCH_HOTEL        			@"BuscaHotel"
#define TAG_DETAILS             			@"detalhes"
#define TAG_TOKEN               			@"Token"
#define TAG_SEQUENCE_LAST       			@"sequenciaAnterior"
#define TAG_SEQUENCE_NEW        			@"sequenciaAtual"
#define TAG_FINISH              			@"finalizado"
#define TAG_FINISH_NEW          			@"Finalizado"
#define TAG_HOTEL               			@"hotel"
#define TAG_TRAVEL_DESTINY      			@"destino"
#define TAG_TRAVEL_TYPE                     @"tipoProduto"
#define TAG_TRAVEL_PLAN         			@"plano"
#define TAG_TRAVEL_PLAN_INFO    			@"Cobertura"
#define TAG_TRAVEL_PLAN_INFO_CONTRACT       @"Contrato"

#define TAG_PACK_TYPES                      @"Area"

#define TAG_PACK_COD_AREA                   @"CodArea"
#define TAG_PACK_COD_GROUP                  @"CodGrupoArea"
#define TAG_PACK_COD_PORTAL                 @"CodPortal"
#define TAG_PACK_COD_SITE                   @"CodSite"
#define TAG_PACK_DSC_AREA                   @"DscArea"
#define TAG_PACK_SEO_DESCRIPTION            @"SeoDescricao"
#define TAG_PACK_SEO_PASSWORD               @"SeoPalavraChave"
#define TAG_PACK_SEO_TITLE                  @"SeoTitulo"
#define TAG_PACK_TYPE_AREA                  @"TpoArea"

#define TAG_BUY_BUDGET              		@"Orcamento"
#define TAG_BUY_BUDGET_ERRO 	  			@"CodErro"
#define TAG_BUY_BUDGET_ORCAMENTO  			@"CodOrcamento"
#define TAG_BUY_BUDGET_PORTAL	  			@"CodPortal"
#define TAG_BUY_BUDGET_SITE		  			@"CodSite"
#define TAG_BUY_BUDGET_DATA_START 			@"DtaOrcamento"
#define TAG_BUY_BUDGET_DATA_END	  			@"DtaValidade"
#define TAG_BUY_BUDGET_MOEDA      			@"Moeda"
#define TAG_BUY_BUDGET_NOME_PORTAL 			@"NomPortal"
#define TAG_BUY_BUDGET_PROPOSTA				@"VlrProposta"

#define TAG_BUY_PURCHASE                	@"ReservaPedido"
#define TAG_BUY_PURCHASE_ERRO           	@"CodErro"
#define TAG_BUY_PURCHASE_CODE_RESERVA   	@"CodReservaPedido"
#define TAG_BUY_PURCHASE_CODE_SITE      	@"CodSite"
#define TAG_BUY_PURCHASE_CODE_PORTAL    	@"CodPortal"
#define TAG_BUY_PURCHASE_PORTAL         	@"NomPortal"
#define TAG_BUY_PURCHASE_MOEDA          	@"Moeda"
#define TAG_BUY_PURCHASE_VALOR          	@"VlrReservaPedido"
#define TAG_BUY_PURCHASE_STATUS         	@"Status"
#define TAG_BUY_PURCHASE_DATA_START     	@"DtaReservaPedido"
#define TAG_BUY_PURCHASE_DATA_END       	@"DtaValidade"

#define TAG_BUY_SUCCESS                 	@"Pagamento"
#define TAG_BUY_ERRO                    	@"CodErro"
#define TAG_BUY_ERRO_TEXT               	@"DscErro"
#define TAG_BUY_VOUCHER                 	@"SenhaVoucher"

#pragma mark - Mail Convite

#define WS_MAIL_FROM           			 	@"system@systos.com.br"
#define WS_MAIL_SUBJECT        			 	@"Convite para fazer parte do myPota"
#define WS_MAIL_INVITE         			 	@"<html><style>b {color:blue;}</style></head><body lang=PT-BR><h1><strong><left>Convite myPota para %@</center></strong></h1>%@<p align=left size=2 font face=verdana>Olá sua agência não foi encontrada no Aplicativo myPota.<br>Um dos nossos usuários está sugerindo que você faça parte deste aplicativo.<br>O uso é gratuito, aproveite e boas vendas.<br>Para conhecer mais acesse:<strong><b>http://www.mypota.com.br</b></p></body></html>"
#define WS_MAIL_LOGO            			@"" //"<center><img src=http://cdn.touroperator.com.br/func/imagens/img_vital.gif /></center>"

#pragma mark - ERROR MESSAGES

#define ERROR_BUTTON_CANCEL     			@"Ok"
#define ERROR_1000_TITLE        			@"Erro 1000"
#define ERROR_1000_MESSAGE      			@"nenhuma informação foi encontrada"
#define ERROR_1001_TITLE        			@"Erro 1001"
#define ERROR_1001_MESSAGE      			@"código do agente P.O.T.A. inválido"
#define ERROR_1002_TITLE        			@"Erro 1002"
#define ERROR_1002_MESSAGE      			@"myPota não conseguil enviar o e-mail, tente novamente mais tarde"
#define ERROR_1003_TITLE        			@"Erro 1003"
#define ERROR_1003_MESSAGE      			@"myPota não conseguil recuperar os dados tente novamente"
#define ERROR_1004_TITLE        			@"Erro 1004"
#define ERROR_1004_MESSAGE      			@"Este vendedor não cadastrou seu endereço corretamente"
#define ERROR_1005_TITLE        			@"Erro 1005"
#define ERROR_1005_MESSAGE      			@"Este aparelho não faz ligações"
#define ERROR_1006_TITLE        			@"Erro 1006"
#define ERROR_1006_MESSAGE      			@"O vendedor não cadastrou o facebook"
#define ERROR_1007_TITLE        			@"Erro 1007"
#define ERROR_1007_MESSAGE      			@"O perfil do vendedor não foi encontrado"
#define ERROR_1008_TITLE        			@"Erro 1008"
#define ERROR_1008_MESSAGE      			@"O vendedor não cadastrou o skype"
#define ERROR_1009_TITLE        			@"Erro 1009"
#define ERROR_1009_MESSAGE      			@"Você não tem o aplicativo do skype! Baixe o skype na app store para utiliza este recurso"
#define ERROR_1010_TITLE        			@"Erro 1010"
#define ERROR_1010_MESSAGE      			@"O vendedor não cadastrou seu whatsapp"
#define ERROR_1011_TITLE        			@"Erro 1011"
#define ERROR_1011_MESSAGE      			@"Você não tem o aplicativo do whatsapp! Baixe o whatsapp na app store para utiliza este recurso"
#define ERROR_1012_TITLE        			@"Erro 1012"
#define ERROR_1012_MESSAGE      			@"Não foi possivel se conectar ao servidor, tente novamente mais tarde!"
#define ERROR_1013_TITLE        			@"Erro 1013"
#define ERROR_1013_MESSAGE      			@"Não foi possivel conectar \ntente novamente."
#define ERROR_1014_MESSAGE      			@"Não encontramos resultados.\nPesquise novamente."
#define ERROR_1015_TITLE        			@"Erro 1015"
#define ERROR_1015_MESSAGE      			@"O tipo do quarto 1 não foi definido. \nPor favor, escolha o tipo de quarto antes de concluir o pedido."
#define ERROR_1016_TITLE        			@"Erro 1016"
#define ERROR_1016_MESSAGE      			@"O tipo do quarto 2 não foi definido. \nPor favor, escolha o tipo de quarto antes de concluir o pedido."
#define ERROR_1017_TITLE        			@"Erro 1017"
#define ERROR_1017_MESSAGE      			@"O tipo do quarto 3 não foi definido. \nPor favor, escolha o tipo de quarto antes de concluir o pedido."
#define ERROR_1018_TITLE        			@"Erro 1018"
#define ERROR_1018_MESSAGE      			@"O tipo do quarto 4 não foi definido. \nPor favor, escolha o tipo de quarto antes de concluir o pedido."
#define ERROR_1019_TITLE        			@"Erro 1019"
#define ERROR_1019_MESSAGE      			@"Por favor, selecione seu destino."
#define ERROR_1020_TITLE        			@"Erro 1020"
#define ERROR_1020_MESSAGE      			@"Por favor, selecione a data da viagem."
#define ERROR_1021_TITLE        			@"Erro 1021"
#define ERROR_1021_MESSAGE      			@"Por favor, informe-nos quantas pessoas irão viajar."
#define ERROR_1022_TITLE        			@"Erro 1022"
#define ERROR_1022_MESSAGE      			@"Por favor, insira o primeiro nome do viajante numero %d."
#define ERROR_1023_TITLE        			@"Erro 1023"
#define ERROR_1023_MESSAGE      			@"Por favor, insira o sobrenome do viajante numero %d."
#define ERROR_1024_TITLE        			@"Erro 1024"
#define ERROR_1024_MESSAGE      			@"Por favor, insira a idade real do viajante numero %d."
#define ERROR_1025_TITLE        			@"Erro 1025"
#define ERROR_1025_MESSAGE      			@"Por favor, insira um CPF válido para o viajante %d."
#define ERROR_1026_TITLE        			@"Erro 1026"
#define ERROR_1026_MESSAGE      			@"Por favor, insira um quarto válido para o viajante %d."
#define ERROR_1027_TITLE        			@"Erro 1027"
#define ERROR_1027_MESSAGE      			@"As idades informadas não batem com os viajantes, por favor verifique para prosseguir"
#define ERROR_1028_TITLE        			@"Erro 1028"
#define ERROR_1028_MESSAGE      			@"O e-mail informado para o viajante %d é invalido "
#define ERROR_1029_TITLE        			@"Erro 1029"
#define ERROR_1029_MESSAGE      			@"O telefone informado para o viajante %d é invalido"
#define ERROR_1030_TITLE        			@"Erro 1030"
#define ERROR_1030_MESSAGE      			@"Por favor, insira o número de um cartão de crédito válido."
#define ERROR_1031_TITLE        			@"Erro 1031"
#define ERROR_1031_MESSAGE      			@"Por favor, insira um código de segurança válido."
#define ERROR_1032_TITLE        			@"Erro 1032"
#define ERROR_1032_MESSAGE      			@"Por favor, insira o nome completo do titular do cartão."
#define ERROR_1033_TITLE        			@"Erro 1033"
#define ERROR_1033_MESSAGE      			@"Por favor, insira um mês válido."
#define ERROR_1034_TITLE        			@"Erro 1034"
#define ERROR_1034_MESSAGE      			@"Por favor, insira um ano válido."
#define ERROR_1035_TITLE        			@""
#define ERROR_1035_MESSAGE      			@"O periodo desejado é maior do que %d dias, por favor selecione um periodo menor."
#define ERROR_1036_TITLE        			@"Erro 1036"
#define ERROR_1036_MESSAGE      			@"Este aparelho não envia SMS!"
#define ERROR_1037_TITLE        			@"Erro 1037"
#define ERROR_1037_MESSAGE      			@"Por favor, selecione o tipo de viagem."
#define ERROR_1038_TITLE        			@"Erro 1038"
#define ERROR_1038_MESSAGE      			@"O CEP informado não é valido."
#define ERROR_1039_TITLE        			@"Erro 1039"
#define ERROR_1039_MESSAGE      			@"Para prosseguir informe o endereço."
#define ERROR_1040_TITLE        			@"Erro 1040"
#define ERROR_1040_MESSAGE      			@"Para prosseguir informe a cidade."
#define ERROR_1041_TITLE        			@"Erro 1041"
#define ERROR_1041_MESSAGE      			@"Para prosseguir informe o estado."

#pragma mark - HOTEL RESULT MESSAGES

#define HOTEL_MESSAGE_1000      			@"Nenhum hotel foi encontrado para está pesquisa"
#define HOTEL_MESSAGE_1001      			@"Ouve um erro na conexão, por favor tente novamente"
#define HOTEL_MESSAGE_1002      			@"Conectando"
#define HOTEL_MESSAGE_1003      			@"Obtendo Token"
#define HOTEL_MESSAGE_1004      			@"Buscando Hoteis"

#pragma mark - BUY PURCHASE MESSAGES

#define BUY_HOTEL_TITLE                     @"Pedido em ordem!"
#define BUY_HOTEL_MESSAGE                   @"O pedido de compra no valor de %@ foi gerado, insira os dados do seu cartão para presseguir!"

#define BUY_TRAVEL_TITLE                    @"Plano escolhido com sucesso!"
#define BUY_TRAVEL_MESSAGE                  @"Para prosseguir preencha os dados a seguir."
#define BUY_TRAVEL_TITLE_MONEY              @"Pedido gerado com sucesso!"
#define BUY_TRAVEL_MESSAGE_MONEY            @"O pedido de compra no valor de R$%.2f foi gerado, insira os dados do seu cartão para presseguir!"
#define BUY_TRAVEL_TITLE_BUDGET_FAIL        @"Erro %@"
#define BUY_TRAVEL_MESSAGE_BUDGET_FAIL      @"Não foi possivel criar o orçamento, revise os dados e tente novamente!"
#define BUY_TRAVEL_TITLE_PURCHASE_FAIL      @"Erro %@"
#define BUY_TRAVEL_MESSAGE_PURCHASE_FAIL    @"Não foi possivel criar o pedido de compra, tente novamente!"

#define BUY_CARD_TITLE_SUCCESS              @"Compra Efetuada com sucesso!"
#define	BUY_CARD_MESSAGE_SUCCESS            @"Seu voucher é: %@"
#define BUY_CARD_TITLE_ERROR                @"Erro %@"
#define	BUY_CARD_MESSAGE_ERROR              @"%@"

#define BUY_MESSAGE_1000                    @"Estamos gerando o orçamento.\n Por favor aguarde."
#define BUY_MESSAGE_1001                    @"Estamos processando o seu pedido.\n Por favor aguarde."
#define BUY_MESSAGE_1002                    @"Estamos validando suas informações e finalizando sua compra."

#endif