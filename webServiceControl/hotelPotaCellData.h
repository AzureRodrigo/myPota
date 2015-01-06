//
//  hotelPotaCellData.h
//  myPota
//
//  Created by Rodrigo Pimentel on 18/11/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hotelPotaCellData : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *btnData;
@property (strong, nonatomic) IBOutlet UILabel  *lblGoDay;
@property (strong, nonatomic) IBOutlet UILabel  *lblGoAlpha;
@property (strong, nonatomic) IBOutlet UILabel  *lblEndDay;
@property (strong, nonatomic) IBOutlet UILabel  *lblEndAlpha;

@end
