//
//  splitViewCell.m
//  myPota
//
//  Created by Rodrigo Pimentel on 19/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "s0_Split_Menu_Cell.h"

@implementation s0_Split_Menu_Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        float scale = .6f;
        _imgBg = [[UIImageView alloc] initWithFrame:CGRectMake( 0, CELL_SIZE * .2f,
                                                               424 * scale, 56 * scale)];
        [self addSubview:_imgBg];
        
        imgBar = [[UIImageView alloc] initWithFrame:CGRectMake( 0, CELL_SIZE - 1,
                                                               self.frame.size.width, 1)];
        [imgBar setImage:[UIImage imageNamed:@"splitItemBar"]];
        [self addSubview:imgBar];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

@end
