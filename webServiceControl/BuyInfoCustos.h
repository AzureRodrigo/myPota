//
//  BuyInfoCustos.h
//  myPota
//
//  Created by Rodrigo Pimentel on 11/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyInfoCustos : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblPlanDay;
@property (strong, nonatomic) IBOutlet UILabel *lblTravellerAge;
@property (strong, nonatomic) IBOutlet UILabel *lblValueTravel;
@property (strong, nonatomic) IBOutlet UILabel *lblValueTotal;

- (void)startCell:(NSDictionary *)_data title:(NSString *)_title;

@end