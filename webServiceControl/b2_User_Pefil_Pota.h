//
//  b2_User_Pefil_Pota.h
//  myPota
//
//  Created by Rodrigo Pimentel on 07/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "WhatsAppKit.h"
#import "myPerfilRessourcesCell.h"
#import "myPerfilChatBtn.h"
#import "myPerfilMenuBtn.h"

/*
[listInfos objectForKey:@""]
*/

@interface b2_User_Pefil_Pota : UIViewController <MFMailComposeViewControllerDelegate,CustomIOS7AlertViewDelegate>
{

#pragma mark -outlets images
    UIImageView             *imgPerfil;
#pragma mark -outlets buttons
    IBOutlet UIButton 		*otlMap;
#pragma mark -labels
    IBOutlet UILabel 		*lblName;

    IBOutlet UILabel 		*lblNameAgency;
    IBOutlet UILabel 		*lblMail;
#pragma mark -loadData
    NSDictionary            *dataSeller;
    NSDictionary            *dataAgency;
    NSMutableDictionary 	*listState;
#pragma mark -plist
    NSString 				*path;
    NSString 				*pathState;
#pragma mark -map
    NSString 				*mapState;
    NSString 				*mapCity;
    
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
- (IBAction)btnGoMenu:(id)sender;

#pragma mark -ButtonsCommunication
- (IBAction)btnMail:(id)sender;
- (IBAction)btnFone:(id)sender;
- (IBAction)btnFace:(id)sender;
- (IBAction)btnSkype:(id)sender;
- (IBAction)btnWhatsapp:(id)sender;
- (IBAction)btnMenssage:(id)sender;

@end
