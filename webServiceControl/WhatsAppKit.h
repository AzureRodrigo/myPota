//
//  WhatsAppKit.h
//  myPota
//
//  Created by Rodrigo Pimentel on 21/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

#define WHATSAPP_CONTACT_NAME  @"name"
#define WHATSAPP_CONTACT_FONE  @"fone"
#define WHATSAPP_CONTACT_IMAGE @"image"
#define WHATSAPP_LINK_START    @"whatsapp://"
#define WHATSAPP_LINK_ITUNES   @"https://itunes.apple.com/app/whatsapp-messenger/id310633997?mt=8"

@interface WhatsAppKit : NSObject

+ (void)CALL_WHATSAPP:(NSDictionary *)contact message:(NSString *)message;

@end
