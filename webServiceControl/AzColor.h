//
//  AzColor.h
//  webServiceControl
//
//  Created by Rodrigo Pimentel on 13/03/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AzColor : UIImage

- (UIImage *)imageWithTint:(UIColor *)tintColor;
- (UIImage*)scaleToSize:(CGSize)size;

@end
