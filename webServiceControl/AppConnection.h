//
//  AppConnection.h
//  myPota
//
//  Created by Rodrigo Pimentel on 20/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomIOS7AlertView.h"

#pragma mark - Tag Dictionary
#define APP_CONNECTION_TAG_START  @"START"
#define APP_CONNECTION_TAG_WAIT   @"WAIT"
#define APP_CONNECTION_TAG_RECIVE @"RECIVE"
#define APP_CONNECTION_TAG_FINISH @"FINISH"
#define APP_CONNECTION_TAG_ERROR  @"ERROR"

#pragma mark - C declaration
void (^block)(NSData *);

@interface appConnection : NSObject <CustomIOS7AlertViewDelegate>
{
    //variaveis da connexão
    NSURLConnection     *connection;
    NSURL               *connectionUrl;
    NSURLRequest        *connectionRequest;
    NSError             *connectionError;
    NSMutableData       *connectionData;
    //variaveis de visual
    CustomIOS7AlertView *connectionView;
    NSDictionary        *labelList;
    UILabel             *labelStatus;
    BOOL                showView;
}

#pragma mark - public function
+ (void)START_CONNECT:(NSString *)url timeForOu:(float)_time labelConnection:(NSDictionary *)labels showView:(BOOL)showView block:(void (^)(NSData *result))function;

@end
