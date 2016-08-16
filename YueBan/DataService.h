//
//  DataService.h
//  Yueban
//
//  Created by looperwang on 16/8/16.
//  Copyright © 2016年 looperwang. All rights reserved.
//

#define SERVER_IP @"10.67.55.60:8080"

#import <Foundation/Foundation.h>

@interface DataService : NSObject

+ (DataService *)getInstance;

- (void)getSongListWithBlock:(void (^)(NSArray *, NSArray *, NSArray *, NSError *))block;

//- (void)createBubbleWithUser:(NSInteger)uid songList:(NSArray *)songs tags:(NSArray *)tags callBack:(void (^)(BOOL, NSError *))block;
- (void)createBubbleWithUser:(NSString *)uid songList:(NSString *)songs tags:(NSString *)tags callBack:(void (^)(BOOL, NSError *))block;

@end
