//
//  b9_User_Cadastre.h
//  mypota
//
//  Created by Rodrigo Pimentel on 20/01/15.
//  Copyright (c) 2015 web. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface b9_User_Cadastre : UIViewController <UITextFieldDelegate,NSFetchedResultsControllerDelegate,MBProgressHUDDelegate>
{
    UITextField                 *keyboardField;
    UIDatePicker                *datePicker;
    CGRect                      frame;
    NSMutableDictionary         *user;
    NSFetchedResultsController  *fetch;

    IBOutlet UITextField        *lblName;
    IBOutlet UITextField        *lblMail;
    IBOutlet UITextField        *lblPassword;
    IBOutlet UITextField        *lblCpf;
    IBOutlet UITextField        *lblCep;
    IBOutlet UITextField        *lblBirth;
    
    IBOutlet UIButton           *otlCadastre;
    MBProgressHUD           *HUD;
}

- (IBAction)btnCadastre:(id)sender;

@end
