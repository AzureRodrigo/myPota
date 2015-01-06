//
//  hotelPotaListResultCell.h
//  myPota
//
//  Created by Rodrigo Pimentel on 17/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hotelPotaListResultCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageHotel;
@property (strong, nonatomic) IBOutlet UIImageView *imageStarLv;
@property (strong, nonatomic) IBOutlet UILabel *lblNameHotel;
@property (strong, nonatomic) IBOutlet UILabel *lblNameCity;
@property (strong, nonatomic) IBOutlet UILabel *lblMoney;

@end
