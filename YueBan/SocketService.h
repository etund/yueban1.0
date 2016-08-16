//
//  SocketService.h
//  Yueban
//
//  Created by looperwang on 16/8/15.
//  Copyright © 2016年 looperwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocketService : NSObject

@property (nonatomic, strong) NSString *serverAddr;
@property (nonatomic)         int32_t  *serverPort;

+ (SocketService *)getInstance;

- (void)connectToServer;

- (void)getAllSongsInfoWithBlockWithBlock:(void (^)(NSArray *songsArr, NSError *error))block;

- (void)writeTest;

@end
