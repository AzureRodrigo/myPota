//
//  b3_User_Chat_Cell.h
//  mypota
//
//  Created by Rodrigo Pimentel on 02/02/15.
//  Copyright (c) 2015 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface b3_User_Chat_Cell  : UITableViewCell
{
    UIImageView* avatarImageView;
    UILabel* timeLabel;
    UILabel* messageLabel;
    BOOL sent;
    @private UIView * messageView;
    @private UIImageView * balloonView;
}

@property (nonatomic, readonly) UIView * messageView;
@property (nonatomic, readonly) UILabel * messageLabel;
@property (nonatomic, readonly) UILabel * timeLabel;
@property (nonatomic, readonly) UIImageView * avatarImageView;
@property (nonatomic, readonly) UIImageView * balloonView;
@property (assign) BOOL sent;

+(CGFloat)textMarginHorizontal;
+(CGFloat)textMarginVertical;
+(CGFloat)maxTextWidth;
+(CGSize)messageSize:(NSString*)message;
+(UIImage*)balloonImage:(BOOL)sent isSelected:(BOOL)selected;

-(id)initMessagingCellWithReuseIdentifier:(NSString*)reuseIdentifier;

@end

