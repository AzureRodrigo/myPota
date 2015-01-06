//
//  splitViewPota.h
//  myPota
//
//  Created by Rodrigo Pimentel on 19/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "splitViewCell.h"
#import "a2_App_Menu.h"


@interface splitViewPota : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UIImageView *backgroundView;
    UITableView *tableViewData;
    NSArray     *listOptions;
}

@property (nonatomic, strong) UIView *container;

@end
