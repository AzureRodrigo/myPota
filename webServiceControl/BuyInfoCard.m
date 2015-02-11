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
             txtCancel:_cancel
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
    
    [AppFunctions KEYBOARD_ADD_BAR:@[_txtCardNumber, _txtCardCod, _txtCardName]
                          delegate:_delegates
                            change:nil
                              done:_done
                            cancel:_cancel];
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
    [_btnCardMonth       setTitle:[_text objectForKey:PURCHASE_CARD_INFO_MONTH] forState:UIControlStateNormal];
    [_btnCardYear        setTitle:[_text objectForKey:PURCHASE_CARD_INFO_YEAR]  forState:UIControlStateNormal];
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
    return YES;
}

@end
