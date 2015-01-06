//
//  b2_User_Pefil_Pota.h
//  myPota
//
//  Created by Rodrigo Pimentel on 07/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "b1_User_Search.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "CustomIOS7AlertView.h"
#import "WhatsAppKit.h"
#import "myPerfilRessourcesCell.h"
#import "myPerfilChatBtn.h"
#import "myPerfilMenuBtn.h"

/*
[listInfos objectForKey:@""]
*/

@interface b2_User_Pefil_Pota : UIViewController <MFMailComposeViewControllerDelegate,CustomIOS7AlertViewDelegate> //UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView    *tableViewData;
    NSArray                 *contactInfo;
#pragma mark -outlets images
    UIImageView             *imgPerfil;
#pragma mark -outlets buttons
    IBOutlet UIButton 		*otlMap;
#pragma mark -labels
    IBOutlet UILabel 		*lblName;

    IBOutlet UILabel 		*lblNameAgency;
    IBOutlet UILabel 		*lblMail;
#pragma mark -loadData
    NSMutableDictionary 	*listInfos;
    NSMutableDictionary 	*listState;
#pragma mark -plist
    NSString 				*path;
    NSString 				*pathState;
    b1_User_Search 			*backScreen;
#pragma mark -map
    NSString 				*mapState;
    NSString 				*mapCity;
#pragma mark -menuOption
    CustomIOS7AlertView 	*menuOption;
    
#pragma mark -ButtonsCommunication
    IBOutlet UIButton *otlMail;
    IBOutlet UIButton *otlFace;
    IBOutlet UIButton *otlFone;
    IBOutlet UIButton *otlMessenge;
    IBOutlet UIButton *otlSkype;
    IBOutlet UIButton *otlWhatsapp;
}

#pragma mark -actions button
- (IBAction)btnMap:(id)sender;
- (IBAction)btnChat:(id)sender;
- (IBAction)btnGoMenu:(id)sender;

#pragma mark -ButtonsCommunication
- (IBAction)btnMail:(id)sender;
- (IBAction)btnFone:(id)sender;
- (IBAction)btnFace:(id)sender;
- (IBAction)btnSkype:(id)sender;
- (IBAction)btnWhatsapp:(id)sender;
- (IBAction)btnMenssage:(id)sender;

@end
