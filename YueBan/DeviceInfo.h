//
//  SongInfo.h
//  Yueban
//
//  Created by looperwang on 16/8/12.
//  Copyright © 2016年 looperwang. All rights reserved.
//

#ifndef Kinder_seniority_DeviceInfo_h
#define Kinder_seniority_DeviceInfo_h

#ifndef __IOS_SYSTEM_VERSION_
#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#endif //__IOS_SYSTEM_VERSION_

#ifndef __DEVICE_SCREEN_SIZE_
#define SCREEN_SIZE_IS_IPHONE4S ((([[UIScreen mainScreen] bounds].size.width-320) ? NO : YES) && (([[UIScreen mainScreen] bounds].size.height-480) ? NO : YES))

#define SCREEN_SIZE_IS_IPHONE5C_OR_IPHONE5_OR_IPHONE5S ((([[UIScreen mainScreen] bounds].size.width-320) ? NO : YES) && (([[UIScreen mainScreen] bounds].size.height-568) ? NO : YES))

#define SCREEN_SIZE_IS_IPHONE6 ((([[UIScreen mainScreen] bounds].size.width-375) ? NO : YES) && (([[UIScreen mainScreen] bounds].size.height-667) ? NO : YES))

#define SCREEN_SIZE_IS_IPHONE6P ((([[UIScreen mainScreen] bounds].size.width-414) ? NO : YES) && (([[UIScreen mainScreen] bounds].size.height-736) ? NO : YES))
#endif //__DEVICE_SCREEN_SIZE_

#ifndef __DEVICE_SCREEN_WIDTH_AND_HEIGHT_
#define IPHONE4S_WIDTH 320
#define IPHONE4S_HEIGHT 480
#define IPHONE5X_WIDTH 320
#define IPHONE5X_HEIGHT 568
#define IPHONE6_WIDTH 375
#define IPHONE6_HEIGHT 667
#define IPHONE6P_WIDTH 414
#define IPHONE6P_HEIGHT 736
#endif//__DEVICE_SCREEN_WIDTH_AND_HEIGHT_

#endif
