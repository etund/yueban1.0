//
//  YueBanDropDownView.h
//  YueBan
//
//  Created by nmhuang on 16/8/13.
//  Copyright © 2016年 com.tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownItemView.h"

@interface YueBanDropDownView : UIView

@property(nonatomic,strong) DropDownItemView *motionItem;
@property(nonatomic,strong) DropDownItemView *envItem;
@property(nonatomic,strong) DropDownItemView *languageItem;
@property(nonatomic,strong) DropDownItemView *followWhoItem;

@property(nonatomic,strong)UIButton *searchButton;
@property(nonatomic,strong)UIButton *createBubbleButton;

@property(nonatomic,strong)UIImageView *dropDownImageView;

- (void)getMotionValue:(int *)pMotionValue envValue:(int *)pEnvValue langValue:(int *)pLangValue;

@end
