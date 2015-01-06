//
//  voucherPotaSellerData.h
//  myPota
//
//  Created by Rodrigo Pimentel on 18/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface voucherPotaSellerData : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgAgency;
@property (strong, nonatomic) IBOutlet UIImageView *imgSecure;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblStreet;
@property (strong, nonatomic) IBOutlet UILabel *lblAdress;
@property (strong, nonatomic) IBOutlet UILabel *lblMail;
@property (strong, nonatomic) IBOutlet UILabel *lblSeller;
@property (strong, nonatomic) IBOutlet UILabel *lblNumberReserva;
@property (strong, nonatomic) IBOutlet UILabel *lblBught;

- (void)startCell:(NSString *)_imageAgency imgSecure:(NSString *)_imageSecure name:(NSString *)_name street:(NSString *)_street adress:(NSString *)_adress mail:(NSString *)_mail seller:(NSString *)_seller reserveCode:(NSString *)_reserveCode dataPurchase:(NSString *)_data;

@end
