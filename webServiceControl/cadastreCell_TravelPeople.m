//
//  cadastreCell_TravelPeople.m
//  myPota
//
//  Created by Rodrigo Pimentel on 06/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "cadastreCell_TravelPeople.h"

@implementation cadastreCell_TravelPeople

- (void)startCell:(id)_delegate done:(SEL)_done cancel:(SEL)_cancel id:(int)_id traveller:(NSDictionary *)_traveller
{
    //delegates
    [_txtBoxFirstName  setDelegate:_delegate];
    [_txtBoxSecondName setDelegate:_delegate];
    [_txtBoxCPF        setDelegate:_delegate];
    [_txtBoxAge        setDelegate:_delegate];
    [_txtBoxMail       setDelegate:_delegate];
    [_txtBoxFone       setDelegate:_delegate];
//    [_txtFieldObserver setDelegate:_delegate];
    
    //id's
    [_txtBoxFirstName  setTag:_id];
    [_txtBoxSecondName setTag:_id];
    [_txtBoxCPF        setTag:_id];
    [_txtBoxAge        setTag:_id];
    [_txtBoxMail       setTag:_id];
    [_txtBoxFone       setTag:_id];
//    [_txtFieldObserver setTag:_id];
    
    //Accessibility
    [_txtBoxFirstName  setAccessibilityValue:CADASTRO_PERSON_FIRST_NAME];
    [_txtBoxSecondName setAccessibilityValue:CADASTRO_PERSON_SECOND_NAME];
    [_txtBoxCPF        setAccessibilityValue:CADASTRO_PERSON_CPF];
    [_txtBoxAge        setAccessibilityValue:CADASTRO_PERSON_AGE];
    [_txtBoxMail       setAccessibilityValue:CADASTRO_PERSON_MAIL];
    [_txtBoxFone       setAccessibilityValue:CADASTRO_PERSON_FONE];
//    [_txtFieldObserver setAccessibilityValue:CADASTRO_PERSON_OBSERVER];
    
    [self addNavBar:_delegate done:_done cancel:_cancel];
    
    //hide
    if (_hide)
        [_btnHideShow setTitle:@"+" forState:UIControlStateNormal];
    else
        [_btnHideShow setTitle:@"-" forState:UIControlStateNormal];
    [_imgLineHide setHidden:!_hide];
    
//    //text field
//    _txtFieldObserver.layer.borderWidth = 1.0f;
//    _txtFieldObserver.layer.borderColor = [[UIColor grayColor] CGColor];
//    _txtFieldObserver.layer.cornerRadius = 5;
//    _txtFieldObserver.clipsToBounds = YES;
    
    //switch
    float scale = .8f;
    _btnSwitchMail.transform = CGAffineTransformMakeScale(scale, scale);
    
    //content
    [_txtBoxFirstName  setText:[_traveller objectForKey:CADASTRO_PERSON_FIRST_NAME]];
    [_txtBoxSecondName setText:[_traveller objectForKey:CADASTRO_PERSON_SECOND_NAME]];
    [_txtBoxCPF        setText:[_traveller objectForKey:CADASTRO_PERSON_CPF]];
    [_txtBoxAge        setText:[_traveller objectForKey:CADASTRO_PERSON_AGE]];
    [_txtBoxMail       setText:[_traveller objectForKey:CADASTRO_PERSON_MAIL]];
    [_txtBoxFone       setText:[_traveller objectForKey:CADASTRO_PERSON_FONE]];
//    [_txtFieldObserver setText:[_traveller objectForKey:CADASTRO_PERSON_OBSERVER]];
    
    if ([[_traveller objectForKey:CADASTRO_PERSON_GENDER] isEqualToString:@"F"])
        [_btnGender setSelectedSegmentIndex:1];
    else
        [_btnGender setSelectedSegmentIndex:0];
    
    [_btnSwitchMail setOn:[[_traveller objectForKey:CADASTRO_PERSON_RECIVE_MAIL]boolValue]];
    
}

+ (BOOL)validate:(NSMutableDictionary *)textFD ID:(int)ID
{
    if([[textFD objectForKey:CADASTRO_PERSON_FIRST_NAME] length] < 3) {
        [AppFunctions LOG_MESSAGE:ERROR_1022_TITLE
                          message:[NSString stringWithFormat:ERROR_1022_MESSAGE,ID+1]
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    if([[textFD objectForKey:CADASTRO_PERSON_SECOND_NAME] length] < 3) {
        [AppFunctions LOG_MESSAGE:ERROR_1023_TITLE
                          message:[NSString stringWithFormat:ERROR_1023_MESSAGE,ID+1]
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    if ([[textFD objectForKey:CADASTRO_PERSON_AGE] isEqualToString:@""] ||
        [[textFD objectForKey:CADASTRO_PERSON_AGE]intValue] > 110) {
        [AppFunctions LOG_MESSAGE:ERROR_1024_TITLE
                          message:[NSString stringWithFormat:ERROR_1024_MESSAGE,ID+1]
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    if(![AppFunctions VALID_CPF:[textFD objectForKey:CADASTRO_PERSON_CPF]]){
        [AppFunctions LOG_MESSAGE:ERROR_1025_TITLE
                          message:[NSString stringWithFormat:ERROR_1025_MESSAGE,ID+1]
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    if ([[textFD objectForKey:CADASTRO_PERSON_MAIL] isEqualToString:@""] ||
        ![AppFunctions VALID_MAIL:[textFD objectForKey:CADASTRO_PERSON_MAIL]]) {
        [AppFunctions LOG_MESSAGE:ERROR_1028_TITLE
                          message:[NSString stringWithFormat:ERROR_1028_MESSAGE,ID+1]
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    if([[textFD objectForKey:CADASTRO_PERSON_FONE] length] < 8){
        [AppFunctions LOG_MESSAGE:ERROR_1029_TITLE
                          message:[NSString stringWithFormat:ERROR_1029_MESSAGE,ID+1]
                           cancel:ERROR_BUTTON_CANCEL];
        return NO;
    }
    
    return YES;
}

- (void)addNavBar:(id)_delegate done:(SEL)_done cancel:(SEL)_cancel
{
    [AppFunctions KEYBOARD_ADD_BAR:@[ _txtBoxCPF, _txtBoxFirstName, _txtBoxSecondName, _txtBoxAge, _txtBoxMail, _txtBoxFone]
                          delegate:_delegate
                            change:nil
                              done:_done
                            cancel:_cancel];
    
//    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
//    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
//    
//    _btnCancel = [[UIBarButtonItem alloc]initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:_delegate action:_cancel];
//    
//    _btnConfirm = [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:_delegate action:_done];
//    numberToolbar.items = [NSArray arrayWithObjects:
//                           _btnCancel,
//                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
//                           _btnConfirm,
//                           nil];
//    [numberToolbar sizeToFit];
//    
//    _txtBoxCPF.inputAccessoryView  = numberToolbar;
//    _txtBoxAge.inputAccessoryView  = numberToolbar;
//    _txtBoxFone.inputAccessoryView = numberToolbar;
}

@end
