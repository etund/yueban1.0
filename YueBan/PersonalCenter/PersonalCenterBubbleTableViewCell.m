//
//  PersonalCenterBubbleTableViewCell.m
//  musicplayer
//
//  Created by nmhuang on 16/8/11.
//  Copyright © 2016年 com.tencent.test. All rights reserved.
//

#import "PersonalCenterBubbleTableViewCell.h"

@implementation PersonalCenterBubbleTableViewCell

@synthesize bubbleNameLabel;
@synthesize tailImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        self.accessoryType = UITableViewCellAccessoryNone;
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        bubbleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0,width - height,height)];
        [bubbleNameLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self addSubview:bubbleNameLabel];
        
        tailImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height/2, height/2)];
        self.accessoryView = tailImage;
    }
    
    return self;
}

- (void)setCellText:(NSString *)text tailImage:(UIImage*)image
{
    [bubbleNameLabel setText:text];
    [tailImage setImage:image];
}

@end
