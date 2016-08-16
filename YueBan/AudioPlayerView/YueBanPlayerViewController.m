//
//  YueBanPlayerViewController.m
//  YueBan
//
//  Created by nmhuang on 16/8/14.
//  Copyright © 2016年 com.tencent. All rights reserved.
//

#import "YueBanPlayerViewController.h"
#import "PersonalCenterTableViewController.h"

@implementation YueBanPlayerViewController

@synthesize DJHeadIconImageView;
@synthesize DJNameAndSignatureLabel;
//@synthesize playListsButton;
@synthesize closeButton;
@synthesize mainBackgroundImageView;
//@synthesize currentListeners[7];
@synthesize statusBarView;
@synthesize mainViewController;

#define DJHEADICON_SIZE 64
#define PROGRESSSLIDER_SIZE 32

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    DJHeadIconImageView = [[UIImageView alloc] init];
    [self.view addSubview:DJHeadIconImageView];
    
    DJNameAndSignatureLabel = [[UILabel alloc] init];
    [self.view addSubview:DJNameAndSignatureLabel];
    
//    playListsButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.view addSubview:playListsButton];
//    [playListsButton addTarget:self action:@selector(onPlaylistButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:closeButton];
    [closeButton addTarget:self action:@selector(onCloseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    mainBackgroundImageView = [[UIImageView alloc] init];
    [mainBackgroundImageView setContentMode:UIViewContentModeScaleAspectFit];
    [mainBackgroundImageView setBackgroundColor:[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f]];
    [self.view addSubview:mainBackgroundImageView];
    
    /*    for(int i=0;i<sizeof(_currentListeners)/sizeof(typeof(_currentListeners[0]));i++){
     _currentListeners[i] = [[UIImageView alloc] init];
     [self.view addSubview:_currentListeners[i]];
     
     }*/
    [self.view addSubview:self.statusBarView];
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    DJHeadIconImageView.frame = CGRectMake(0.1*DJHEADICON_SIZE,0.1*DJHEADICON_SIZE,0.8*DJHEADICON_SIZE,0.8*DJHEADICON_SIZE);
    DJHeadIconImageView.layer.cornerRadius = DJHeadIconImageView.frame.size.width / 2;
    DJHeadIconImageView.clipsToBounds = YES;
    [self setDJHeadIcon:[UIImage imageNamed:@"usericon"]];
    
    DJNameAndSignatureLabel.frame = CGRectMake(DJHEADICON_SIZE,0,width-DJHEADICON_SIZE,DJHEADICON_SIZE);
    DJNameAndSignatureLabel.numberOfLines = 0;
    [self setDJNameAndSignature:@"乐伴" signature:@"大家好，我是乐小伴!"];
    
//    playListsButton.frame = CGRectMake(width-DJHEADICON_SIZE,DJHEADICON_SIZE/4,DJHEADICON_SIZE/2,DJHEADICON_SIZE/2);
//    [playListsButton setBackgroundImage:[UIImage imageNamed:@"playlists"] forState:UIControlStateNormal];
    
    closeButton.frame = CGRectMake(width-DJHEADICON_SIZE/2-10,DJHEADICON_SIZE/4,DJHEADICON_SIZE/2,DJHEADICON_SIZE/2);
    [closeButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    
    mainBackgroundImageView.frame = CGRectMake(0
                                               ,DJHEADICON_SIZE
                                               ,width
                                               ,height-2*DJHEADICON_SIZE-PROGRESSSLIDER_SIZE);
    [self setMainBackground:[UIImage imageNamed:@"bkg"]];
    
    /*    CGFloat listenerHeadIconSize = width / 7;
     for(int i=0;i<sizeof(_currentListeners)/sizeof(typeof(_currentListeners[0]));i++){
     _currentListeners[i].frame = CGRectMake(i*listenerHeadIconSize, height-DJHEADICON_SIZE-listenerHeadIconSize-PROGRESSSLIDER_SIZE, listenerHeadIconSize, listenerHeadIconSize);
     _currentListeners[i].layer.cornerRadius = _currentListeners[i].frame.size.width / 2;
     _currentListeners[i].clipsToBounds = YES;
     _currentListeners[i].image = [UIImage imageNamed:@"usericon"];
     }*/
    CGFloat navBarSize = self.navigationController.navigationBar.frame.size.height;
    CGFloat systemStatusBarSize = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat oriFrameSize = self.statusBarView.frame.size.height;
    self.statusBarView.frame = CGRectMake(0,height-navBarSize-systemStatusBarSize-oriFrameSize,width,oriFrameSize);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
     
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onEnterPersonalCenterView)];
    self.DJHeadIconImageView.userInteractionEnabled = YES;
    [self.DJHeadIconImageView addGestureRecognizer:tapRecognizer];
}



-(void)viewWillAppear:(BOOL)animated
{
    isEnterPersonalCenter = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(!isEnterPersonalCenter){
        
        [self.statusBarView removeFromSuperview];
        [self.mainViewController.view addSubview:self.statusBarView];
    }
}

#pragma mark /////////////////////////////设置播放界面相关UI元素/////////////////////////////////
- (void)setDJHeadIcon:(UIImage *)img
{
    [DJHeadIconImageView setImage:img];
}

- (void)setDJNameAndSignature:(NSString *)name signature:(NSString *)signature
{
    NSString *tmpString = [NSString stringWithFormat:@"%@\n%@",name,signature];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:tmpString];
    
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,name.length)];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0,name.length)];
    
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(name.length+1,signature.length)];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(name.length+1,signature.length)];
    
    DJNameAndSignatureLabel.attributedText = text;
}

- (void)setMainBackground:(UIImage *)img
{
    [mainBackgroundImageView setImage:img];
}

/*- (void)setCurrentListenerIcon:(UIImage *)img atIndex:(int)index
 {
 if(index == 0){
 [_currentListeners[0] setImage:img];
 }
 else{
 static int currentIconIndex = 1;
 [_currentListeners[currentIconIndex++] setImage:img];
 if(currentIconIndex > 6){
 currentIconIndex = 1;
 }
 }
 }*/

#pragma mark ///////////////////////////////////////按钮响应/////////////////////////////////////////////

- (void)onCloseButtonAction:(id)sender
{
    [self.mainViewController performSelector:@selector(stopPlayer) withObject:self.mainViewController];
}

/*- (void)onPlaylistButtonAction:(id)sender
{
    NSLog(@"显示个人中心");
}*/

-(void)onEnterPersonalCenterView
{
    isEnterPersonalCenter = YES;
    PersonalCenterTableViewController *vc = [[PersonalCenterTableViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    //[self.navigationController pushViewController:vc animated:YES];
}
@end
