//
//  packInfoDetail.h
//  myPota
//
//  Created by Rodrigo Pimentel on 03/11/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "packInfo.h"

@interface packInfoDetail : UIViewController <UIWebViewDelegate>
{
    IBOutlet UILabel   *lblTitle;
    IBOutlet UIWebView *webView;
    
    packInfo     *backScreen;
    NSString     *typeScreen;
    NSString     *typeLink;
}

@end
