//
//  a2_App_Menu.h
//  myPota
//
//  Created by Rodrigo Pimentel on 08/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "menuCell.h"

@interface a2_App_Menu : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tableViewData;
    IBOutlet UIButton    *otlMeuAgente;
    __weak IBOutlet UIButton *otlBtnMenu;
    NSDictionary         *dataUser;
    NSArray              *menuOption;
}

- (IBAction)btnMeuAgente:(id)sender;

@end