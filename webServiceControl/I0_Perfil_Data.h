//
//  I0_Perfil_Data.h
//  myPota
//
//  Created by Rodrigo Pimentel on 05/06/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface I0_Perfil_Data : UIViewController <FBLoginViewDelegate>
{
    NSDictionary *dataPerfil;
    
    __weak IBOutlet UILabel *lblName;
    __weak IBOutlet UILabel *lblMail;
    __weak IBOutlet UILabel *lblCPF;
    __weak IBOutlet UILabel *lblCEP;
    __weak IBOutlet UILabel *lblBirth;
    __weak IBOutlet UILabel *lblCode;
}

@end
