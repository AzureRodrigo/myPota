//
//  b3_User_Chat.h
//  myPota
//
//  Created by Rodrigo Pimentel on 15/12/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface b3_User_Chat : UIViewController <UITextFieldDelegate>
{
    NSDictionary *seller;
    NSString     *codSeller;
    NSString     *codUser;
    NSString     *link;
    CGRect       frame;
    IBOutlet UITextField *menssageBox;
}

@end
