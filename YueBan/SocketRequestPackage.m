//
//  SocketRequestPackage.m
//  Yueban
//
//  Created by looperwang on 16/8/15.
//  Copyright © 2016年 looperwang. All rights reserved.
//

#import "SocketRequestPackage.h"

@implementation SocketRequestPackage

- (BOOL)isEqual:(id)object
{
    return self.cmdID == ((SocketRequestPackage *)object).cmdID;
}

@end
