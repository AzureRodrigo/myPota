//
//  b3_User_Chat.h
//  myPota
//
//  Created by Rodrigo Pimentel on 15/12/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "b10_User_Messages.h"
#import "HPGrowingTextView.h"

@interface b3_User_Chat : UIViewController <HPGrowingTextViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    b10_User_Messages           *backScreen;
    __weak IBOutlet UITableView *tableViewData;
    CGRect                      tableFrame;
    UIView                      *containerView;
    HPGrowingTextView           *textView;
    UIButton                    *doneBtn;
    NSString                    *link;
    
    
    
    NSMutableArray              *listMessages;
}

@end
