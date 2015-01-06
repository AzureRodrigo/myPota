//
//  AppConnection.m
//  myPota
//
//  Created by Rodrigo Pimentel on 20/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "AppConnection.h"

#define AZ_CONNECTION_TITLE_FAIL_CONNECT     @"Erro de conexão numero: 0001"
#define AZ_CONNECTION_MESSAGE_FAIL_CONNECT   @"Não foi possivel iniciar a conexão, por favore tente novamente."
#define AZ_CONNECTION_CONCLUDE               @"Okey"

@implementation appConnection

+ (void)START_CONNECT:(NSString *)url timeForOu:(float)_time labelConnection:(NSDictionary *)labels showView:(BOOL)_showView block:(void (^)(NSData *result))function
{
    if ([DEBUG_TAG_SHOW_LINK_IN_CONNECTION isEqualToString:@"YES"])
        NSLog(@"\n%@\n",url);
    [[appConnection alloc]initConnection:url timeOut:_time labels:labels showView:_showView block:function];
}

- (void)initConnection:(NSString *)_url timeOut:(float)_time labels:(NSDictionary *)_labels showView:(BOOL)_showView block:(void (^)(NSData *result))function
{
    block                      = function;
    self->showView             = _showView;
    self->labelList            = [[NSDictionary alloc]initWithDictionary:_labels];
    self->connectionUrl        = [NSURL URLWithString:[_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    self->connectionRequest    = [NSURLRequest requestWithURL:self->connectionUrl
                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval:_time];
    self->connection = [[NSURLConnection alloc] initWithRequest:self->connectionRequest
                                                       delegate:self];
    if (!self->connection)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:AZ_CONNECTION_TITLE_FAIL_CONNECT
                                                        message:AZ_CONNECTION_MESSAGE_FAIL_CONNECT
                                                       delegate:nil
                                              cancelButtonTitle:AZ_CONNECTION_CONCLUDE
                                              otherButtonTitles:nil];
        [alert show];
    }else
        [self startConnection];
}

- (void)startConnection
{
    [self initView];
}

- (void)closeConnection
{
    [connectionView close];
    block (self->connectionData);
}

- (void)errorConnection
{
    [connectionView close];
    block (nil);
}

#pragma mark - View functions
- (void)initView
{
    connectionView  = [[CustomIOS7AlertView alloc] init];
    [connectionView setContainerView:[self LoadView]];
    [connectionView setButtonTitles:nil];
    [connectionView setDelegate:self];
    [connectionView setUseMotionEffects:true];
    if (self->showView)
        [connectionView show];
}

-(UIView *)LoadView
{
    UIView *loadView    = [[UIView alloc] initWithFrame:CGRectMake (0, 0, 290, 100)];
    self->labelStatus   = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 290, 30)];
    [self->labelStatus  setFont:[UIFont fontWithName:FONT_NAME size:19.0]];
    [self->labelStatus  setShadowColor:[UIColor clearColor]];
    [self->labelStatus  setNumberOfLines:2];
    [self->labelStatus  setTextColor:[UIColor blackColor]];
    [self->labelStatus  setText:[self->labelList objectForKey:APP_CONNECTION_TAG_START]];
    [self->labelStatus  setTextAlignment:NSTextAlignmentCenter];
    
    UIActivityIndicatorView *LoadBar = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    LoadBar.center  = CGPointMake(CGRectGetMidX(loadView.frame), loadView.frame.size.height * .7f);
    [loadView       addSubview:LoadBar];
    [LoadBar        startAnimating];
    [LoadBar        setHidesWhenStopped:YES];
    
    [loadView addSubview:LoadBar];
    [loadView addSubview:self->labelStatus];
    return loadView;
}

#pragma mark - Connection functions
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self->connectionData = [NSMutableData new];
    [self->labelStatus setText:[self->labelList objectForKey:APP_CONNECTION_TAG_WAIT]];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self->connectionData appendData:data];
    [self->labelStatus setText:[self->labelList objectForKey:APP_CONNECTION_TAG_RECIVE]];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self->labelStatus setText:[self->labelList objectForKey:APP_CONNECTION_TAG_FINISH]];
    [NSTimer scheduledTimerWithTimeInterval:.5f
                                     target:self
                                   selector:@selector(closeConnection)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self->labelStatus setText:[self->labelList objectForKey:APP_CONNECTION_TAG_ERROR]];
    connectionError = error;
    [NSTimer scheduledTimerWithTimeInterval:1.f
                                     target:self
                                   selector:@selector(errorConnection)
                                   userInfo:nil
                                    repeats:NO];
}

@end
