//
//  packInfoDetail.h
//  myPota
//
//  Created by Rodrigo Pimentel on 03/11/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "p2_Package_Info.h"

@interface p3_Package_Detail : UIViewController <UIWebViewDelegate, MBProgressHUDDelegate>
{
    MBProgressHUD      *HUD;
    IBOutlet UILabel   *lblTitle;
    IBOutlet UIWebView *webView;
    
    p2_Package_Info     *backScreen;
    NSString     *typeScreen;
    NSString     *typeLinkInfo;
    NSString     *typeLinkDay;
    NSString     *typeLinkCondictions;
    
}

- (NSString *)getLink;
@end
