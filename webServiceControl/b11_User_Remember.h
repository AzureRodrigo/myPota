//
//  b11_User_Remember.h
//  mypota
//
//  Created by Rodrigo Pimentel on 28/01/15.
//  Copyright (c) 2015 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface b11_User_Remember : UIViewController <UITextFieldDelegate>
{
    UITextField                 *keyboardField;
    __weak IBOutlet UITextField *oltMail;
    __weak IBOutlet UIButton    *otlSend;
    CGRect                      frame;
}

- (IBAction)btnSend:(id)sender;

@end
