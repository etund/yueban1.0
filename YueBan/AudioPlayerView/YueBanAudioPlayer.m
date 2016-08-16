//
//  YueBanAudioPlayer.m
//  YueBan
//
//  Created by nmhuang on 16/8/14.
//  Copyright © 2016年 com.tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YueBanAudioPlayer.h"

@implementation YueBanAudioPlayer

@synthesize audioPlayer;
@synthesize playLists;
@synthesize statusBarView;

- (void)setPlayLists:(NSArray *)songLists withStatusBarView:(PlayerStatusBarView *)statusView
{
    if(playLists){
        NSLog(@"%s:播放列表只能设置一次!",__func__);
        return;
    }
    
    self.statusBarView = statusView;
    
    playLists = [[NSMutableArray alloc] init];
    
    NSMutableArray *avplayerItemLists = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < [songLists count]; i++){
        NSURL *audioURL = [NSURL URLWithString:[songLists[i] objectForKey:@"url"]];
        AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:audioURL options:nil];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:urlAsset];
        
        NSMutableDictionary *item = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [songLists[i] objectForKey:@"song"],@"song",
                                     [songLists[i] objectForKey:@"singer"],@"singer",
                                     [songLists[i] objectForKey:@"url"],@"url",
                                     [songLists[i] objectForKey:@"cover"],@"cover",
                                     playerItem,@"AVPlayerItem",
                                     nil];
        [playLists addObject:item];
        
        [avplayerItemLists addObject:playerItem];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPlayNextItem:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    _currentPlayItemIndex = 0;
    
    self.audioPlayer = [[AVQueuePlayer alloc] initWithItems:avplayerItemLists];
    [self initProcessTimer];
    [self updatePlayBar];
}

-(void)setProgress:(float)timeInSecond
{
    [self.audioPlayer seekToTime:CMTimeMakeWithSeconds(timeInSecond, USEC_PER_SEC) completionHandler:^(BOOL finish){
        if(_isPlay){
            [self.audioPlayer play];
        }
    }];
}

- (void)setMusicToPlay:(int)index withProgress:(float)timeInSecond
{
    if(index >= 0 && index < [playLists count]){
        NSArray *array = [self.audioPlayer items];
        int pos = (int)[array indexOfObject:[playLists[index] objectForKey:@"AVPlayerItem"]];
        for(int i = 0;i<pos - 1;i++){
            [self.audioPlayer removeItem:array[i]];
            [playLists[_currentPlayItemIndex + i] removeObjectForKey:@"AVPlayerItem"];
        }
        if(pos > 0){
            [playLists[index - 1] removeObjectForKey:@"AVPlayerItem"];
            [self.audioPlayer advanceToNextItem];
            _currentPlayItemIndex = index;
            if(timeInSecond > 0){
                [self setProgress:timeInSecond];
            }
            [self updatePlayBar];
        }
    }
}

- (void)stopPlayer
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.audioPlayer.rate == 1) {
        [self.audioPlayer pause];
    }
    [self.audioPlayer removeTimeObserver:_timeObserver];
    _timeObserver = nil;
    [self.audioPlayer removeAllItems];
    self.audioPlayer = nil;
    [self.statusBarView resetStatusBar];
}

- (CMTime)playerItemDuration
{
    AVPlayerItem *playerItem = [self.audioPlayer currentItem];
    if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
        return([playerItem duration]);
    }
    return(kCMTimeInvalid);
}

-(void)initProcessTimer
{
    if(!_timeObserver){
        CMTime time = CMTimeMake(1,4);
        __weak typeof(self) weakSelf = self;
        _timeObserver = [self.audioPlayer addPeriodicTimeObserverForInterval:time
                                                                       queue:NULL
                                                                  usingBlock:^(CMTime time)
                         {
                             [weakSelf updateProgressBar];
                         }];
    }
}

- (void)onPlayNextItem:(NSNotification*)notification
{
    _currentPlayItemIndex++;
    [self updatePlayBar];
    [playLists[_currentPlayItemIndex - 1] removeObjectForKey:@"AVPlayerItem"];
}

- (void)updatePlayBar
{
    if(_currentPlayItemIndex >= 0 && _currentPlayItemIndex < [playLists count]){
        [statusBarView setSongAndSingerName:[playLists[_currentPlayItemIndex] objectForKey:@"song"]
                                     singer:[playLists[_currentPlayItemIndex] objectForKey:@"singer"]];
        [statusBarView setSongCoverImage:[playLists[_currentPlayItemIndex] objectForKey:@"cover"]];
    }
}

- (void)updateProgressBar
{
    CMTime playerDuration = [self playerItemDuration];
    _totalDuration = CMTimeGetSeconds(playerDuration);
    if (isfinite(_totalDuration)){
        _currentDuration = CMTimeGetSeconds([self.audioPlayer currentTime]);
        [statusBarView updateProgressBar:_currentDuration totalTime:_totalDuration];
    }
}

@end