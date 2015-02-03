//
//  b3_User_Chat.h
//  myPota
//
//  Created by Rodrigo Pimentel on 15/12/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "b10_User_Messages.h"
#import "c2_Agent_Chat.h"
#import "b3_User_Chat_Cell.h"
#import "HPGrowingTextView.h"

@interface b3_User_Chat : UIViewController <HPGrowingTextViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    id                           backScreen;
    __weak IBOutlet UILabel *lblName;
    __weak IBOutlet UITableView *tableViewData;
    CGRect                      tableFrame;
    UIView                      *containerView;
    HPGrowingTextView           *textView;
    UIButton                    *doneBtn;
    NSString                    *link;
    
    NSDictionary                *dataSeller;
    NSDictionary                *dataUser;
    NSMutableArray              *listMessages;
    BOOL                        thisScreen;
    NSString                    *mycode;
    NSDictionary                *myType;
    
    CGRect                      frame;
}

@end
