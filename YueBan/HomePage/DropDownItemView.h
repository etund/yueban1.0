//
//  DropDownItemView.h
//  YueBan
//
//  Created by nmhuang on 16/8/13.
//  Copyright © 2016年 com.tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownItemView : UIView

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *leftLabel;
@property(nonatomic,strong)UILabel *midLabel;
@property(nonatomic,strong)UILabel *rightLabel;

@property(nonatomic,strong)UISlider *slider;

- (int)getSliderValue;
- (void)setTitle:(NSString *)title leftLable:(NSString *)leftText midLabel:(NSString *)midText rightLabel:(NSString *)rightText;

@end
