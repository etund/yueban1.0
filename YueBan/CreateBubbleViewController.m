//
//  CreateBubbleViewController.m
//  Yueban
//
//  Created by looperwang on 16/8/13.
//  Copyright © 2016年 looperwang. All rights reserved.
//

#import "CreateBubbleViewController.h"
#import "AddSongViewController.h"

@interface CreateBubbleViewController ()

@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UILabel     *userNameLabel;

@property (nonatomic, strong) UIButton    *wordBtn;
@property (nonatomic, strong) UILabel     *addLabel;
@property (nonatomic, strong) UIButton    *addSongBtn;
@property (nonatomic, strong) UILabel     *btnLabel;

@property (nonatomic, strong) NSMutableArray *style;
@property (nonatomic, strong) NSMutableArray *styleBtn;

//@property (nonatomic, assign) CGFloat baseLine;

@end

@implementation CreateBubbleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.style = [[NSMutableArray alloc] initWithObjects:@"开心", @"热闹", @"外语", nil];
    self.styleBtn = [[NSMutableArray alloc] init];
    
    UIButton *btn_1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn_1 setTitle:self.style[0] forState:UIControlStateNormal];
    //[btn_1 setTitleEdgeInsets:UIEdgeInsetsMake(3, 2, 3, 2)];
    btn_1.layer.cornerRadius = 5.f;
    btn_1.layer.masksToBounds = YES;
    btn_1.layer.borderColor = [[UIColor colorWithRed:0xd6/255. green:0x20/255. blue:0x4b/255. alpha:1.0] CGColor];
    btn_1.layer.borderWidth = 1.f;
    btn_1.userInteractionEnabled = NO;
    [btn_1 setTitleColor:[UIColor colorWithRed:0xd6/255. green:0x20/255. blue:0x4b/255. alpha:1.0] forState:UIControlStateNormal];
    
    UIButton *btn_2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn_2 setTitle:self.style[1] forState:UIControlStateNormal];
    btn_2.layer.cornerRadius = 5.f;
    btn_2.layer.masksToBounds = YES;
    btn_2.layer.borderColor = [[UIColor colorWithRed:0xd6/255. green:0x20/255. blue:0x4b/255. alpha:1.0] CGColor];
    btn_2.layer.borderWidth = 1.f;
    btn_2.userInteractionEnabled = NO;
    [btn_2 setTitleColor:[UIColor colorWithRed:0xd6/255. green:0x20/255. blue:0x4b/255. alpha:1.0] forState:UIControlStateNormal];
    
    UIButton *btn_3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn_3 setTitle:self.style[2] forState:UIControlStateNormal];
    btn_3.layer.cornerRadius = 5.f;
    btn_3.layer.masksToBounds = YES;
    btn_3.layer.borderColor = [[UIColor colorWithRed:0xd6/255. green:0x20/255. blue:0x4b/255. alpha:1.0] CGColor];
    btn_3.layer.borderWidth = 1.f;
    btn_3.userInteractionEnabled = NO;
    [btn_3 setTitleColor:[UIColor colorWithRed:0xd6/255. green:0x20/255. blue:0x4b/255. alpha:1.0] forState:UIControlStateNormal];
    
    [self.styleBtn addObject:btn_1];
    [self.styleBtn addObject:btn_2];
    [self.styleBtn addObject:btn_3];
    
    self.title = @"创建气泡";
    self.view.backgroundColor = [UIColor colorWithRed:0xee/255.0 green:0xf0/255.0 blue:0xef/255.0 alpha:1.0];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"status_bar"] forBarMetrics:UIBarMetricsDefault];
    
    self.userImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"portrait"]];
    
    self.userNameLabel = [[UILabel alloc] init];
    self.userNameLabel.text = @"DJTencent";
    self.userNameLabel.font = [UIFont boldSystemFontOfSize:18.f];
    self.userNameLabel.textAlignment = NSTextAlignmentCenter;
    
    self.wordBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.wordBtn setTitle:@"介绍一下你要开始的音乐之旅吧" forState:UIControlStateNormal];
    self.wordBtn.layer.cornerRadius = 5.f;
    self.wordBtn.layer.masksToBounds = YES;
    self.wordBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.wordBtn.layer.borderWidth = 1.f;
    self.wordBtn.userInteractionEnabled = NO;
    [self.wordBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    self.addLabel = [[UILabel alloc] init];
    self.addLabel.text = @"已选标签";
    self.addLabel.textColor = [UIColor lightGrayColor];
    self.addLabel.font = [UIFont systemFontOfSize:13.f];
    
    self.addSongBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.addSongBtn setBackgroundImage:[UIImage imageNamed:@"addList"] forState:UIControlStateNormal];
    self.addSongBtn.layer.masksToBounds = YES;
    
    self.btnLabel = [[UILabel alloc] init];
    self.btnLabel.text = @"添加歌单";
    self.btnLabel.textColor = [UIColor colorWithRed:0xd6/255. green:0x20/255. blue:0x4b/255. alpha:1.0];
    self.btnLabel.textAlignment = NSTextAlignmentCenter;
    self.btnLabel.font = [UIFont systemFontOfSize:13.f];
    
    [self.view addSubview:self.userImageView];
    [self.view addSubview:self.userNameLabel];
    [self.view addSubview:self.wordBtn];
    [self.view addSubview:self.addLabel];
    [self.view addSubview:self.addSongBtn];
    [self.view addSubview:self.btnLabel];
    [self.view addSubview:self.styleBtn[0]];
    [self.view addSubview:self.styleBtn[1]];
    [self.view addSubview:self.styleBtn[2]];
    
    [self.addSongBtn addTarget:self action:@selector(startAddSongs) forControlEvents:UIControlEventTouchDown];
}

- (void)viewDidLayoutSubviews
{
    CGFloat baseLine = 100.f;
    
    CGFloat imageHeight = [UIImage imageNamed:@"portrait"].size.height;
    
    self.userImageView.center = CGPointMake(self.view.center.x, baseLine + imageHeight / 2);
    baseLine += imageHeight + 5;
    
    self.userNameLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20.f);
    self.userNameLabel.center = CGPointMake(self.view.center.x, baseLine + 5.f);
    baseLine += self.userNameLabel.frame.size.height + 40.f;
    
    self.wordBtn.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 100.f, 22.f);
    self.wordBtn.center = CGPointMake(self.view.center.x, baseLine + 5.f);
    baseLine += CGRectGetHeight(self.wordBtn.frame) + 8.f;
    
    self.addLabel.frame = CGRectMake(self.wordBtn.frame.origin.x + 5.f, baseLine, 55.f, 10.f);
    baseLine += CGRectGetHeight(self.addLabel.frame) + 40.f;
    
    self.addSongBtn.frame = CGRectMake(0, 0, 90.f, 90.f);
    self.addSongBtn.center = CGPointMake(self.view.center.x, baseLine + 45.f);
    baseLine += CGRectGetHeight(self.addSongBtn.frame) + 5.f;
    
    self.btnLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30.f);
    self.btnLabel.center = CGPointMake(self.view.center.x, baseLine + 5.f);
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(self.addLabel.frame) - ([UIScreen mainScreen].bounds.size.width - CGRectGetWidth(self.wordBtn.frame)) / 2 - 3 * 10.f - 10.f) / 3;
    
    ((UIButton *)self.styleBtn[0]).frame = CGRectMake(0, 0, width, CGRectGetHeight(self.addLabel.frame) * 2);
    ((UIButton *)self.styleBtn[0]).center = CGPointMake(CGRectGetMaxX(self.addLabel.frame) + width / 2 + 10.f, self.addLabel.center.y);
    
    ((UIButton *)self.styleBtn[1]).frame = CGRectMake(0, 0, width, CGRectGetHeight(self.addLabel.frame) * 2);
    ((UIButton *)self.styleBtn[1]).center = CGPointMake(CGRectGetMaxX(self.addLabel.frame) + width * 1.5 + 20.f, self.addLabel.center.y);
    
    ((UIButton *)self.styleBtn[2]).frame = CGRectMake(0, 0, width, CGRectGetHeight(self.addLabel.frame) * 2);
    ((UIButton *)self.styleBtn[2]).center = CGPointMake(CGRectGetMaxX(self.addLabel.frame) + width * 2.5 + 30.f, self.addLabel.center.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startAddSongs
{
    AddSongViewController *asvc = [[AddSongViewController alloc] init];
    
    [self.navigationController pushViewController:asvc animated:YES];
}

@end
