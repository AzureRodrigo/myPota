
//  c0_Agent_Login.h
//  myPota
//
//  Created by Rodrigo Pimentel on 08/09/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface c0_Agent_Login : UIViewController <UITextFieldDelegate, NSFetchedResultsControllerDelegate,MBProgressHUDDelegate>
{
    IBOutlet UITextField       *txtLogin;
    IBOutlet UITextField       *txtPassword;
    IBOutlet UIButton          *btnOtlConfigApp;
    CGRect                     frame;
    UITextField                *txtSelect;
    NSMutableDictionary        *login;
    
    //DataBase
    NSMutableDictionary        *user;
    NSMutableArray             *idWs;
    NSMutableDictionary        *agency;
    NSFetchedResultsController *fetch;
    NSMutableDictionary        *agenteInfo;
    NSMutableArray             *agenteInfoIdWs;
    MBProgressHUD           *HUD;

}

- (IBAction)btnConfigApp:(id)sender;

@end
