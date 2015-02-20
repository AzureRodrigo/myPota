//
//  sendInvitePota.h
//  myPota
//
//  Created by Rodrigo Pimentel on 30/06/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface b4_User_Invite_Pota : UIViewController <UITextFieldDelegate,MBProgressHUDDelegate>
{
    IBOutlet UIButton    *otlMail;
    IBOutlet UITextField *btnName;
    IBOutlet UITextField *btnMail;
#pragma mark - textView
    UITextField          *txtViewSelected;
    CGRect               frame;
    MBProgressHUD           *HUD;
    NSString                *IDWS;
}

- (IBAction)btnMail:(id)sender;

@end
