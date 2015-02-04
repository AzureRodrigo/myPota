//
//  b10_User_Messages.h
//  mypota
//
//  Created by Rodrigo Pimentel on 20/01/15.
//  Copyright (c) 2015 web. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "b10_Cell_Message.h"

@interface b10_User_Messages : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSString                    *message;
    NSArray                     *messageList;
    __weak IBOutlet UITableView *tableViewData;
}

- (IBAction)btnNewMessage:(id)sender;
- (NSString *)getMessage;
- (NSString *)getClientCode;
- (NSString *)getClientName;

@end