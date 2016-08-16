//
//  MySongListiewController.h
//  Yueban
//
//  Created by looperwang on 16/8/13.
//  Copyright © 2016年 looperwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySongListViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *mySongList;

@property (nonatomic, weak) UIButton *generateBubble;
@property (nonatomic, weak) UITableView *tableView;

@end
