//
//  PersonalCenterBubbleTableViewCell.h
//  musicplayer
//
//  Created by nmhuang on 16/8/11.
//  Copyright © 2016年 com.tencent.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCenterBubbleTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *bubbleNameLabel;
@property (nonatomic,strong)UIImageView *tailImage;

- (void)setCellText:(NSString *)text tailImage:(UIImage *)image;

@end
