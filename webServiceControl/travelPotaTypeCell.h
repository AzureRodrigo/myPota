//
//  travelPotaTypeCell.h
//  myPota
//
//  Created by Rodrigo Pimentel on 07/07/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface travelPotaTypeCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblType;

- (IBAction)btnGetInfo:(id)sender;

@end
