//
//  BubbleItemView.m
//  YueBan
//
//  Created by nmhuang on 16/8/15.
//  Copyright © 2016年 com.tencent. All rights reserved.
//

#import "BubbleItemView.h"

@interface BubbleItemView ()

@end

@implementation BubbleItemView

@synthesize bkgImageView;
@synthesize albumImageView;
@synthesize albumTextLabel;
@synthesize bubbleId;

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        bkgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, width, height)];
        [self addSubview:bkgImageView];
        
        albumImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width/4, height/2/3, width/2, height/2)];
        albumImageView.layer.cornerRadius = albumImageView.frame.size.width / 2;
        albumImageView.clipsToBounds = YES;
        [self addSubview:albumImageView];
        
        albumTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(width/4,height / 6 + height / 2 , width / 2, 30)];
        [albumTextLabel setFont:[UIFont systemFontOfSize:20.0f * width / 250.0f]];
        [albumTextLabel setTextColor:[UIColor whiteColor]];
        [albumTextLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:albumTextLabel];
    }
    return self;
}

-(void)setActionDelegate:(UIViewController *)vc
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:vc action:@selector(onBubbleClicked:)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
    
}

-(void)setBkgImage:(UIImage*)img
{
    [bkgImageView setImage:img];
}

-(void)setAlbumImage:(UIImage *)img
{
    [albumImageView setImage:img];
}

-(void)setAlbumText:(NSString *)text
{
    albumTextLabel.text = text;
}

@end
