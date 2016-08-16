//
//  BubbleItemView.h
//  YueBan
//
//  Created by nmhuang on 16/8/15.
//  Copyright © 2016年 com.tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BubbleItemView : UIView

@property (nonatomic,strong)UIImageView *bkgImageView;
@property (nonatomic,strong)UIImageView *albumImageView;
@property (nonatomic,strong)UILabel *albumTextLabel;

@property (nonatomic,assign)int bubbleId;

-(void)setActionDelegate:(UIViewController *)vc;
-(void)setBkgImage:(UIImage*)img;
-(void)setAlbumImage:(UIImage *)img;
-(void)setAlbumText:(NSString *)text;

@end
