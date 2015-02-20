//
//  s0_Split_Menu.h
//  myPota
//
//  Created by Rodrigo Pimentel on 19/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "s0_Split_Menu_Cell.h"
#import "a2_App_Menu.h"
#import "MBProgressHUD.h"

@interface s0_Split_Menu : UIViewController <UITableViewDelegate, UITableViewDataSource,MBProgressHUDDelegate>
{
    UIImageView  *backgroundView;
    UITableView  *tableViewData;
    NSArray      *listOptions;
    NSDictionary *dataUser;
}

@property (nonatomic, strong) UIView *container;

@end
