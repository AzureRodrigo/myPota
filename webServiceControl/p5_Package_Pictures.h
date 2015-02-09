//
//  packInfoPictures.h
//  myPota
//
//  Created by Rodrigo Pimentel on 03/11/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
#import "p2_Package_Info.h"

@interface p5_Package_Pictures : UIViewController  <UIPageViewControllerDataSource>
{
    p2_Package_Info *backScreen;
    NSMutableArray *listImage;
    NSMutableArray *listAllImage;
}

- (IBAction)startWalkthrough:(id)sender;

@property (strong, nonatomic) UIPageViewController *pageViewController;


@end
