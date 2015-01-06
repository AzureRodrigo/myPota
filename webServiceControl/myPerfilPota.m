//
//  myPerfilPota.m
//  myPota
//
//  Created by Rodrigo Pimentel on 05/06/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "myPerfilPota.h"

@interface myPerfilPota ()

@end

@implementation myPerfilPota

- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_CLEAN
                                     title:@"Meu "
                                superTitle:@"Perfil"
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_INIT
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:@selector(menuOpen:)
                                backButton:YES];
}

- (IBAction)menuOpen:(id)sender
{
    //    [menuView openMenu:sender];
}


- (IBAction)btnBackScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initScroll
{
    //    [AppFunctions SET_SCROLL:scrollViewData
    //                       frame:otlConfirm.frame
    //                      center:otlConfirm.center];
}

- (void)initFaceButton
{
    FBLoginView *loginview = [[FBLoginView alloc] init];
    
    loginview.frame = CGRectOffset(loginview.frame,
                                   CGRectGetMidX(self.view.frame) - loginview.frame.size.width * .5f,
                                   self.view.frame.size.height * .03f);
#ifdef __IPHONE_7_0
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        loginview.frame = CGRectOffset(loginview.frame,
                                       0,
                                       self.view.frame.size.height * .01f);    }
#endif
#endif
#endif
    loginview.delegate = self;
    
    loginview.readPermissions = FACEBOOK_APP_PERMS;
    faceConnect               = NO;
    [self.view addSubview:loginview];
    
    [loginview sizeToFit];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initFaceButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [self initScroll];
    [super viewWillAppear:animated];
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user
{
    if (!faceConnect) {
        faceConnect = YES;
        [self setFaceInfo:user];
    }
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    faceConnect = NO;
}

- (void)setFaceInfo:(id)infos
{
    [lblName setText:[infos objectForKey:@"name"]];
    [lblMail setText:[infos objectForKey:@"email"]];
    [lblBirth setText:[infos objectForKey:@"birthday"]];
}

- (BOOL)verifyCard
{
    if ([[lblName text] length] != 3){
        [AppFunctions LOG_MESSAGE:ERROR_1030_TITLE
                          message:ERROR_1030_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    if(![AppFunctions VALID_MAIL:[lblMail text]]) {
                [AppFunctions LOG_MESSAGE:ERROR_1031_TITLE
                                  message:ERROR_1031_MESSAGE
                                   cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    if(![AppFunctions VALID_CPF:[lblCPF text]]) {
        [AppFunctions LOG_MESSAGE:ERROR_1031_TITLE
                          message:ERROR_1031_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:LINK_CEP_VALIDATION, [lblCEP text]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSDictionary *allData = (NSDictionary *)[[AzParser alloc] xmlDictionary:data tagNode:@"cep"];
    for (NSDictionary *tmp in [allData objectForKey:@"cep"]) {
        if (![[tmp objectForKey:@"status"] isEqualToString:@"1"])
            return NO;
    }
    
    //    if ([[lblBirth text] length] == 0){
    //        [AppFunctions LOG_MESSAGE:ERROR_1032_TITLE
    //                          message:ERROR_1032_MESSAGE
    //                           cancel:ERROR_BUTTON_CANCEL];
    //        return NO;
    //    }
    //    if ([[lblPassword text] length] != 3){
    //        [AppFunctions LOG_MESSAGE:ERROR_1031_TITLE
    //                          message:ERROR_1031_MESSAGE
    //                           cancel:ERROR_BUTTON_CANCEL];
    //        return NO;
    //    }
    
    return YES;
}

- (IBAction)btnConfirm:(id)sender
{
    if ([self verifyCard]) {
        NSLog(@"aqui");
    }
}

@end
