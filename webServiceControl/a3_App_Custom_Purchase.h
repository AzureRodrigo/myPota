//
//  a3_App_Custom_Purchase.h
//  mypota
//
//  Created by Rodrigo Pimentel on 27/02/15.
//  Copyright (c) 2015 web. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface a3_App_Custom_Purchase : UIViewController <UITextViewDelegate,MBProgressHUDDelegate>
{
    __weak IBOutlet UIScrollView *ScrollView;
    __weak IBOutlet UITextView   *txtDestiny;
    __weak IBOutlet UITextView   *txtData;
    __weak IBOutlet UITextView   *txtTravellers;
    __weak IBOutlet UITextView   *txtChildrens;
    __weak IBOutlet UITextView   *txtDetails;
    __weak IBOutlet UIButton     *btnSend;
    __weak IBOutlet UISwitch     *swipperHotel;
    __weak IBOutlet UISwitch     *swipperTravel;
    __weak IBOutlet UISwitch     *swipperFly;
    UITextField *txtViewSelected;
    CGPoint     scrollPoint;
    
    NSNotification *keyboard;
    int         scrollState;
    BOOL        startScroll;
    BOOL        endScroll;
    BOOL        touchScroll;
    NSString    *IDWS;
    MBProgressHUD        *HUD;
}

- (IBAction)btnSend:(id)sender;

@end
