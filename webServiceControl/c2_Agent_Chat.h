//
//  c2_Agent_Chat.h
//  myPota
//
//  Created by Rodrigo Pimentel on 15/12/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "c2_Agente_Chat_Cell.h"

@interface c2_Agent_Chat : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    
    __weak IBOutlet UILabel     *lblStatus;
    __weak IBOutlet UITableView *tableViewData;
    __weak IBOutlet UIActivityIndicatorView *loadView;
    
    NSMutableArray              *clients;
    
    NSDictionary                *dataSeller;
    NSDictionary                *dataUser;
    NSString                    *link;
    NSString                    *code;
    NSString                    *name;
}

- (NSString *)getClientCode;
- (NSString *)getClientName;
- (NSString *)getMessage;

@end
