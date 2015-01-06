//
//  agentePerfilPota.h
//  myPota
//
//  Created by Rodrigo Pimentel on 08/09/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "c0_Agent_Login.h"
#import "agentePerfilPotaCell.h"
#import "agentePerfilPotaCellConfirm.h"

@interface c1_Agent_Perfil_Pota : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UIImageView *SellerImage;
    IBOutlet UILabel     *SellerName;
    IBOutlet UILabel     *SellerAgency;
    IBOutlet UILabel     *SellerMail;
    IBOutlet UITableView *tableView;
    c0_Agent_Login       *backScreen;
    NSMutableDictionary  *listInfos;
    NSMutableDictionary  *listContact;
#pragma mark -map
    IBOutlet UIButton       *otlMap;
    NSString 				*mapState;
    NSString 				*mapCity;
}

- (IBAction)btnMap:(id)sender;
- (IBAction)btnClients:(id)sender;
- (IBAction)btnEditInfo:(id)sender;
- (IBAction)btnMenu:(id)sender;

@end
