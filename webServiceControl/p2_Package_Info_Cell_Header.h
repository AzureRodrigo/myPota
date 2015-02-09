//
//  packInfoHeaderCell.h
//  myPota
//
//  Created by Rodrigo Pimentel on 08/12/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface p2_Package_Info_Cell_Header : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *btnImage;

@property (strong, nonatomic) IBOutlet UIButton *btnCircuits;

@property (strong, nonatomic) IBOutlet UILabel *lblCircuitType;
@property (strong, nonatomic) IBOutlet UILabel *lblCircuitDays;
@property (strong, nonatomic) IBOutlet UILabel *lblCircuitName;
@property (strong, nonatomic) IBOutlet UILabel *lblCircuitInfo;

@end
