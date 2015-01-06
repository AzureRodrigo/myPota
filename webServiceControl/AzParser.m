//
//  AzParser.m
//  CadastrodeVendedor
//
//  Created by Rodrigo Pimentel on 21/02/14.
//  Copyright (c) 2014 esfera. All rights reserved.
//

#import "AzParser.h"

@interface AzParser (Internal)

- (NSDictionary *)objectWithData:(NSData *)data;

@end

@implementation AzParser

#pragma mark -xml data, tag open, list tags elements
+(NSDictionary *) xmlDictionary:(NSData *)data tagNode:(NSString *)_tagNode
{
    AzParser *parser = [AzParser new];
    NSDictionary *root = [parser objectWithData:data tagNode:_tagNode];
    return root;
}

-(id) xmlDictionary:(NSData *)data tagNode:(NSString *)_tagNode
{
    AzParser *parser = [AzParser new];
    root = [parser objectWithData:data tagNode:_tagNode];
    return root;
}

- (NSDictionary *)objectWithData:(NSData *)data tagNode:(NSString *)_tagNode
{
    tagNode = _tagNode;
    
    textInProgress  = [[NSMutableString alloc] init];
    finalDict = [NSMutableDictionary new];
    element = @"";
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    BOOL success = [parser parse];
    if (success)
    {
        return finalDict;
    }
    return nil;
}

#pragma mark -xml read tag
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:tagNode]){
        if (!findFirstTag) {
            findFirstTag = YES;
            infoDict = [NSMutableDictionary new];
        }
    }
    if (findFirstTag){
        if (![element isEqualToString:elementName]) {
            element = elementName;
            textInProgress = [NSMutableString new];
        }
    }
}

#pragma mark xml end tag
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (findFirstTag) {
        if ([element isEqualToString:elementName]){
            [infoDict setObject:textInProgress forKey:elementName];
        }
        
        if ([elementName isEqualToString:tagNode]){
            if ([finalDict objectForKey:tagNode] == NULL ) {
                NSMutableArray *tmpInfo = [NSMutableArray new];
                [tmpInfo addObject:infoDict];
                [finalDict setObject:tmpInfo forKey:tagNode];
            }else{
                NSMutableArray *tmpInfo = [finalDict objectForKey:tagNode];
                [tmpInfo addObject:infoDict];
                [finalDict setObject:tmpInfo forKey:tagNode];
            }
            findFirstTag = NO;
        }
    }
}

#pragma mark xml element enconter
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (findFirstTag) {
        [textInProgress appendString:(NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
}

#pragma mark xml error
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    [AppFunctions LOG_MESSAGE:@"erro de parser"
                      message:[NSString stringWithFormat:@"%@", parseError]
                       cancel:@"Okye"];
}

#pragma mark xml finish
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
}

@end