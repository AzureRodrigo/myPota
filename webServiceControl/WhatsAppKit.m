//
//  WhatsAppKit.m
//  myPota
//
//  Created by Rodrigo Pimentel on 21/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "WhatsAppKit.h"
#import "NSString+WhatsAppKit.h"

@implementation WhatsAppKit

+ (BOOL)isWhatsAppInstalled
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:WHATSAPP_LINK_START]];
}

+ (void)launchWhatsAppWithAddressBookId:(int)addressBookId andMessage:(NSString *)message {
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@send?", WHATSAPP_LINK_START];
    
    if (addressBookId > 0)
        [urlString appendFormat:@"abid=%d&", addressBookId];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

+ (int)getAbid:(ABAddressBookRef)adressBook contact:(ABRecordRef)contact
{
    NSArray *allContacts = (__bridge NSArray *)(ABAddressBookCopyArrayOfAllPeople(adressBook));
    for (id record in allContacts)
    {
        ABRecordRef thisContact = (__bridge ABRecordRef)record;
        if (CFStringCompare(ABRecordCopyCompositeName(thisContact),
                            ABRecordCopyCompositeName(contact), 0) == kCFCompareEqualTo)
            return (ABRecordID)ABRecordGetRecordID(thisContact);
    }
    return 0;
}

+ (ABRecordRef)newContact:(NSDictionary *)contact
{
    ABRecordRef seller = ABPersonCreate();
    ABRecordSetValue(seller, kABPersonFirstNameProperty, (__bridge CFStringRef)@"myPota", nil);
    ABRecordSetValue(seller, kABPersonLastNameProperty, (__bridge CFStringRef)[contact objectForKey:WHATSAPP_CONTACT_NAME], nil);
    ABMutableMultiValueRef phoneNumbers = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(phoneNumbers, (__bridge CFStringRef)[contact objectForKey:WHATSAPP_CONTACT_FONE], kABPersonPhoneMainLabel, NULL);
    ABRecordSetValue(seller, kABPersonPhoneProperty, phoneNumbers, nil);
    ABPersonSetImageData(seller, (__bridge CFDataRef)UIImageJPEGRepresentation([contact objectForKey:WHATSAPP_CONTACT_IMAGE],.7f), nil);
    return seller;
}

+ (void)openWhatsApp:(NSDictionary *)contact addressBook:(ABAddressBookRef)addressBookRef message:(NSString *)message add:(BOOL)_add
{
    if ([WhatsAppKit isWhatsAppInstalled]) {
        ABRecordRef seller = [WhatsAppKit newContact:contact];
        int QR_whatsappABID = [WhatsAppKit getAbid:addressBookRef contact:seller];
        if (_add)
            QR_whatsappABID = QR_whatsappABID - 1;
        [WhatsAppKit launchWhatsAppWithAddressBookId:QR_whatsappABID andMessage:message];
    }else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:WHATSAPP_LINK_ITUNES]];
}

+ (BOOL)verifyContactExist:(ABAddressBookRef)adressBook person:(ABRecordRef)person
{
    NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(adressBook);
    for (id record in allContacts)
    {
        ABRecordRef thisContact = (__bridge ABRecordRef)record;
        if (CFStringCompare(ABRecordCopyCompositeName(thisContact),
                            ABRecordCopyCompositeName(person), 0) == kCFCompareEqualTo)
            return YES;
    }
    return NO;
}

+ (void)verifyContact:(NSDictionary *)contact message:(NSString *)message
{
    CFErrorRef error;
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(nil, &error);
    ABRecordRef seller = [WhatsAppKit newContact:contact];
    ABAddressBookAddRecord(addressBookRef, seller, nil);
    
    
    if (![WhatsAppKit verifyContactExist:addressBookRef person:seller]){
        ABAddressBookSave(addressBookRef, nil);
        [WhatsAppKit openWhatsApp:contact addressBook:addressBookRef message:message add:YES];
    }else
        [WhatsAppKit openWhatsApp:contact addressBook:addressBookRef message:message add:NO];
    
}

+ (void)CALL_WHATSAPP:(NSDictionary *)contact message:(NSString *)message
{
    ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [WhatsAppKit verifyContact:contact message:message];
        });
    });
}

@end
