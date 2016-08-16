//
//  SongCell.h
//  Yueban
//
//  Created by looperwang on 16/8/12.
//  Copyright © 2016年 looperwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongCell : UITableViewCell

@property (nonatomic, strong) UILabel  *songNameLabel;
@property (nonatomic, strong) UILabel  *singerLabel;
@property (nonatomic, strong) UILabel  *sizeLabel;
//@property (nonatomic, strong) UILabel  *scoreLabel;
@property (nonatomic, strong) UIButton *btn;

@end
