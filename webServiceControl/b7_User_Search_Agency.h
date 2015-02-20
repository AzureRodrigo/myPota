//
//  choiceAgencia.h
//  myPota
//
//  Created by Rodrigo Pimentel on 09/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "b5_User_Search_Data.h"
#import "choiceAgenciaCell.h"

@interface b7_User_Search_Agency : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,MBProgressHUDDelegate>
{    
    IBOutlet UISearchBar    *searchBarData;
    IBOutlet UITableView    *tableViewData;
    b5_User_Search_Data     *backScreen;
    NSMutableArray          *listSearchAgencias;
    NSMutableArray          *listAgencias;
    Agencias                *SelectAgencia;
#pragma mark - textView
    UITextField          *txtViewSelected;
    CGRect               frame;
    MBProgressHUD           *HUD;
    NSString                *IDWS;
}

#pragma mark -getStatesData
- (States *)getAgenciaData;
- (Agencias *)getSelectAgencia;
@end
