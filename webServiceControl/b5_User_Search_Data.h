//
//  searchPOTA.h
//  myPota
//
//  Created by Rodrigo Pimentel on 08/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "States.h"

@interface b5_User_Search_Data : UIViewController <UITextFieldDelegate>
{
#pragma mark -infoStateCity
    IBOutlet UIButton       *otlState;
    BOOL stateSelect;
    IBOutlet UIButton       *otlCity;
    IBOutlet UIButton       *otlSearch;
    IBOutlet UITextField    *otlTxtName;
#pragma mark -States
    NSMutableDictionary     *pList;
    NSMutableArray          *listEstadosSigla;
    NSMutableArray          *listEstadosNomes;
    States                  *listStateData;
    NSString                *stateSigla;
    NSString                *saveState;
    NSString                *codCity;
    NSString                *saveCity;
    NSString                *lblBairro;
    NSString                *lblAgencia;
#pragma mark -Mail
    NSString                *lblEmail;
#pragma mark - keyBoardScroll
    UITextField             *keyboardField;
    CGRect                  frame;
}

#pragma mark -infoStateCity
- (BOOL)getStateSelect;
- (void)setStateName:(NSString *)name;
- (IBAction)btnState:(id)sender;
- (IBAction)btnCity:(id)sender;
- (IBAction)btnSearch:(id)sender;
#pragma mark -functions
- (NSMutableArray *)getStateData;
- (void)selectNewState;
#pragma mark -functions
- (States *)getStatesData;
@end