//
//  PersonalCenterHeadView.m
//  musicplayer
//
//  Created by nmhuang on 16/8/11.
//  Copyright © 2016年 com.tencent.test. All rights reserved.
//

#import "PersonalCenterHeadView.h"

@implementation PersonalCenterHeadView

@synthesize returnImageView;
@synthesize bkgImageView;
@synthesize userIconImageView;
@synthesize userNameLabel;
@synthesize fansLabel;
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        bkgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,width,height)];
        [bkgImageView setImage:[UIImage imageNamed:@"personalcenterbkg"]];
        [self addSubview:bkgImageView];
        
        returnImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,20, 30, 30)];
        [self addSubview:returnImageView];
        [returnImageView setImage:[UIImage imageNamed:@"return"]];
        returnImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onReturn:)];
        [returnImageView addGestureRecognizer:tapRecognizer];
        
        userIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((width - height/2)/2,height/5, height/2, height/2)];
        userIconImageView.layer.cornerRadius = userIconImageView.frame.size.width / 2;
        userIconImageView.clipsToBounds = YES;
        [self addSubview:userIconImageView];
        
        userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake((width - 120)/2, height/2+height/5, 120, 30)];
        
        [userNameLabel setFont:[UIFont systemFontOfSize:25.0f]];
        [userNameLabel setTextColor:[UIColor whiteColor]];
        [userNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:userNameLabel];
        
        fansLabel = [[UILabel alloc] initWithFrame:CGRectMake((width - 80)/2, height/2 +height/5 + 30, 80, 20)];
        [fansLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [fansLabel setTextColor:[UIColor whiteColor]];
        
        [fansLabel setTextAlignment:NSTextAlignmentCenter];
        fansLabel.layer.borderWidth = 1;
        fansLabel.layer.cornerRadius = 5;
        fansLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:fansLabel];
    }
    return self;
}

- (void)setUserIcon:(UIImage *)icon userName:(NSString *)name fansNumber:(int)num
{
    [userIconImageView setImage:icon];
    [userNameLabel setText:name];
    NSString *str = [NSString stringWithFormat:@"粉丝:%d%@",num<9999?num:9999,num>9999?@"+":@""];
    [fansLabel setText:str];
}

- (UIViewController*)getViewController
{
    id obj = [self nextResponder];
    while(![obj isKindOfClass:[UIViewController class]] && obj !=nil){
        obj = [obj nextResponder];
    }
    return obj;
}

- (void)onReturn:(id)sender
{
    [[self getViewController] dismissViewControllerAnimated:YES completion:nil];
}

@end
