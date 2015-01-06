//
//  PageContentViewController.m
//  myPota
//
//  Created by Rodrigo Pimentel on 03/11/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSURL *url = [NSURL URLWithString:[self.imageFile stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSData *imageData=[NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:nil];
        UIImage *img = [UIImage imageWithData:imageData];

        self.backgroundImageView.image = img;
        self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundImageView.backgroundColor = [UIColor clearColor];
        [self.backgroundImageView setCenter:CGPointMake(self.backgroundImageView.frame.size.width/2, self.backgroundImageView.frame.size.height *.3)];
    });
    
}

@end
