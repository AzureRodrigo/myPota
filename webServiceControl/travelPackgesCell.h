//
//  travelPackgesCell.h
//  myPota
//
//  Created by Rodrigo Pimentel on 12/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface travelPackgesCell : UITableViewCell

#pragma mark - Label's
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblMaxAge;
@property (strong, nonatomic) IBOutlet UILabel *lblPricePlano;
@property (strong, nonatomic) IBOutlet UILabel *lblParcel;
@property (strong, nonatomic) IBOutlet UILabel *lblPriceCobertura;
#pragma mark - Button's
@property (strong, nonatomic) IBOutlet UIButton *btnInfo;
@property (strong, nonatomic) IBOutlet UIButton *btnBuy;

@end
