//
//  p3_1_Package_Conditions.h
//  mypota
//
//  Created by Rodrigo Pimentel on 02/04/15.
//  Copyright (c) 2015 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "p3_Package_Detail.h"

@interface p3_1_Package_Conditions : UIViewController <MBProgressHUDDelegate>
{
    MBProgressHUD      *HUD;
    IBOutlet UIWebView *webView;
    
    p3_Package_Detail  *backScreen;
    NSString     *typeScreen;
}

@end
