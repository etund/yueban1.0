//
//  SongInfo.h
//  Yueban
//
//  Created by looperwang on 16/8/12.
//  Copyright © 2016年 looperwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongInfo : NSObject <NSCopying>

@property (nonatomic)         NSUInteger songID;
@property (nonatomic, strong) NSString   *songName;
@property (nonatomic, strong) NSString   *singer;
@property (nonatomic)         NSUInteger songSize; //字节为单位
@property (nonatomic)         float      score;
@property (nonatomic, strong) NSString   *songURL;

@property (nonatomic)         BOOL       isChosen;

@end
