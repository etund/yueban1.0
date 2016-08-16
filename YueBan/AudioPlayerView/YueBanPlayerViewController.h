//
//  YueBanPlayerViewController.h
//  YueBan
//
//  Created by nmhuang on 16/8/14.
//  Copyright © 2016年 com.tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerStatusBarView.h"
#import "YueBanPlayerViewController.h"

@interface YueBanPlayerViewController : UIViewController
{
    BOOL isEnterPersonalCenter;
}


@property(nonatomic,strong) UIImageView * DJHeadIconImageView;
@property(nonatomic,strong) UILabel *DJNameAndSignatureLabel;
@property(nonatomic,strong) UIButton *playListsButton;
@property(nonatomic,strong) UIButton *closeButton;
@property(nonatomic,strong) UIImageView *mainBackgroundImageView;
//@property(nonatomic,strong) UIImageView *currentListeners[7];
@property(nonatomic,weak)   PlayerStatusBarView *statusBarView;
@property(nonatomic,weak) UIViewController *mainViewController;


// 设置播放界面相关UI元素
- (void)setDJHeadIcon:(UIImage *)img;

- (void)setDJNameAndSignature:(NSString *)name signature:(NSString *)signature;

- (void)setMainBackground:(UIImage *)img;

//- (void)setCurrentListenerIcon:(UIImage *)img atIndex:(int)index;

@end
