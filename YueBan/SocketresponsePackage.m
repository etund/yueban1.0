//
//  SocketresponsePackage.m
//  Yueban
//
//  Created by looperwang on 16/8/15.
//  Copyright © 2016年 looperwang. All rights reserved.
//

#import "SocketresponsePackage.h"

@implementation SocketresponsePackage

- (instancetype)init
{
    if (self = [super init])
    {
        self.data = [[NSMutableData alloc] init];
    }
    
    return self;
}

@end
