//
//  b1_User_Search.h
//  myPota
//
//  Created by Rodrigo Pimentel on 07/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "States.h"

@interface b1_User_Search : UIViewController <UITextFieldDelegate,NSFetchedResultsControllerDelegate>
{
    IBOutlet UIScrollView       *scrollViewData;
    IBOutlet UITextField        *lblCode;
    IBOutlet UIButton           *outCodePota;
    States                      *listState;
    NSMutableDictionary         *agenteInfo;
    NSMutableArray              *agenteInfoIdWs;
    NSFetchedResultsController  *fetch;
#pragma mark - keyBoardScroll
    UITextField             *keyboardField;
    CGRect                  frame;
    __weak IBOutlet UIButton *otlBtnSearch;
    __weak IBOutlet UIButton *otlBtnInvite;
}

- (IBAction)txtCodePotaChange:(id)sender;
- (IBAction)btnCodePota:(id)sender;
- (IBAction)btnSearchPota:(id)sender;
- (IBAction)btnInvite:(id)sender;
- (IBAction)btnLogoff:(id)sender;

@end