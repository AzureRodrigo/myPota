//
//  v0_Voucher_Info_Package_Cell.h
//  mypota
//
//  Created by Rodrigo Pimentel on 18/02/15.
//  Copyright (c) 2015 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface v0_Voucher_Info_Package_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblType;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblSeguradora;
@property (weak, nonatomic) IBOutlet UILabel *lblDataStart;
@property (weak, nonatomic) IBOutlet UILabel *lblDataEnd;
@property (weak, nonatomic) IBOutlet UILabel *lblNumberTraveller;
@property (weak, nonatomic) IBOutlet UILabel *lblNumberDays;

@end
