//
//  BuyInfoPurchase.h
//  myPota
//
//  Created by Rodrigo Pimentel on 11/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyInfoPurchase : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblValue;
@property (strong, nonatomic) IBOutlet UIButton *btnPurchaseConfirm;

- (void)startInfo:(float)_title parcel:(int)_x;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *otlActivity;
@end
