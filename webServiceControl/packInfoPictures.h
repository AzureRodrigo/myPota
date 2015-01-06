//
//  packInfoPictures.h
//  myPota
//
//  Created by Rodrigo Pimentel on 03/11/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
#import "packInfo.h"

@interface packInfoPictures : UIViewController  <UIPageViewControllerDataSource>
{
    packInfo *backScreen;
    NSMutableArray *listImage;
    NSMutableArray *listAllImage;
}

- (IBAction)startWalkthrough:(id)sender;

@property (strong, nonatomic) UIPageViewController *pageViewController;


@end
