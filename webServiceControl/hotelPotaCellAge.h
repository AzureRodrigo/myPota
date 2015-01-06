//
//  hotelPotaCellAge.h
//  myPota
//
//  Created by Rodrigo Pimentel on 18/11/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hotelPotaCellAge : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblAge;
@property (strong, nonatomic) NSArray          *ageList;
@property (strong, nonatomic) UIPickerView     *agePicker;

@end
