//
//  BuyInfoCard.m
//  myPota
//
//  Created by Rodrigo Pimentel on 11/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "BuyInfoCard.h"

@implementation BuyInfoCard

- (void)startCell:(id)_delegate txtDone:(SEL)_done txtCancel:(SEL)_cancel id:(int)_id cardInfo:(NSDictionary *)_cardInfo btnMonth:(SEL)_month btnAge:(SEL)_age btnCard:(SEL)_card btnParcel:(SEL)_parcel
{
    [self configVisual];
    [self setDelegates:_delegate
               txtDone:_done
             txtCancel:_card
              btnMonth:_month
                btnAge:_age
               btnCard:_card
             btnParcel:_parcel];
    
    [self setAccessibility];
    
    [self setParcels:[_cardInfo objectForKey:PURCHASE_CARD_INFO_PACERLS]];
    [self setFlag:[_cardInfo objectForKey:PURCHASE_CARD_INFO_FLAG]];
    
    [self setTexts:_cardInfo];
}

- (void)configVisual
{
    float scale = .8f;
    _switchMaster.transform     = CGAffineTransformMakeScale(scale, scale);
    _swicthVisa.transform       = CGAffineTransformMakeScale(scale, scale);
    _swicthAmerican.transform   = CGAffineTransformMakeScale(scale, scale);
    _swicthDiner.transform      = CGAffineTransformMakeScale(scale, scale);
}

- (void)setDelegates:(id)_delegates txtDone:(SEL)_done txtCancel:(SEL)_cancel btnMonth:(SEL)_month btnAge:(SEL)_age btnCard:(SEL)_card btnParcel:(SEL)_parcel
{
    [_switchMaster addTarget:_delegates
                      action:_card
            forControlEvents:UIControlEventTouchUpInside];
    [_swicthVisa addTarget:_delegates
                    action:_card
          forControlEvents:UIControlEventTouchUpInside];
    [_swicthAmerican addTarget:_delegates
                        action:_card
              forControlEvents:UIControlEventTouchUpInside];
    [_swicthDiner addTarget:_delegates
                     action:_card
           forControlEvents:UIControlEventTouchUpInside];
    [_stepperParcelas addTarget:_delegates
                         action:_parcel
               forControlEvents:UIControlEventTouchUpInside];
    
    [_btnCardMonth addTarget:_delegates
                      action:_month
            forControlEvents:UIControlEventTouchUpInside];
    
    [_btnCardYear addTarget:_delegates
                     action:_age
           forControlEvents:UIControlEventTouchUpInside];
    
    [_txtCardNumber      setDelegate:_delegates];
    [_txtCardCod         setDelegate:_delegates];
    [_txtCardName        setDelegate:_delegates];
   
//    [_txtPurchaserAdress setDelegate:_delegates];
//    [_txtPurchaserCity   setDelegate:_delegates];
//    [_txtPurchaserState  setDelegate:_delegates];
//    [_txtPurchaserCEP    setDelegate:_delegates];
//    [_txtPurchaserFONE   setDelegate:_delegates];
    
    [self addNavBar:_delegates done:_done cancel:_cancel];
    
}

- (void)setAccessibility
{
    [_switchMaster      setAccessibilityValue:KEY_CARD_MASTER];
    [_swicthVisa        setAccessibilityValue:KEY_CARD_VISA];
    [_swicthAmerican    setAccessibilityValue:KEY_CARD_AMEX];
    [_swicthDiner       setAccessibilityValue:KEY_CARD_DINER];
    
    [_txtCardNumber      setAccessibilityValue:PURCHASE_CARD_INFO_NUMBER];
    [_txtCardCod         setAccessibilityValue:PURCHASE_CARD_INFO_COD];
    [_txtCardName        setAccessibilityValue:PURCHASE_CARD_INFO_NAME];
//    [_txtPurchaserAdress setAccessibilityValue:PURCHASE_PERSON_INFO_ADRESS];
//    [_txtPurchaserCity   setAccessibilityValue:PURCHASE_PERSON_INFO_CITY];
//    [_txtPurchaserState  setAccessibilityValue:PURCHASE_PERSON_INFO_UF];
//    [_txtPurchaserCEP    setAccessibilityValue:PURCHASE_PERSON_INFO_CEP];
//    [_txtPurchaserFONE   setAccessibilityValue:PURCHASE_PERSON_INFO_FONE];
}

- (void)setParcels:(NSString *)_value
{
    [_lblNumberParcelas setText:_value];
    NSString *number = @"parcela";
    if ([_value intValue] > 1)
        number = @"parcelas";
    [_lblTxtParcelas    setText:number];
}

- (void)setFlag:(NSString *)_flag
{
    if ([_flag isEqualToString:KEY_CARD_MASTER]) {
        [_switchMaster      setOn:YES animated:YES];
        [_swicthVisa        setOn:NO  animated:YES];
        [_swicthAmerican    setOn:NO  animated:YES];
        [_swicthDiner       setOn:NO  animated:YES];
    } else if ([_flag isEqualToString:KEY_CARD_VISA]) {
        [_switchMaster      setOn:NO  animated:YES];
        [_swicthVisa        setOn:YES animated:YES];
        [_swicthAmerican    setOn:NO  animated:YES];
        [_swicthDiner       setOn:NO  animated:YES];
    } else if ([_flag isEqualToString:KEY_CARD_AMEX]) {
        [_switchMaster      setOn:NO  animated:YES];
        [_swicthVisa        setOn:NO  animated:YES];
        [_swicthAmerican    setOn:YES animated:YES];
        [_swicthDiner       setOn:NO  animated:YES];
    } else {
        [_switchMaster      setOn:NO  animated:YES];
        [_swicthVisa        setOn:NO  animated:YES];
        [_swicthAmerican    setOn:NO  animated:YES];
        [_swicthDiner       setOn:YES animated:YES];
    }
}

- (void)setTexts:(NSDictionary *)_text
{
    [_txtCardNumber      setText:[_text objectForKey:PURCHASE_CARD_INFO_NUMBER]];
    [_txtCardCod         setText:[_text objectForKey:PURCHASE_CARD_INFO_COD]];
    [_txtCardName        setText:[_text objectForKey:PURCHASE_CARD_INFO_NAME]];
//    [_txtPurchaserAdress setText:[_text objectForKey:PURCHASE_PERSON_INFO_ADRESS]];
//    [_txtPurchaserCity   setText:[_text objectForKey:PURCHASE_PERSON_INFO_CITY]];
//    [_txtPurchaserState  setText:[_text objectForKey:PURCHASE_PERSON_INFO_UF]];
//    [_txtPurchaserCEP    setText:[_text objectForKey:PURCHASE_PERSON_INFO_CEP]];
//    [_txtPurchaserFONE   setText:[_text objectForKey:PURCHASE_PERSON_INFO_FONE]];
    [_btnCardMonth       setTitle:[_text objectForKey:PURCHASE_CARD_INFO_MONTH] forState:UIControlStateNormal];
    [_btnCardYear        setTitle:[_text objectForKey:PURCHASE_CARD_INFO_YEAR]  forState:UIControlStateNormal];
}

- (void)addNavBar:(id)_delegate done:(SEL)_done cancel:(SEL)_cancel
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    
    _btnCancel = [[UIBarButtonItem alloc]initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:_delegate action:_cancel];
    
    _btnConfirm = [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:_delegate action:_done];
    numberToolbar.items = [NSArray arrayWithObjects:
                           _btnCancel,
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           _btnConfirm,
                           nil];
    [numberToolbar sizeToFit];
    
    _txtCardNumber.inputAccessoryView    = numberToolbar;
    _txtCardCod.inputAccessoryView       = numberToolbar;
//    _txtPurchaserCEP.inputAccessoryView  = numberToolbar;
//    _txtPurchaserFONE.inputAccessoryView = numberToolbar;
}

+ (BOOL)validate:(NSMutableDictionary *)infos
{
    if ([[infos objectForKey:PURCHASE_CARD_INFO_NUMBER] length] != 16){
        [AppFunctions LOG_MESSAGE:ERROR_1030_TITLE
                          message:ERROR_1030_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    if ([[infos objectForKey:PURCHASE_CARD_INFO_COD] length] != 3){
        [AppFunctions LOG_MESSAGE:ERROR_1031_TITLE
                          message:ERROR_1031_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    if ([[infos objectForKey:PURCHASE_CARD_INFO_NAME] length] == 0){
        [AppFunctions LOG_MESSAGE:ERROR_1032_TITLE
                          message:ERROR_1032_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    
    if ([[infos objectForKey:PURCHASE_CARD_INFO_MONTH] isEqualToString:@"Mês"]){
        [AppFunctions LOG_MESSAGE:ERROR_1033_TITLE
                          message:ERROR_1033_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    } else {
        NSDate *today           = [NSDate date];
        NSDateFormatter *df     = [[NSDateFormatter alloc] init];
        NSLocale *localeTMP     = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_Br"];
        [df setLocale:localeTMP];
        [df setDateFormat:@"MMMM/yyyy"];
        NSString *todayYear = [df stringFromDate:today];
        NSDate *thisdate    = [df dateFromString:todayYear];
        NSDate *loaddate    = [df dateFromString:[NSString stringWithFormat:@"%@/%@",[infos objectForKey:PURCHASE_CARD_INFO_MONTH],[infos objectForKey:PURCHASE_CARD_INFO_YEAR]]];
        NSTimeInterval timeDifference = [loaddate timeIntervalSinceDate:thisdate];
        if (timeDifference < 0) {
            [AppFunctions LOG_MESSAGE:ERROR_1033_TITLE
                              message:ERROR_1033_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
            [infos setValue:@"Mês" forKeyPath:PURCHASE_CARD_INFO_MONTH];
            return NO;
        }
    }
    if ([[infos objectForKey:PURCHASE_CARD_INFO_YEAR] isEqualToString:@"Ano"]){
        [AppFunctions LOG_MESSAGE:ERROR_1034_TITLE
                          message:ERROR_1034_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    } else {
        NSInteger cardYear  = [[infos objectForKey:PURCHASE_CARD_INFO_YEAR]intValue];
        NSDate *today       = [NSDate date];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy"];
        NSString *todayYear = [df stringFromDate:today];
        NSInteger thisYear  = [todayYear intValue];
        if (cardYear < thisYear) {
            [AppFunctions LOG_MESSAGE:ERROR_1034_TITLE
                              message:ERROR_1034_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
            [infos setValue:@"Ano" forKeyPath:PURCHASE_CARD_INFO_YEAR];
            return NO;
        }
    }
/*   
    if([[infos objectForKey:PURCHASE_PERSON_INFO_ADRESS] length] < 3) {
        [AppFunctions LOG_MESSAGE:ERROR_1039_TITLE
                          message:ERROR_1039_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    if([[infos objectForKey:PURCHASE_PERSON_INFO_CITY] length] < 3) {
        [AppFunctions LOG_MESSAGE:ERROR_1040_TITLE
                          message:ERROR_1040_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    if([[infos objectForKey:PURCHASE_PERSON_INFO_UF] length] < 2) {
        [AppFunctions LOG_MESSAGE:ERROR_1041_TITLE
                          message:ERROR_1041_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    if ([[infos objectForKey:PURCHASE_PERSON_INFO_CEP] isEqualToString:@""] || [[infos objectForKey:PURCHASE_PERSON_INFO_CEP] length] < 8) {
        [AppFunctions LOG_MESSAGE:ERROR_1038_TITLE
                          message:ERROR_1038_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    NSString *cep = [infos objectForKey:PURCHASE_PERSON_INFO_CEP];
    NSMutableString *strResult = [NSMutableString string];
    
    for (NSUInteger i = 0; i < [cep length]; i++) {
        if (i == 5)
            [strResult appendFormat:@"-"];
        char ch = [cep characterAtIndex:i];
        [strResult appendFormat:@"%c", ch];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:LINK_CEP_VALIDATION, strResult]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSDictionary *allData = (NSDictionary *)[[AzParser alloc] xmlDictionary:data tagNode:@"cep"];
    for (NSDictionary *tmp in [allData objectForKey:@"cep"]) {
        if (![[tmp objectForKey:@"status"] isEqualToString:@"1"])
            [AppFunctions LOG_MESSAGE:ERROR_1038_TITLE
                              message:ERROR_1038_MESSAGE
                               cancel:ERROR_BUTTON_CANCEL];
        request = nil;
        url = nil;
        return NO;
    }
    
    if([[infos objectForKey:PURCHASE_PERSON_INFO_FONE] length] < 8){
        [AppFunctions LOG_MESSAGE:ERROR_1029_TITLE
                          message:[NSString stringWithFormat:ERROR_1029_MESSAGE,1]
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
 */
    return YES;
}

@end
