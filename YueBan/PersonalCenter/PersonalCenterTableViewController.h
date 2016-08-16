//
//  PersonalCenterTableViewController.h
//  musicplayer
//
//  Created by nmhuang on 16/8/11.
//  Copyright © 2016年 com.tencent.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalCenterHeadView.h"

@interface PersonalCenterTableViewController : UITableViewController

@property (nonatomic,strong)PersonalCenterHeadView *personalCenterHeadView;
@property (nonatomic,strong)NSArray *bubbleLists;

@end
