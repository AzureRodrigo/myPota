//
//  BuyInfoTravellers.h
//  myPota
//
//  Created by Rodrigo Pimentel on 11/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyInfoTravellers : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgLine;
@property (strong, nonatomic) IBOutlet UILabel *lblTravellerNumber;
@property (strong, nonatomic) IBOutlet UILabel *lblTravellerName;
@property (strong, nonatomic) IBOutlet UILabel *lblTravellerFone;
@property (strong, nonatomic) IBOutlet UILabel *lblTravellerMail;

- (void)startCell:(NSDictionary *)infos ID:(int)_id;

@end
