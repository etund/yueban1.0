//
//  ViewController.h
//  YueBan
//
//  Created by nmhuang on 16/8/13.
//  Copyright © 2016年 com.tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YueBanDropDownView.h"
#import "PlayerStatusBarView.h"
#import "YueBanAudioPlayer.h"
#import "BubbleItemView.h"

#import "SongInfo.h"

@interface YueBanMainViewController : UIViewController
{
    int currentBubble;
}

@property (nonatomic,strong)UIButton *userPortraitButton;
@property (nonatomic,strong)BubbleItemView *bubbleImageView1;
@property (nonatomic,strong)BubbleItemView *bubbleImageView2;
@property (nonatomic,strong)BubbleItemView *bubbleImageView3;
@property (nonatomic,strong)BubbleItemView *bubbleImageView4;
@property (nonatomic,strong)BubbleItemView *bubbleImageView5;

@property (nonatomic,strong)YueBanDropDownView *dropDownView;
@property (nonatomic,strong)PlayerStatusBarView *playerStatusBarView;
@property (nonatomic,strong)YueBanAudioPlayer *audioPlayer;

@property (nonatomic, strong) NSArray<SongInfo *> *songList;

@end

