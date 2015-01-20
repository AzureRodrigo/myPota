//
//  agentePerfilPota.h
//  myPota
//
//  Created by Rodrigo Pimentel on 08/09/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "agentePerfilPotaCell.h"
#import "agentePerfilPotaCellConfirm.h"

@interface c1_Agent_Perfil_Pota : UIViewController
{
    IBOutlet UIImageView *SellerImage;
    IBOutlet UILabel     *SellerName;
    IBOutlet UILabel     *SellerAgency;
    IBOutlet UILabel     *SellerMail;
    
#pragma mark -loadData
    NSDictionary            *dataSeller;
    NSDictionary            *dataAgency;
    NSMutableDictionary 	*listState;
    
#pragma mark -map
    IBOutlet UIButton       *otlMap;
    NSString 				*mapState;
    NSString 				*mapCity;
}

- (IBAction)btnMap:(id)sender;
- (IBAction)btnClients:(id)sender;
- (IBAction)btnMenu:(id)sender;

@end
