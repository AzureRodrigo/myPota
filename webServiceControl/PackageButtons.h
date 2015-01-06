//
//  PackageButtons.h
//  webServiceControl
//
//  Created by Rodrigo Pimentel on 10/02/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PackageButtons : NSObject

@property NSString *nameNib;
@property NSString *cellIdentifier;
@property int rowID;
@property Class classType;

- (id)initData:(NSString *)_nameNib :(NSString *)_cellIdentifier :(int)_rowID :(Class)_classType;

@end
