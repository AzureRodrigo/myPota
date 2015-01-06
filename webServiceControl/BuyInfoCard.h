//
//  BuyInfoCard.h
//  myPota
//
//  Created by Rodrigo Pimentel on 11/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyInfoCard : UITableViewCell

//data Parcelas
@property (strong, nonatomic) IBOutlet UILabel      *lblNumberParcelas;
@property (strong, nonatomic) IBOutlet UILabel      *lblTxtParcelas;
@property (strong, nonatomic) IBOutlet UIStepper    *stepperParcelas;

//data bandeira Card's
@property (strong, nonatomic) IBOutlet UISwitch     * switchMaster;
@property (strong, nonatomic) IBOutlet UISwitch     * swicthVisa;
@property (strong, nonatomic) IBOutlet UISwitch     * swicthAmerican;
@property (strong, nonatomic) IBOutlet UISwitch     * swicthDiner;

//data info card
@property (strong, nonatomic) IBOutlet UITextField  *txtCardNumber;
@property (strong, nonatomic) IBOutlet UITextField  *txtCardCod;
@property (strong, nonatomic) IBOutlet UITextField  *txtCardName;
@property (strong, nonatomic) IBOutlet UIButton     *btnCardMonth;
@property (strong, nonatomic) IBOutlet UIButton     *btnCardYear;

//data Contact;
//@property (strong, nonatomic) IBOutlet UITextField  *txtPurchaserAdress;
//@property (strong, nonatomic) IBOutlet UITextField  *txtPurchaserCity;
//@property (strong, nonatomic) IBOutlet UITextField  *txtPurchaserState;
//@property (strong, nonatomic) IBOutlet UITextField  *txtPurchaserCEP;
//@property (strong, nonatomic) IBOutlet UITextField  *txtPurchaserFONE;

#pragma mark - NavBarButton
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnCancel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnConfirm;

- (void)startCell:(id)_delegate txtDone:(SEL)_done txtCancel:(SEL)_cancel id:(int)_id cardInfo:(NSDictionary *)_cardInfo btnMonth:(SEL)_month btnAge:(SEL)_age btnCard:(SEL)_card btnParcel:(SEL)_parcel;

+ (BOOL)validate:(NSMutableDictionary *)infos;
@end
