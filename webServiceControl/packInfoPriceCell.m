//
//  packInfoPriceCell.m
//  myPota
//
//  Created by Rodrigo Pimentel on 02/11/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "packInfoPriceCell.h"

#define SIZE_START 158
#define SIZE_PLUS  20

@implementation packInfoPriceCell

- (void)start
{
    if (isStarted != YES) {
        mySize = SIZE_START;
        centerLblCusto = lblCusto.center.y;
        centerLblPrice = _lblPrice.center.y;
        centerLblBar1  = lblBar1.center.y;
        centerLblBar2  = lblBar2.center.y;
        centerLblBar3  = lblBar3.center.y;
        isStarted      = YES;
        labels         = [NSMutableArray new];
    }
}

- (void)rezise:(int)extraLine roons:(NSArray *)room coin:(NSString *)coin
{
    
//    adjustsFontSizeToFitWidth = YES;
    
    [lblCusto   setCenter:CGPointMake(lblCusto.center.x,  centerLblCusto + (SIZE_PLUS * extraLine))];
    [_lblPrice  setCenter:CGPointMake(_lblPrice.center.x, centerLblPrice + (SIZE_PLUS * extraLine))];
    [lblBar1    setCenter:CGPointMake(lblBar1.center.x,   centerLblBar1  + (SIZE_PLUS * extraLine))];
    [lblBar2    setCenter:CGPointMake(lblBar2.center.x,   centerLblBar2  + (SIZE_PLUS * extraLine))];
    [lblBar3    setCenter:CGPointMake(lblBar3.center.x,   centerLblBar3  + (SIZE_PLUS * extraLine))];
    
    for (id tmp in labels) [tmp removeFromSuperview];
    
    labels = [NSMutableArray new];
    
    int index = 0;
    for (NSDictionary *tmp in room) {
        if ([[tmp objectForKey:PACKAGE_INFO_ROOM_NUMBER]intValue] > 0) {
            index += 1;
            
            //room
            UIFont * customFont = [UIFont fontWithName:FONT_NAME size:8];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(lblCusto.center.x - lblCusto.frame.size.width/2,
                                                                      lblCusto.center.y - ((SIZE_PLUS) * index) - lblCusto.frame.size.height,
                                                                      lblCusto.frame.size.width * 2, lblCusto.frame.size.height)];
            NSString *text = @"viajantes";
            if ([[tmp objectForKey:PACKAGE_INFO_ROOM_NUMBER] intValue] == 1)
                text = @"viajante";
            
            [label setText:[NSString stringWithFormat:@"%d %@, %@",
                            [[tmp objectForKey:PACKAGE_INFO_ROOM_NUMBER] intValue] * [[tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_ROOM_QTD_PEOPLE]intValue], text, [tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_ROOM_DSC_TYPE_ACOMODATION]]];
            [label setFont:customFont];
            label.font = [label.font fontWithSize:10];
            label.baselineAdjustment        = UIBaselineAdjustmentAlignBaselines;
            label.backgroundColor           = [UIColor clearColor];
            label.textColor                 = [UIColor blackColor];
            label.textAlignment             = NSTextAlignmentLeft;
            
            [labels addObject:label];
            
            //price
            label = [[UILabel alloc]initWithFrame:CGRectMake(_lblPrice.center.x - _lblPrice.frame.size.width/2,
                                                             lblCusto.center.y - ((SIZE_PLUS) * index) - lblCusto.frame.size.height,
                                                             _lblPrice.frame.size.width,
                                                             lblCusto.frame.size.height)];
            
            [label setText:[NSString stringWithFormat:@"%@ %.2f", coin, [[tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_ROOM_VALUE_VALUE_VENDA]floatValue] * [[tmp objectForKey:PACKAGE_INFO_ROOM_NUMBER]intValue] * [[tmp objectForKey:PACKAGE_INFO_DATA_SEARCH_ROOM_QTD_PEOPLE]intValue]]];
            
            [label setFont:customFont];
            label.font = [label.font fontWithSize:10];
            label.baselineAdjustment        = UIBaselineAdjustmentAlignBaselines;
            label.backgroundColor           = [UIColor clearColor];
            label.textColor                 = [UIColor blackColor];
            label.textAlignment             = NSTextAlignmentRight;
            
            [labels addObject:label];
            
        }
    }
    
    for (id tmp in labels) [self addSubview:tmp];
}

@end
