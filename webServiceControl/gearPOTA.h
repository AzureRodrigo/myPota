//
//  gearPOTA.h
//  myPota
//
//  Created by Rodrigo Pimentel on 11/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "b2_User_Pefil_Pota.h"

@interface gearPOTA : UIViewController
{
    IBOutlet UIScrollView   *scrollViewData;
    IBOutlet UIButton       *gearMapa;
    b2_User_Pefil_Pota      *backScreen;
}

- (IBAction)btnFuso:(id)sender;
- (IBAction)btnCambio:(id)sender;
- (IBAction)btnConversor:(id)sender;
- (IBAction)btnFones:(id)sender;
- (IBAction)btnGuia:(id)sender;
- (IBAction)btnMapa:(id)sender;

@end
