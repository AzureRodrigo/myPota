//
//  c0_Agent_Login.h
//  myPota
//
//  Created by Rodrigo Pimentel on 08/09/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface c0_Agent_Login : UIViewController <UITextFieldDelegate>
{
    IBOutlet UITextField *txtLogin;
    IBOutlet UITextField *txtPassword;
    IBOutlet UIButton    *btnConfirm;
#pragma mark - textView
    UITextField          *txtViewSelected;
    CGRect               frame;
    
#pragma mark - Info
    NSMutableDictionary *login;
    NSMutableDictionary *agenteInfo;
}

- (IBAction)btnConfirm:(id)sender;
- (NSMutableDictionary *)getSellerInfo;
@end
