//
//  YueBanDropDownView.m
//  YueBan
//
//  Created by nmhuang on 16/8/13.
//  Copyright © 2016年 com.tencent. All rights reserved.
//

#import "YueBanDropDownView.h"

@interface YueBanDropDownView ()
{
    CGPoint _startPoint;
    CGFloat _oriCenterMinY;
    CGFloat _oriCenterMaxY;
}

@end

@implementation YueBanDropDownView

@synthesize motionItem;
@synthesize envItem;
@synthesize languageItem;
@synthesize followWhoItem;
@synthesize searchButton;
@synthesize createBubbleButton;
@synthesize dropDownImageView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        _oriCenterMinY = frame.origin.y + height/2;;
        _oriCenterMaxY = height/2;
      
        dropDownImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,width,height)];
        [dropDownImageView setImage:[UIImage imageNamed:@"dropdownbkg"]];
        [self addSubview:dropDownImageView];
        
        UIColor *mainColor = [UIColor colorWithRed:214/255.0f green:32/255.0f blue:75/255.0f alpha:1.0f];
        
        motionItem = [[DropDownItemView alloc] initWithFrame:CGRectMake(0,0,width, 72)];
        [motionItem setTitle:@"心情" leftLable:@"悲伤" midLabel:@"平静" rightLabel:@"开心"];
        [self addSubview:motionItem];
        
        envItem = [[DropDownItemView alloc] initWithFrame:CGRectMake(0,72,width, 72)];
        [envItem setTitle:@"环境" leftLable:@"安静" midLabel:@"适宜" rightLabel:@"热闹"];
        [self addSubview:envItem];
        
        languageItem = [[DropDownItemView alloc] initWithFrame:CGRectMake(0,72*2,width,72)];
        [languageItem setTitle:@"流派" leftLable:@"中文" midLabel:@"均可" rightLabel:@"外语"];
        [self addSubview:languageItem];
        
        followWhoItem = [[DropDownItemView alloc] initWithFrame:CGRectMake(0,72*3,width,72)];
        [followWhoItem setTitle:@"听谁" leftLable:@"陌生人" midLabel:@"全部" rightLabel:@"已关注"];
        [self addSubview:followWhoItem];
        
        searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [searchButton setTitle:@"开始搜寻" forState:UIControlStateNormal];
        searchButton.frame = CGRectMake(width/8,300,width/4, 30);
        [searchButton setTintColor:[UIColor whiteColor]];
        [searchButton setBackgroundImage:[UIImage imageNamed:@"buttonbkg"] forState:UIControlStateNormal];
        [searchButton addTarget:[self getViewController] action:@selector(onSearchBubble:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:searchButton];
        
        createBubbleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [createBubbleButton setTitle:@"创建气泡" forState:UIControlStateNormal];
        createBubbleButton.frame = CGRectMake(width - width/8 - width/4,300,width/4, 30);
        createBubbleButton.layer.cornerRadius = 7.0f;
        createBubbleButton.layer.borderColor = mainColor.CGColor;
        createBubbleButton.layer.borderWidth = 2.0f;
        [createBubbleButton setTintColor:mainColor];
        [createBubbleButton addTarget:[self getViewController] action:@selector(onCreateBubble:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:createBubbleButton];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _startPoint = [[touches anyObject] locationInView:self];
    [[self superview] bringSubviewToFront:self];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //计算位移=当前位置-起始位置
    CGPoint point = [[touches anyObject] locationInView:self];
    float dy = point.y - _startPoint.y;
    
    //计算移动后的view中心点
    CGPoint newCenter = CGPointMake(self.center.x, self.center.y + dy);
    if(newCenter.y < _oriCenterMinY){
        newCenter.y = _oriCenterMinY;
    }
    if(newCenter.y > _oriCenterMaxY){
        newCenter.y = _oriCenterMaxY;
    }
    //移动view
    self.center = newCenter;
}

- (UIViewController*)getViewController
{
    id obj = [self nextResponder];
    while(![obj isKindOfClass:[UIViewController class]] && obj !=nil){
        obj = [obj nextResponder];
    }
    return obj;
}

- (void)getMotionValue:(int *)pMotionValue envValue:(int *)pEnvValue langValue:(int *)pLangValue
{
    if(pMotionValue && pEnvValue && pLangValue){
        *pMotionValue = [self.motionItem getSliderValue];
        *pEnvValue = [self.envItem getSliderValue];
        *pLangValue = [self.languageItem getSliderValue];
    }
}

@end
