//
//  SocketRequestPackage.h
//  Yueban
//
//  Created by looperwang on 16/8/15.
//  Copyright © 2016年 looperwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocketRequestPackage : NSObject <NSCopying>

@property (nonatomic, assign) NSInteger cmdID;

@property (nonatomic, strong) NSData *data;

@end
