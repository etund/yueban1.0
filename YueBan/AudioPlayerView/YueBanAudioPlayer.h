//
//  YueBanAudioPlayer.h
//  YueBan
//
//  Created by nmhuang on 16/8/14.
//  Copyright © 2016年 com.tencent. All rights reserved.
//

#ifndef YueBanAudioPlayer_h
#define YueBanAudioPlayer_h

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreMedia/CoreMedia.h>
#import "PlayerStatusBarView.h"

@interface YueBanAudioPlayer :NSObject<AVAudioPlayerDelegate>
{
    float _totalDuration;
    float _currentDuration;
    BOOL _isPlay;
    id _timeObserver;
    int _currentPlayItemIndex;
}

@property(nonatomic,strong) NSMutableArray *playLists;
@property(nonatomic,strong) AVQueuePlayer *audioPlayer;
@property(nonatomic,weak) PlayerStatusBarView *statusBarView;

- (void)setPlayLists:(NSArray *)songLists withStatusBarView:(PlayerStatusBarView *)statusView;
- (void)setProgress:(float)timeInSecond;
- (void)setMusicToPlay:(int)index withProgress:(float)timeInSecond;
- (void)stopPlayer;

@end

#endif /* YueBanAudioPlayer_h */
