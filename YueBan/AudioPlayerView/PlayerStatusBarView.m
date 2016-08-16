//
//  PlayerStatusBar.m
//  YueBan
//
//  Created by nmhuang on 16/8/13.
//  Copyright © 2016年 com.tencent. All rights reserved.
//

#import "PlayerStatusBarView.h"

@implementation PlayerStatusBarView

#define SONGCOVER_SIZE 64
#define PROGRESSSLIDER_SIZE 24

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self =  [super initWithFrame:frame]){
        //[self setBackgroundColor:[UIColor colorWithRed:214/255.0f green:32/255.0f blue:75/255.0f alpha:0.2f]];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        _timeLabel = [[UILabel alloc] init];
        [self addSubview:_timeLabel];
        
        _durationLabel = [[UILabel alloc] init];
        [self addSubview:_durationLabel];
        
        _progressSlider = [[UISlider alloc] init];
        [self addSubview:_progressSlider];
        
        _songCoverImageView = [[UIImageView alloc] init];
        [self addSubview:_songCoverImageView];
        
        _songAndSingerLabel = [[UILabel alloc] init];
        [self addSubview:_songAndSingerLabel];
        
        _likeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_likeButton];
        [_likeButton addTarget:[self getViewController] action:@selector(onLikeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _dislikeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_dislikeButton];
        [_dislikeButton addTarget:[self getViewController]action:@selector(onDislikeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat width = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        
        _songCoverImageView.frame = CGRectMake(0.1*SONGCOVER_SIZE,0.1*SONGCOVER_SIZE, 0.8*SONGCOVER_SIZE, 0.8*SONGCOVER_SIZE);
        
        _songAndSingerLabel.frame = CGRectMake(SONGCOVER_SIZE,5,width-3*SONGCOVER_SIZE,SONGCOVER_SIZE - PROGRESSSLIDER_SIZE);
        _songAndSingerLabel.numberOfLines = 0;
        
        _likeButton.frame = CGRectMake(width-SONGCOVER_SIZE, 8, SONGCOVER_SIZE/2, SONGCOVER_SIZE/2);
        [_likeButton setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        
        _dislikeButton.frame = CGRectMake(width-SONGCOVER_SIZE/2, 8, SONGCOVER_SIZE/2, SONGCOVER_SIZE/2);
        [_dislikeButton setBackgroundImage:[UIImage imageNamed:@"dislike"] forState:UIControlStateNormal];
        
        _timeLabel.frame = CGRectMake(SONGCOVER_SIZE, height - PROGRESSSLIDER_SIZE, 50, PROGRESSSLIDER_SIZE);
        [_timeLabel setFont:[UIFont systemFontOfSize:14]];
        
        _durationLabel.frame = CGRectMake(width-50, height - PROGRESSSLIDER_SIZE, 50, PROGRESSSLIDER_SIZE);
        [_durationLabel setFont:[UIFont systemFontOfSize:14]];
        
        _progressSlider.frame = CGRectMake(SONGCOVER_SIZE + 50,height - PROGRESSSLIDER_SIZE, width-2*50-SONGCOVER_SIZE, PROGRESSSLIDER_SIZE);
        [_progressSlider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
        [self resetStatusBar];
        
    }
    return self;
}

- (void)resetStatusBar
{
    [self updateProgressBar:0 totalTime:0];
    [self setSongCoverImage:[UIImage imageNamed:@"defaultcover"]];
    [self setSongAndSingerName:@"未知" singer:@"当前没有歌曲"];
}

- (UIViewController*)getViewController
{
    id obj = [self nextResponder];
    while(![obj isKindOfClass:[UIViewController class]] && obj !=nil){
        obj = [obj nextResponder];
    }
    return obj;
}

- (void)setSongCoverImage:(UIImage *)img
{
    [_songCoverImageView setImage:img];
}

- (void)setSongAndSingerName:(NSString *)song singer:(NSString *)singer
{
    NSString *tmpString = [NSString stringWithFormat:@"%@\n%@",song,singer];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:tmpString];
    
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0,song.length)];
    
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(song.length+1,singer.length)];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(song.length+1,singer.length)];
    
    _songAndSingerLabel.attributedText = text;
}

- (void)updateProgressBar:(float)currentTime totalTime:(float)duration
{
    NSString *cur =[NSString stringWithFormat:@"%0.2i:%0.2i",(int)currentTime/60,((int)(currentTime))%60];
    NSString *dur =[NSString stringWithFormat:@"%0.2i:%0.2i",(int)duration/60,((int)(duration))%60];
    
    _timeLabel.text = cur;
    _durationLabel.text = dur;
    
    float progress = 0.0f;
    if(duration>0){
        progress = currentTime / duration;
    }
    _progressSlider.value = progress;
}

@end
