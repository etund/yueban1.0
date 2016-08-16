//
//  DropDownItemView.m
//  YueBan
//
//  Created by nmhuang on 16/8/13.
//  Copyright © 2016年 com.tencent. All rights reserved.
//

#import "DropDownItemView.h"

@implementation DropDownItemView

@synthesize titleLabel;
@synthesize leftLabel;
@synthesize midLabel;
@synthesize rightLabel;
@synthesize slider;

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((width-40)/2, 10, 40, 20)];
        titleLabel.font = [UIFont systemFontOfSize:12.0f];
        titleLabel.textAlignment= NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 30, width-40, 20)];
        [slider setValue:0.5f];
        [slider setMaximumTrackTintColor:[UIColor colorWithRed:214/255.0f green:32/255.0f blue:75/255.0f alpha:1.0f]];
        [slider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
        [slider addTarget:self action:@selector(onValueChangged) forControlEvents:UIControlEventValueChanged];
        [slider setContinuous:NO];
        [self addSubview:slider];
        
        leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 40, 20)];
        leftLabel.font = [UIFont systemFontOfSize:12.0f];
        leftLabel.textAlignment= NSTextAlignmentCenter;
        leftLabel.textColor = [UIColor grayColor];
        [self addSubview:leftLabel];
        
        midLabel = [[UILabel alloc] initWithFrame:CGRectMake((width-40)/2, 50, 40, 20)];
        midLabel.font = [UIFont systemFontOfSize:12.0f];
        midLabel.textAlignment= NSTextAlignmentCenter;
        midLabel.textColor = [UIColor grayColor];
        [self addSubview:midLabel];
        
        rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(width-60, 50, 40, 20)];
        rightLabel.font = [UIFont systemFontOfSize:12.0f];
        rightLabel.textAlignment= NSTextAlignmentCenter;
        rightLabel.textColor = [UIColor grayColor];
        [self addSubview:rightLabel];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title leftLable:(NSString *)leftText midLabel:(NSString *)midText rightLabel:(NSString *)rightText
{
    titleLabel.text = title;
    leftLabel.text = leftText;
    midLabel.text = midText;
    rightLabel.text = rightText;
}

- (void)onValueChangged
{
    float value =[slider value];
    float newValue = 0.0f;
    if(value >= 0.25f && value < 0.75f){
        newValue = 0.5f;
    }
    else if(value >= 0.75f){
        newValue = 1.0f;
    }
    [slider setValue:newValue];
}

- (int)getSliderValue
{
    float value =[slider value];
    int ret = 0;
    if(value >= 0.33 && value < 0.66){
        ret = 1;
    }
    else if(value >= 0.66){
        ret = 2;
    }
    return ret;
}
@end
