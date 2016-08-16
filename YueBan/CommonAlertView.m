//
//  CommonAlertView.m
//  Kinder_teacher
//
//  Created by admin310 on 15/3/30.
//  Copyright (c) 2015年 csu.changsha.cn. All rights reserved.
//

#import "CommonAlertView.h"
#import "UIImage+GIF.h"
#import "MBProgressHUD.h"

@implementation CommonAlertView

+ (id)commonAlertViewObject
{
    static CommonAlertView *commonAlertViewObj = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        commonAlertViewObj = [[CommonAlertView alloc] init];
    });
    
    return commonAlertViewObj;
}

- (UIImageView *)showLoadingImageViewAddedTo:(UIView *)view
{
    CGFloat scale = [UIScreen mainScreen].scale;
    UIImageView *loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0f/scale, 128.0f/scale)];
    loadingImageView.image = [UIImage sd_animatedGIFNamed:@"loading"];
    loadingImageView.center = CGPointMake(view.center.x, view.center.y);
    [view addSubview:loadingImageView];
    
    return loadingImageView;
}

- (void)showNetworkErrorHUDAddedTo:(UIWindow *)window
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"请检查网络";
    hud.cornerRadius = 5.0f;
    hud.opacity = 0.5;
    hud.margin = 10.0f;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    
    [hud hide:YES afterDelay:3.0f];
}

- (MBProgressHUD *)showUploadHUDAddedTo:(UIWindow *)window
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:hud];
    hud.labelText = @"正在发布...";
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    
    return hud;
}

- (MBProgressHUD *)showUploadHUDAddedtO:(UIWindow *)window withText:(NSString *)text
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:hud];
    hud.labelText = text;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    
    return hud;
}

- (MBProgressHUD *)showDownloadHUDAddedTo:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view  animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    
    return hud;
}

- (void)showNotingUploadHUDAddedTo:(UIWindow *)window
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"没有可发布的内容.";
    hud.cornerRadius = 5.0f;
    hud.opacity = 0.5;
    hud.margin = 10.0f;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    
    [hud hide:YES afterDelay:2.0f];
}

- (void)showHUDAddedTo:(UIWindow *)window withText:(NSString *)text
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.cornerRadius = 5.0f;
    hud.opacity = 0.5;
    hud.margin = 10.0f;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    
    [hud hide:YES afterDelay:2.0f];
}

- (void)showHUDAddedToView:(UIView *)view withText:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.cornerRadius = 5.0f;
    hud.opacity = 0.5;
    hud.margin = 10.0f;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    
    [hud hide:YES afterDelay:2.0f];
}

- (UILabel *)labelAddedToView:(UIView *)view withText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];

    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont systemFontOfSize:16.f];
    label.textColor = [UIColor colorWithRed:0xac/255.0 green:0xaa/255.0 blue:0xab/255.0 alpha:1.0];
    label.center = CGPointMake(view.center.x, view.center.y - 24.f);
    
    [view addSubview:label];
    
    return label;
}

@end
