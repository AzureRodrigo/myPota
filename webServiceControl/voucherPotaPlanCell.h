//
//  voucherPotaPlanCell.h
//  myPota
//
//  Created by Rodrigo Pimentel on 18/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface voucherPotaPlanCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblAgeLimit;
@property (strong, nonatomic) IBOutlet UILabel *lblDestiny;
@property (strong, nonatomic) IBOutlet UILabel *lblDataStart;
@property (strong, nonatomic) IBOutlet UILabel *lblDataEnd;
@property (strong, nonatomic) IBOutlet UILabel *lblNumberDays;
@property (strong, nonatomic) IBOutlet UILabel *lblNumberTravellers;

- (void)startInfo:(NSString *)_name ageLimit:(NSString *)_ageLimit destiny:(NSString *)_destiny dataStart:(NSString *)_datastart dataEnd:(NSString *)_dataEnd numberDays:(NSString *)_numberDays numberTravellers:(NSString *)_numbertravellers;

@end
