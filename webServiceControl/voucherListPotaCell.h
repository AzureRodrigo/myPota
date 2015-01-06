//
//  voucherListPotaCell.h
//  myPota
//
//  Created by Rodrigo Pimentel on 25/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface voucherListPotaCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblType;
@property (strong, nonatomic) IBOutlet UILabel *lblVoucher;
@property (strong, nonatomic) IBOutlet UILabel *lblData;
@property (strong, nonatomic) IBOutlet UILabel *lblCod;
@property (strong, nonatomic) IBOutlet UILabel *lblValue;

- (void)startCell:(NSDictionary *)info;

@end
