//
//  hotelPotaCellRoom.h
//  myPota
//
//  Created by Rodrigo Pimentel on 18/11/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hotelPotaCellRoom : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *lineBar;

@property (strong, nonatomic) IBOutlet UILabel *lblNumber;
@property (strong, nonatomic) IBOutlet UIButton *btnMinus;
@property (strong, nonatomic) IBOutlet UIButton *btnPlus;

@end
