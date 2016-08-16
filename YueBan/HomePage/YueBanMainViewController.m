//
//  ViewController.m
//  YueBan
//
//  Created by nmhuang on 16/8/13.
//  Copyright © 2016年 com.tencent. All rights reserved.
//

#import "YueBanMainViewController.h"
#import "YueBanPlayerViewController.h"
#import "PersonalCenterTableViewController.h"
#import "AddSongViewController.h"

#import "YBDevice.h"
#import "DataService.h"


@interface YueBanMainViewController ()

@end

@implementation YueBanMainViewController

@synthesize userPortraitButton;
@synthesize bubbleImageView1;
@synthesize bubbleImageView2;
@synthesize bubbleImageView3;
@synthesize bubbleImageView4;
@synthesize bubbleImageView5;

@synthesize dropDownView;
@synthesize playerStatusBarView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"statusbar"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"乐伴";
    
    [self initUserPortrait];
    [self initBubbles];
    [self initDropDownView];
    [self initPlayerStatusBarView];
}

-(void)initUserPortrait
{
    CGFloat navBarSize = self.navigationController.navigationBar.frame.size.height - 4;
    userPortraitButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, navBarSize,navBarSize)];
    userPortraitButton.layer.cornerRadius = userPortraitButton.frame.size.width / 2;
    userPortraitButton.clipsToBounds = YES;
    [userPortraitButton addTarget:self action:@selector(onUserPortraitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:userPortraitButton];
    
    [self setUserPortraitImage:[UIImage imageNamed:@"贺敬轩 - 我决定不爱了 (《我的六次元男友》电影主题曲)"]];
}

- (void)initBubbles
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    CGFloat bubble1Size = 0.38*height;
    bubbleImageView1 = [[BubbleItemView alloc] initWithFrame:CGRectMake(width - bubble1Size - 5, 0.3*height, bubble1Size,bubble1Size)];
    [bubbleImageView1 setBubbleId:1];
    [bubbleImageView1 setBkgImage:[UIImage imageNamed:@"bubble1"]];
    [bubbleImageView1 setActionDelegate:self];
    //[self setBubbleAlbumImage:[UIImage imageNamed:@"安以轩 - 如果那天没有遇见你"] label:@"如果那天没有遇见你" withIndex:1];
    [self.view addSubview:bubbleImageView1];
    
    CGFloat bubble2Size = 0.22*height;
    bubbleImageView2 = [[BubbleItemView alloc] initWithFrame:CGRectMake(width - bubble2Size - 2, bubble2Size/3, bubble2Size,bubble2Size)];
    [bubbleImageView2 setBkgImage:[UIImage imageNamed:@"bubble2"]];
    [bubbleImageView2 setBubbleId:2];
    [bubbleImageView2 setActionDelegate:self];
    [self setBubbleAlbumImage:[UIImage imageNamed:@"陈楚生 - 爱过 (《非诚勿扰2》电影插曲)"] label:@"爱过" withIndex:2];
    [self.view addSubview:bubbleImageView2];
    
    CGFloat bubble3Size = 0.26*height;
    bubbleImageView3 = [[BubbleItemView alloc] initWithFrame:CGRectMake(2,bubble3Size/2, bubble3Size,bubble3Size)];
    [bubbleImageView3 setBkgImage:[UIImage imageNamed:@"bubble3"]];
    [bubbleImageView3 setBubbleId:3];
    [bubbleImageView3 setActionDelegate:self];
    [self setBubbleAlbumImage:[UIImage imageNamed:@"萧亚轩 - 突然想起你"] label:@"突然想起你" withIndex:3];
    [self.view addSubview:bubbleImageView3];
    
    CGFloat bubble4Size = 0.30*height;
    bubbleImageView4 = [[BubbleItemView alloc] initWithFrame:CGRectMake(-bubble4Size/3,1.5*bubble4Size, bubble4Size,bubble4Size)];
    [bubbleImageView4 setBkgImage:[UIImage imageNamed:@"bubble4"]];
    [bubbleImageView4 setBubbleId:4];
    [bubbleImageView4 setActionDelegate:self];
    [self setBubbleAlbumImage:[UIImage imageNamed:@"小沈阳 - 花房姑娘 (Live)"] label:@"花房姑娘" withIndex:4];
    [self.view addSubview:bubbleImageView4];
    
    CGFloat bubble5Size = 0.32*height;
    bubbleImageView5 = [[BubbleItemView alloc] initWithFrame:CGRectMake(width - bubble5Size - 2, height - 1.15*bubble5Size, bubble5Size,bubble5Size)];
    [bubbleImageView5 setBkgImage:[UIImage imageNamed:@"bubble5"]];
    [bubbleImageView5 setBubbleId:5];
    [bubbleImageView5 setActionDelegate:self];
    [self setBubbleAlbumImage:[UIImage imageNamed:@"庄心妍 - 走着走着就散了"] label:@"走着走着就散了" withIndex:5];
    [self.view addSubview:bubbleImageView5];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recvNotification:) name:@"NOTIFICATION_CREATE_BUBBLE" object:nil];
}

- (void)recvNotification:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    
    self.songList = dic[@"info"];
    
    NSMutableArray *urlArrays = [[NSMutableArray alloc] init];
    UIImage *img = [UIImage imageNamed:@"defaultcover"];
    for(int i=0;i<[self.songList count];i++)
    {
        NSString *url= [NSString stringWithFormat:@"http://%@/Foundation%@",SERVER_IP,self.songList[i].songURL];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.songList[i].songName,@"song",self.songList[i].singer,@"singer",url,@"url",img,@"cover",nil];
        [urlArrays addObject:dict];
    }
    
    if(self.audioPlayer!=nil){
        [self.audioPlayer stopPlayer];
        self.audioPlayer = nil;
    }
    self.audioPlayer = [[YueBanAudioPlayer alloc] init];
    [self.audioPlayer setPlayLists:urlArrays withStatusBarView:self.playerStatusBarView];
    [self.audioPlayer.audioPlayer play];
   // [self jumpToPlayerView];
    [self setBubbleAlbumImage:[UIImage imageNamed:@"贺敬轩 - 我决定不爱了 (《我的六次元男友》电影主题曲)"] label:@"我的歌单" withIndex:1];
}

- (void)onUserPortraitButtonAction:(id)sender
{
    PersonalCenterTableViewController *vc = [[PersonalCenterTableViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)jumpToPlayerView
{
    YueBanPlayerViewController *vc = [[YueBanPlayerViewController alloc] init];
    [self.playerStatusBarView removeFromSuperview];
    vc.mainViewController = self;
    vc.statusBarView = self.playerStatusBarView;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onBubbleClicked:(UITapGestureRecognizer *)sender
{
    int bubbleId = [(BubbleItemView *)[sender view] bubbleId];
    NSLog(@"气泡%i被点击了",bubbleId);
    if(currentBubble == bubbleId){
        [self jumpToPlayerView];
    }else{
        if(self.audioPlayer != nil){
            [self.audioPlayer stopPlayer];
            self.audioPlayer = nil;
        }
        NSString *url0 = @"http://sc1.111ttt.com/2015/1/07/03/100032248505.mp3";
        NSString *url2 = @"http://sc1.111ttt.com/2016/1/08/05/201051713464.mp3";
        NSString *url1 = @"http://sc1.111ttt.com/2016/5/08/04/201042156070.mp3";
        NSString *singer0 = @"BIG BANG";
        NSString *singer1 = @"薛之谦";
        NSString *singer2 = @"天空";
        NSString *song0 = @"BANG BANG BANG";
        NSString *song1 = @"方圆几里";
        NSString *song2 = @"天空之城";
        UIImage *img0 = [UIImage imageNamed:@"songcover"];
        UIImage *img1 = [UIImage imageNamed:@"songcover"];
        UIImage *img2 = [UIImage imageNamed:@"songcover"];
        
        NSDictionary *dict0 = [NSDictionary dictionaryWithObjectsAndKeys:song0,@"song",singer0,@"singer",url0,@"url",img0,@"cover",nil];
        NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:song1,@"song",singer1,@"singer",url1,@"url",img1,@"cover",nil];
        NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:song2,@"song",singer2,@"singer",url2,@"url",img2,@"cover",nil];
        
        NSArray *urlArrays;
        switch (bubbleId) {
            case 1:
                urlArrays = [NSArray arrayWithObjects:dict0,nil];
                break;
            case 2:
                urlArrays = [NSArray arrayWithObjects:dict1,nil];
                break;
            case 3:
                urlArrays = [NSArray arrayWithObjects:dict2,nil];
                break;
            case 4:
                urlArrays = [NSArray arrayWithObjects:dict0,dict1,nil];
                break;
            case 5:
                urlArrays = [NSArray arrayWithObjects:dict1,dict2,nil];
                break;
            default:
                break;
        }
        
        self.audioPlayer = [[YueBanAudioPlayer alloc] init];
        [self.audioPlayer setPlayLists:urlArrays withStatusBarView:self.playerStatusBarView];
        [self.audioPlayer.audioPlayer play];
        [self jumpToPlayerView];
    }
    currentBubble = bubbleId;
}

- (void)initDropDownView
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    dropDownView = [[YueBanDropDownView alloc] initWithFrame:CGRectMake(0,-285/*-0.43*height*/,width, 360/*height*0.55f*/)];
    [self.view addSubview:dropDownView];
}

- (void)initPlayerStatusBarView
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    CGFloat navBarSize = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    playerStatusBarView = [[PlayerStatusBarView alloc] initWithFrame:CGRectMake(0,height - navBarSize - statusBarSize - 64 ,width, 64)];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onPlayerStatusBarClicked:)];
    [playerStatusBarView addGestureRecognizer:tapRecognizer];
    [self.view addSubview:playerStatusBarView];
}

- (UIViewController*)getViewController:(UIView *)view
{
    id obj = [view nextResponder];
    while(![obj isKindOfClass:[UIViewController class]] && obj !=nil){
        obj = [obj nextResponder];
    }
    return obj;
}


- (void)onPlayerStatusBarClicked:(id)sender
{
    UIViewController *vc = [self getViewController:self.playerStatusBarView];
    if([vc isKindOfClass:[YueBanMainViewController class]]){
        if(currentBubble >=1 && currentBubble <=5){
            [self jumpToPlayerView];
        }
    }else{
    }
}

- (void)onLikeButtonAction:(id)sender
{
    NSLog(@"喜欢");
}

- (void)onDislikeButtonAction:(id)sender
{
    NSLog(@"不喜欢");
}

- (void)onCreateBubble:(id)sender
{
    int motionValue = 1,envValue = 1,langValue = 1;
    [self.dropDownView getMotionValue:&motionValue envValue:&envValue langValue:&langValue];
    
    YBDevice *info = [YBDevice sharedDevice];
    info.motionValue = motionValue;
    info.envValue = envValue;
    info.langValue = langValue;
    
    NSLog(@"onCreateBubble:%i,%i,%i",motionValue,envValue,langValue);
    AddSongViewController *vc = [[AddSongViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onSearchBubble:(id)sender
{
    int motionValue = 1,envValue = 1,langValue = 1;
    [self.dropDownView getMotionValue:&motionValue envValue:&envValue langValue:&langValue];
    NSLog(@"onSearchBubble:%i,%i,%i",motionValue,envValue,langValue);
}

-(void)stopPlayer
{
    if(self.audioPlayer != nil){
        [self.audioPlayer stopPlayer];
        self.audioPlayer = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
    currentBubble = -1;
}

-(void)setUserPortraitImage:(UIImage *)img
{
    [userPortraitButton setBackgroundImage:img forState:UIControlStateNormal];
}

-(void)setBubbleAlbumImage:(UIImage *)img label:(NSString *)text withIndex:(int)index
{
    switch (index) {
        case 1:
            [bubbleImageView1 setAlbumImage:img];
            [bubbleImageView1 setAlbumText:text];
            break;
        case 2:
            [bubbleImageView2 setAlbumImage:img];
            [bubbleImageView2 setAlbumText:text];
            break;
        case 3:
            [bubbleImageView3 setAlbumImage:img];
            [bubbleImageView3 setAlbumText:text];
            break;
        case 4:
            [bubbleImageView4 setAlbumImage:img];
            [bubbleImageView4 setAlbumText:text];
            break;
        case 5:
            [bubbleImageView5 setAlbumImage:img];
            [bubbleImageView5 setAlbumText:text];
            break;
            
        default:
            break;
    }
}

@end
