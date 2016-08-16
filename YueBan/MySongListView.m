//
//  MySongListView.m
//  Yueban
//
//  Created by looperwang on 16/8/13.
//  Copyright © 2016年 looperwang. All rights reserved.
//

#import "MySongListView.h"

@implementation MySongListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self constructUIComponents];
        [self addUIComponents];
        
        [self addConstraints:[self constraints]];
        
        //self.backgroundColor = [UIColor colorWithRed:0x8f/255.0 green:0xdc/255.0 blue:0xd4/255.0 alpha:1.0];
        
    }
    
    return self;
}

- (void)constructUIComponents
{
    _songListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _songListView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _generateBubble = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_generateBubble setTitle:@"生成气泡" forState:UIControlStateNormal];
    //[_generateBubble setBackgroundColor:[UIColor orangeColor]];
    _generateBubble.translatesAutoresizingMaskIntoConstraints = NO;
    _generateBubble.tintColor = [UIColor whiteColor];
    _generateBubble.layer.cornerRadius = 8.f;
    _generateBubble.layer.masksToBounds = YES;
}

- (void)addUIComponents
{
    [self addSubview:_songListView];
    [self addSubview:_generateBubble];
}

- (NSArray *)constraints
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_songListView, _generateBubble);
    
    NSString *const horizontal = @"H:|-0-[_songListView]-0-|";
    NSString *const vertical   = @"V:|-0-[_songListView]-0-|";
    
    NSString *const btnVertical = @"V:[_generateBubble]-30-|";
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:horizontal options:0 metrics:nil views:viewDictionary]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:vertical options:0 metrics:nil views:viewDictionary]];
    
    [result addObject:[NSLayoutConstraint constraintWithItem:_generateBubble attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [result addObject:[NSLayoutConstraint constraintWithItem:_generateBubble attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_generateBubble attribute:NSLayoutAttributeWidth multiplier:0.0 constant:35.0]];
    [result addObject:[NSLayoutConstraint constraintWithItem:_generateBubble attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_generateBubble attribute:NSLayoutAttributeHeight multiplier:2.5 constant:0.0]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:btnVertical options:0 metrics:nil views:viewDictionary]];
    //[result addObject:[NSLayoutConstraint constraintWithItem:_generateBubble attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(-44.-35*2.)]];
    
    return [NSArray arrayWithArray:result];
}

@end
