//
//  travelPotaTypeCell.m
//  myPota
//
//  Created by Rodrigo Pimentel on 07/07/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "travelPotaTypeCell.h"

@implementation travelPotaTypeCell

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (IBAction)btnGetInfo:(id)sender
{
    [AppFunctions LOG_MESSAGE:_lblType.text
                      message:@"ainda não pesquisa ..."
                       cancel:ERROR_BUTTON_CANCEL];
}


@end
