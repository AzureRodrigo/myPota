//
//  PackageButtons.m
//  webServiceControl
//
//  Created by Rodrigo Pimentel on 10/02/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "PackageButtons.h"

@implementation PackageButtons

@synthesize nameNib,cellIdentifier,rowID,classType;

- (id)initData:(NSString *)_nameNib :(NSString *)_cellIdentifier :(int)_rowID :(Class)_classType
{
    if ( self == [super init]){
        nameNib        = _nameNib;
        cellIdentifier = _cellIdentifier;
        rowID          = _rowID;
        classType      = _classType;
    }
    return self;
}
@end
