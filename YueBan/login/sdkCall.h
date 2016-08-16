//
//  sdkCall.h
//  sdkDemo
//
//  Created by xiaolongzhang on 13-3-29.
//  Copyright (c) 2013年 xiaolongzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TencentOAuth.h"
#import "TencentOAuthObject.h"
#import "sdkDef.h"

@interface sdkCall : NSObject<TencentSessionDelegate, TCAPIRequestDelegate>
+ (sdkCall *)getinstance;
+ (void)resetSDK;

+ (void)showInvalidTokenOrOpenIDMessage;
@property (nonatomic, retain)TencentOAuth *oauth;
@property (nonatomic, retain)NSMutableArray* photos;
@property (nonatomic, retain)NSMutableArray* thumbPhotos;
@end
