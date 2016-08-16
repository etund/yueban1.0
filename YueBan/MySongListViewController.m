//
//  MySongListiewController.m
//  Yueban
//
//  Created by looperwang on 16/8/13.
//  Copyright © 2016年 looperwang. All rights reserved.
//

#import "MySongListViewController.h"
#import "SongInfo.h"
#import "SongCell.h"
#import "MySongListView.h"
#import "CommonAlertView.h"

#import "DataService.h"
#import "YBDevice.h"

@interface MySongListViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MySongListViewController

static NSString * const reuseIdentifier = @"SearchSongsCell";

- (NSMutableArray *)mySongList
{
    if (!_mySongList) {
        
        _mySongList = [[NSMutableArray alloc] init];
    }
    
    return _mySongList;
}

- (void)loadView
{
    MySongListView *view = [[MySongListView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MySongListView *view = (MySongListView *)self.view;
    
    self.tableView = view.songListView;
    self.generateBubble = view.generateBubble;
    
    [self.tableView registerClass:[SongCell class] forCellReuseIdentifier:reuseIdentifier];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 56.f;
    self.tableView.backgroundColor = [UIColor colorWithRed:0xee/255.0 green:0xf0/255.0 blue:0xef/255.0 alpha:1.0];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.navigationController.navigationBar.translucent = NO;
    [self.generateBubble setBackgroundImage:[UIImage imageNamed:@"btn_backg"] forState:UIControlStateNormal];
    self.title = @"我的歌单";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addSongs)];
    
    [self.generateBubble addTarget:self action:@selector(bubble) forControlEvents:UIControlEventTouchDown];
    /*
    NSArray *songName = @[@"龙卷风", @"说好的幸福呢", @"爱情废柴", @"青花瓷"];
    NSArray *singers  = @[@"周杰伦", @"周杰伦", @"周杰伦", @"周杰伦"];
    
    SongInfo *songInfo_1 = [[SongInfo alloc] init];
    SongInfo *songInfo_2 = [[SongInfo alloc] init];
    SongInfo *songInfo_3 = [[SongInfo alloc] init];
    SongInfo *songInfo_4 = [[SongInfo alloc] init];
    
    songInfo_1.songID = 1;
    songInfo_2.songID = 2;
    songInfo_3.songID = 3;
    songInfo_4.songID = 4;
    
    songInfo_1.songName = songName[0];
    songInfo_2.songName = songName[1];
    songInfo_3.songName = songName[2];
    songInfo_4.songName = songName[3];
    
    songInfo_1.singer = singers[0];
    songInfo_2.singer = singers[1];
    songInfo_3.singer = singers[2];
    songInfo_4.singer = singers[3];
    
    songInfo_1.songSize = 178323;
    songInfo_2.songSize = 738484;
    songInfo_3.songSize = 32434;
    songInfo_4.songSize = 80939342;
    
    songInfo_1.score = 9.0;
    songInfo_2.score = 8.7;
    songInfo_3.score = 7.4;
    songInfo_4.score = 5.9;
    
    songInfo_1.isChosen = YES;
    songInfo_2.isChosen = NO;
    songInfo_3.isChosen = YES;
    songInfo_4.isChosen = NO;
    
    [self.mySongList addObject:songInfo_1];
    [self.mySongList addObject:songInfo_2];
    [self.mySongList addObject:songInfo_3];
    [self.mySongList addObject:songInfo_4];*/
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addSongs
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return self.mySongList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SongCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    SongInfo *temp = self.mySongList[indexPath.row];
    
    cell.songNameLabel.text = temp.songName;
    cell.singerLabel.text   = temp.singer;
    //cell.scoreLabel.text    = [NSString stringWithFormat:@"%.1f", temp.score];
    cell.sizeLabel.text     = [NSString stringWithFormat:@"%.2fM", temp.songSize / (1024.f * 1024)];
    
    [cell.btn setTitle:@"删除" forState:UIControlStateNormal];
    cell.btn.tag = indexPath.row;
    [cell.btn addTarget:self action:@selector(deleteSong:) forControlEvents:UIControlEventTouchDown];
    
    return cell;
}

#pragma mark - user action

- (void)deleteSong:(id)sender
{
    NSLog(@"%d", ((UIButton *)sender).tag);
    
    UIButton *btn = (UIButton *)sender;
    
    ((SongInfo *)self.mySongList[btn.tag]).isChosen = NO;
    [self.mySongList removeObjectAtIndex:btn.tag];
    
    [self.tableView reloadData];
}

- (void)bubble
{
    if (!self.mySongList.count)
    {
        [[CommonAlertView commonAlertViewObject] showHUDAddedTo:self.view.window withText:@"请先创建歌单"];
        return;
    }
    
    NSMutableString *songList = [[NSMutableString alloc] init];
    
//    for (SongInfo *temp in self.mySongList) {
//        [songList addObject:[NSNumber numberWithInteger:temp.songID]];
//    }
    for (int i = 0; i < self.mySongList.count; i++) {
        [songList appendFormat:@"%d", ((SongInfo *)self.mySongList[i]).songID];
        if (i != self.mySongList.count - 1) [songList appendString:@","];
    }
    
    NSMutableString *tags = [[NSMutableString alloc] init];
    YBDevice *info = [YBDevice sharedDevice];
    
    [tags appendFormat:@"%d,", info.motionValue];
    [tags appendFormat:@"%d,", info.envValue];
    [tags appendFormat:@"%d", info.langValue];
    
#warning 修改参数
    [[DataService getInstance] createBubbleWithUser:[YBDevice sharedDevice].uuid songList:songList tags:@"1,1,1" callBack:^(BOOL success, NSError *error) {
        if (error || !success)
        {
            [[CommonAlertView commonAlertViewObject] showHUDAddedTo:self.view.window withText:@"创建气泡失败，请稍后再试"];
        } else
        {
            //成功之后
            //info.songList = self.mySongList;
            
            //[self.navigationController popToRootViewControllerAnimated:YES];
            NSDictionary *dic = @{@"info" : self.mySongList};
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_CREATE_BUBBLE" object:nil userInfo:dic];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}

@end
