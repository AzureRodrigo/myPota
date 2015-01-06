//
//  myPerfilPota.h
//  myPota
//
//  Created by Rodrigo Pimentel on 05/06/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface myPerfilPota : UIViewController <FBLoginViewDelegate>
{
    IBOutlet UIScrollView *scrollViewData;
    IBOutlet UITextField *lblName;
    IBOutlet UITextField *lblMail;
    IBOutlet UITextField *lblCPF;
    IBOutlet UITextField *lblCEP;
    IBOutlet UITextField *lblBirth;
    IBOutlet UITextField *lblPassword;
    IBOutlet UIScrollView *otlConfirm;
    BOOL faceConnect;
}

- (IBAction)btnConfirm:(id)sender;

@end
