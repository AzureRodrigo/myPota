//
//  cadastreCell_TravelPeople.h
//  myPota
//
//  Created by Rodrigo Pimentel on 06/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cadastreCell_TravelPeople : UITableViewCell

#pragma mark - Header
@property (strong, nonatomic) IBOutlet UILabel  *lblTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnHideShow;
@property bool hide;
@property (strong, nonatomic) IBOutlet UIImageView *imgLineHide;
@property (weak, nonatomic) IBOutlet UIImageView *imgBottonHide;

- (void)startCell:(id)_delegate done:(SEL)_done cancel:(SEL)_cancel id:(int)_id traveller:(NSDictionary *)_traveller;

#pragma mark - TextBox
@property (strong, nonatomic) IBOutlet UITextField *txtBoxFirstName;
@property (strong, nonatomic) IBOutlet UITextField *txtBoxSecondName;
@property (strong, nonatomic) IBOutlet UITextField *txtBoxCPF;
@property (strong, nonatomic) IBOutlet UITextField *txtBoxAge;
@property (strong, nonatomic) IBOutlet UITextField *txtBoxMail;
@property (strong, nonatomic) IBOutlet UITextField *txtBoxFone;

#pragma mark - NavBarButton
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnCancel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnConfirm;

#pragma mark - TextField
@property (strong, nonatomic) IBOutlet UITextView *txtFieldObserver;

#pragma mark - Segmented
@property (strong, nonatomic) IBOutlet UISegmentedControl *btnGender;

#pragma mark - Switch
@property (strong, nonatomic) IBOutlet UISwitch *btnSwitchMail;


+ (BOOL)validate:(NSMutableDictionary *)textField ID:(int)ID;

@end
