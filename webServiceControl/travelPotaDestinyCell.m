//
//  travelPotaDestinyCell.m
//  myPota
//
//  Created by Rodrigo Pimentel on 12/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "travelPotaDestinyCell.h"

@implementation travelPotaDestinyCell

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (IBAction)btnGetInfo:(id)sender
{
    [AppFunctions LOG_MESSAGE:_lblDestiny.text
                      message:@"ainda não pesquisa ..."
                       cancel:ERROR_BUTTON_CANCEL];
}

@end
