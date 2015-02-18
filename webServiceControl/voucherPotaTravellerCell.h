//
//  voucherPotaTravellerCell.h
//  myPota
//
//  Created by Rodrigo Pimentel on 18/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface voucherPotaTravellerCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblID;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblAge;
@property (strong, nonatomic) IBOutlet UILabel *lblMail;
@property (strong, nonatomic) IBOutlet UILabel *lblFone;
@property (strong, nonatomic) IBOutlet UILabel *lblCPF;

- (void)startInfo:(NSString *)_ID name:(NSString *)_name age:(NSString *)_age mail:(NSString *)_mail fone:(NSString *)_fone cpf:(NSString *)_cpf;
@property (weak, nonatomic) IBOutlet UIImageView *imgBottomBar;

@end
