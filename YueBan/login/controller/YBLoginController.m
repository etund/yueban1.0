//
//  YBLoginController.m
//  YueBan
//
//  Created by etund on 16/8/15.
//  Copyright © 2016年 etund. All rights reserved.
//

#import "YBLoginController.h"
#import "Masonry.h"
#include "sdkdef.h"
#import "YBDevice.h"
#import "sdkCall.h"
#import "YueBanMainViewController.h"

@interface YBLoginController ()

@end

@implementation YBLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self setUpView];
    
}

- (void)setUp{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessed) name:kLoginSuccessed object:[sdkCall getinstance]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFailed) name:kLoginFailed object:[sdkCall getinstance]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginCancelled) name:kLoginCancelled object:[sdkCall getinstance]];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setUpView{
    UIView *topV = [[UIView alloc] init];
    topV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topV];
    __weak typeof(self) weakSelf = self;
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.equalTo(weakSelf.view.mas_height).multipliedBy(0.4);
    }];
    
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.image = [UIImage imageNamed:@"icon"];
    iconImage.backgroundColor = [UIColor clearColor];
    [topV addSubview:iconImage];
#pragma mark - TODO 图片
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:13];
    [topV addSubview:label];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"乐伴\n一路音你相伴"];
    [attrStr addAttributes:@{
                             NSFontAttributeName:[UIFont systemFontOfSize:24 weight:UIFontWeightBold],
                             } range:NSMakeRange(0, 2)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(0, 2)];
    label.attributedText = attrStr;
    
    
    
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.height.width.equalTo(@100);
        make.top.offset(150);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImage.mas_bottom).multipliedBy(1.05);
        make.centerX.equalTo(iconImage.mas_centerX);
    }];
    
    
    
    UIView *bottomV = [[UIView alloc] init];
    bottomV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomV];
    [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.equalTo(topV);
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [loginBtn setImage:[UIImage imageNamed:@"login"] forState:UIControlStateHighlighted];
    
    loginBtn.backgroundColor = [UIColor clearColor];
    loginBtn.layer.cornerRadius = 20;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomV addSubview:loginBtn];
#pragma  mark - TODO 背景色 图片
 
    UIImageView *bottomImage = [[UIImageView alloc] init];
    bottomImage.backgroundColor = [UIColor clearColor];
    bottomImage.image = [UIImage imageNamed:@"bottom"];
    [bottomV addSubview:bottomImage];
#pragma  mark - TODO 图片
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(30);
        make.height.equalTo(@40);
        make.width.equalTo(@150);
#pragma  MARK - TODO 大小
    }];
    
    [bottomImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(0);
        make.height.equalTo(@187);
    }];
}

#pragma  mark - Event
- (void)loginClick{
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            nil];
    
    [[[sdkCall getinstance] oauth] authorize:permissions inSafari:NO];
    NSLog(@"%@", [YBDevice sharedDevice].uuid);
}

- (void)loginSuccessed{
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[[YueBanMainViewController alloc] init]];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)loginFailed{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"结果" message:@"登录失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alertView show];}
- (void)loginCancelled{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"结果" message:@"登录取消" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - 销毁
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
