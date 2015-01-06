//
//  AzParser.h
//  CadastrodeVendedor
//
//  Created by Rodrigo Pimentel on 21/02/14.
//  Copyright (c) 2014 esfera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AzParser : NSObject <NSXMLParserDelegate>
{
    BOOL findFirstTag;
    
    NSString *tagNode;
    NSString * element;
    
    NSMutableDictionary * finalDict;
    NSMutableDictionary * infoDict;
    
    NSMutableString *textInProgress;

    NSDictionary *root;
}

-(id) xmlDictionary:(NSData *)data tagNode:(NSString *)_tagNode;
+(NSDictionary *) xmlDictionary:(NSData *)data tagNode:(NSString *)_tagNode;
@end
