//
//  SongCell.m
//  Yueban
//
//  Created by looperwang on 16/8/12.
//  Copyright © 2016年 looperwang. All rights reserved.
//

#import "SongCell.h"

@implementation SongCell

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0xac/255.0 green:0xac/255.0 blue:0xac/255.0 alpha:1.0].CGColor);
    CGContextStrokeRect(context, CGRectMake(15, rect.size.height, rect.size.width, 1.0 / [UIScreen mainScreen].scale));
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self addUIComponents];
        
        [self.contentView addConstraints:[self constraints]];
        
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:0xee/255.0 green:0xf0/255.0 blue:0xef/255.0 alpha:1.0];
    }
    
    return self;
}

- (UILabel *)songNameLabel
{
    if (!_songNameLabel) {
        _songNameLabel = [[UILabel alloc] init];
        _songNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _songNameLabel.textColor = [UIColor blackColor];
        _songNameLabel.textAlignment = NSTextAlignmentLeft;
        _songNameLabel.font = [UIFont boldSystemFontOfSize:14.f];
        _songNameLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    
    return _songNameLabel;
}

- (UILabel *)singerLabel
{
    if (!_singerLabel) {
        _singerLabel = [[UILabel alloc] init];
        _singerLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _singerLabel.textColor = [UIColor colorWithRed:0xd6/255. green:0x20/255. blue:0x4b/255. alpha:1.0];;
        _singerLabel.textAlignment = NSTextAlignmentLeft;
        _singerLabel.font = [UIFont systemFontOfSize:12.f];
        _singerLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    
    return _singerLabel;
}

//- (UILabel *)scoreLabel
//{
//    if (!_scoreLabel) {
//        _scoreLabel = [[UILabel alloc] init];
//        _scoreLabel.translatesAutoresizingMaskIntoConstraints = NO;
//        _scoreLabel.textColor = [UIColor lightGrayColor];
//        _scoreLabel.textAlignment = NSTextAlignmentLeft;
//        _scoreLabel.font = [UIFont systemFontOfSize:10.f];
//        _scoreLabel.lineBreakMode = NSLineBreakByCharWrapping;
//    }
//    
//    return _scoreLabel;
//}

- (UILabel *)sizeLabel
{
    if (!_sizeLabel) {
        _sizeLabel = [[UILabel alloc] init];
        _sizeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _sizeLabel.textColor = [UIColor lightGrayColor];
        _sizeLabel.textAlignment = NSTextAlignmentLeft;
        _sizeLabel.font = [UIFont systemFontOfSize:11.f];
        _sizeLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    
    return _sizeLabel;
}

- (UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btn.translatesAutoresizingMaskIntoConstraints = NO;
        //[_btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _btn.tintColor = [UIColor lightGrayColor];
        _btn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        _btn.layer.cornerRadius = 15.f;
        _btn.layer.masksToBounds = YES;
        _btn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _btn.layer.borderWidth = .5f;
    }
    
    return _btn;
}

- (void)addUIComponents
{
    [self.contentView addSubview:self.songNameLabel];
    [self.contentView addSubview:self.singerLabel];
//    [self.contentView addSubview:self.scoreLabel];
    [self.contentView addSubview:self.sizeLabel];
    
    [self.contentView addSubview:self.btn];
}

- (NSArray *)constraints
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_songNameLabel, _singerLabel, _sizeLabel, _btn);
    
    NSString *const horizontal = @"H:|-[_songNameLabel]-10-[_singerLabel]-(>=50)-[_btn]-|";
    NSString *const vertical   = @"V:|-[_songNameLabel]-(>=3)-[_sizeLabel]-|";
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:horizontal options:0 metrics:nil views:viewDictionary]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:vertical options:0 metrics:nil views:viewDictionary]];
    
    [result addObject:[NSLayoutConstraint constraintWithItem:_singerLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_songNameLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [result addObject:[NSLayoutConstraint constraintWithItem:_sizeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_songNameLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [result addObject:[NSLayoutConstraint constraintWithItem:_btn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [result addObject:[NSLayoutConstraint constraintWithItem:_btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0.0]];
    [result addObject:[NSLayoutConstraint constraintWithItem:_btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_btn attribute:NSLayoutAttributeHeight multiplier:2.0 constant:0.0]];
    
    return [NSArray arrayWithArray:result];
}

- (void)prepareForReuse
{
    self.songNameLabel.text = nil;
    self.singerLabel.text   = nil;
    self.sizeLabel.text     = nil;
    
    //self.btn.tag = -1;
    [self.btn removeTarget:nil action:nil forControlEvents:UIControlEventTouchDown];
}

@end
