//
//  packInfoPriceCell.h
//  myPota
//
//  Created by Rodrigo Pimentel on 02/11/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface p2_Package_Info_Cell_Price : UITableViewCell
{
    IBOutlet UILabel *lblCusto;
    IBOutlet UIImageView *lblBar1;
    IBOutlet UIImageView *lblBar2;
    IBOutlet UIImageView *lblBar3;
    
    int mySize;
    float centerLblCusto;
    float centerLblPrice;
    float centerLblBar1;
    float centerLblBar2;
    float centerLblBar3;
    
    BOOL isStarted;
    
    NSMutableArray *labels;
}

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;

- (void)rezise:(int)lines roons:(NSArray *)room coin:(NSString *)coin;
- (void)start;

@end

