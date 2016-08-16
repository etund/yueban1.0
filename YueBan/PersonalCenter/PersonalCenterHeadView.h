//
//  PersonalCenterHeadView.h
//  musicplayer
//
//  Created by nmhuang on 16/8/11.
//  Copyright © 2016年 com.tencent.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCenterHeadView : UIView

@property(nonatomic,strong)UIImageView *returnImageView;
@property(nonatomic,strong)UIImageView *bkgImageView;
@property(nonatomic,strong)UIImageView *userIconImageView;
@property(nonatomic,strong)UILabel *userNameLabel;
@property(nonatomic,strong)UILabel *fansLabel;

- (void)setUserIcon:(UIImage *)icon userName:(NSString *)name fansNumber:(int)num;

@end
