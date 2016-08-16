//
//  CommonAlertView.h
//  Kinder_teacher
//
//  Created by admin310 on 15/3/30.
//  Copyright (c) 2015年 csu.changsha.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CommonAlertView : NSObject

+ (id)commonAlertViewObject;

- (UIImageView *)showLoadingImageViewAddedTo:(UIView *)view;

- (void)showNetworkErrorHUDAddedTo:(UIWindow *)window;

- (MBProgressHUD *)showUploadHUDAddedTo:(UIWindow *)window;
- (MBProgressHUD *)showDownloadHUDAddedTo:(UIView *)view;

- (void)showNotingUploadHUDAddedTo:(UIWindow *)window;

- (void)showHUDAddedTo:(UIWindow *)window withText:(NSString *)text;
- (void)showHUDAddedToView:(UIView *)view withText:(NSString *)text;

- (MBProgressHUD *)showUploadHUDAddedtO:(UIWindow *)window withText:(NSString *)text;

- (UILabel *)labelAddedToView:(UIView *)view withText:(NSString *)text;

@end
