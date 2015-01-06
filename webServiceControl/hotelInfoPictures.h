//
//  hotelInfoPictures.h
//  myPota
//
//  Created by Rodrigo Pimentel on 24/11/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hotelPotaInfo.h"
#import "PageContentViewController.h"

@interface hotelInfoPictures : UIViewController <UIPageViewControllerDataSource>
{
    hotelPotaInfo *backScreen;
    NSMutableArray *listImage;
    NSMutableArray *listAllImage;
}

- (IBAction)startWalkthrough:(id)sender;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
