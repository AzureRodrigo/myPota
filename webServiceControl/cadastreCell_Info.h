//
//  cadastreCell_TravelInfo.h
//  myPota
//
//  Created by Rodrigo Pimentel on 08/08/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cadastreCell_Info : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgHeader;

- (void)startInfo:(NSString *)_title id:(int)_id;

@end
