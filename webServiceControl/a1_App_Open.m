//
//  a1_App_Open.m
//  myPota
//
//  Created by Rodrigo Pimentel on 12/12/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "a1_App_Open.h"

@interface a1_App_Open ()

@end

@implementation a1_App_Open


#pragma mark - didLoad
- (void)viewWillAppear:(BOOL)animated
{
    btnTypeSeller.titleLabel.numberOfLines = 2;
    btnTypeSeller.titleLabel.numberOfLines = 2;
    
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}


#pragma mark - didLoad
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}
@end
