//
//  b0_User_Login.h
//  myPota
//
//  Created by Rodrigo Pimentel on 18/09/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface b0_User_Login : UIViewController <UITextFieldDelegate, NSFetchedResultsControllerDelegate,MBProgressHUDDelegate>
{
    IBOutlet UITextField       *txtMail;
    IBOutlet UITextField       *txtPassword;
    IBOutlet UIButton          *btnOtlConfigApp;
    CGRect                     frame;
    UITextField                *txtSelect;
    NSMutableDictionary        *login;
    
    //DataBase
    NSMutableDictionary        *user;
    NSFetchedResultsController *fetch;
    MBProgressHUD           *HUD;
}


- (IBAction)btnConfigApp:(id)sender;

@end
