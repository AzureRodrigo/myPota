//
//  voucherPotaVoucherCell.h
//  myPota
//
//  Created by Rodrigo Pimentel on 18/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface voucherPotaVoucherCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblPassword;
@property (strong, nonatomic) IBOutlet UILabel *lblCode;

- (void)startInfo:(NSString *)voucher code:(NSString *)code;

@end
