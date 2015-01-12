//
//  AppDelegate.m
//  webServiceControl
//
//  Created by Rodrigo Pimentel on 06/02/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

#pragma mark -readPlist
- (NSString *)dataFilePath:(NSString *)path {
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:path];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    id rootView;
    NSString *path = [self dataFilePath:@"VendedorData"];
    NSMutableDictionary *list = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    if ([[list objectForKey:@"Chosen"] boolValue])
        rootView = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:STORYBOARD_ID_A2];
    else
    {
        path = [self dataFilePath:@"CadastreData"];
        NSMutableDictionary *listCadastre = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        
        if ([[listCadastre objectForKey:@"Complete"] boolValue])
            rootView = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:STORYBOARD_ID_B1];
        else
            rootView = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:STORYBOARD_ID_A1];
    }
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootView];
    MWFSlideNavigationViewController *slideNav = [[MWFSlideNavigationViewController alloc] initWithRootViewController:navigationController];
    self.window.rootViewController = slideNav;
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)
                                                                             categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
    
    return YES;
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    NSLog(@"Received notification: %@", userInfo);
    [AppFunctions LOG_MESSAGE:@"Aviso de teste:"
                      message:[[userInfo objectForKey:@"aps"]objectForKey:@"alert"]
                       cancel:ERROR_BUTTON_CANCEL];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    _tokenPhone = [[[[NSString stringWithFormat:@"%@",deviceToken]
                    stringByReplacingOccurrencesOfString:@" " withString:@""]
                    stringByReplacingOccurrencesOfString:@"<" withString:@""]
                    stringByReplacingOccurrencesOfString:@">" withString:@""];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
    _tokenPhone = @"1f9287f1f8e083769442723072c9ecf966eb99c716dd3e7a31dd644af64f121b";
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    return wasHandled;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
