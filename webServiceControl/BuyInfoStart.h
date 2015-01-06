//
//  BuyInfoStart.h
//  myPota
//
//  Created by Rodrigo Pimentel on 11/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyInfoStart : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

- (void)startInfo:(NSString *)_title;
@end
