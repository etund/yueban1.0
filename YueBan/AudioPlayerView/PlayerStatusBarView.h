//
//  PlayerStatusBar.h
//  YueBan
//
//  Created by nmhuang on 16/8/13.
//  Copyright © 2016年 com.tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerStatusBarView : UIView
{
    __strong UILabel *_timeLabel;
    __strong UILabel *_durationLabel;
    __strong UISlider *_progressSlider;
    __strong UIImageView *_songCoverImageView;
    __strong UILabel *_songAndSingerLabel;
    __strong UIButton *_likeButton;
    __strong UIButton *_dislikeButton;
    __strong NSMutableArray *_playLists;
}

- (void)setSongCoverImage:(UIImage *)img;
- (void)setSongAndSingerName:(NSString *)song singer:(NSString *)singer;
- (void)updateProgressBar:(float)currentTime totalTime:(float)duration;

- (void)resetStatusBar;

@end
