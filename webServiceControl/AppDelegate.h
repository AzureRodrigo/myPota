//
//  AppDelegate.h
//  webServiceControl
//
//  Created by Rodrigo Pimentel on 06/02/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "s0_Split_Menu.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) NSString *tokenPhone;
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
