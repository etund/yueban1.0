//
//  YBProtocol.h
//  YueBan
//
//  Created by nmhuang on 16/8/15.
//  Copyright © 2016年 com.tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBProtocol : NSObject

+ (NSArray *)decode:(NSData *)data;
+ (NSData *)encode:(NSArray *)data;

@end
