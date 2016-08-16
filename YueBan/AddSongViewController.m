//
//  AddSongViewController.m
//  Yueban
//
//  Created by looperwang on 16/8/12.
//  Copyright © 2016年 looperwang. All rights reserved.
//

#import "AddSongViewController.h"
#import "SongInfo.h"
#import "DeviceInfo.h"
#import "SongCell.h"
#import "CommonAlertView.h"
#import "MySongListViewController.h"
#import "DataService.h"

@interface AddSongViewController () <UISearchBarDelegate>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (nonatomic, strong) UISearchDisplayController *searchController;
#pragma clang diagnostic pop

@property (nonatomic, strong) NSArray *allSongs;
@property (nonatomic, strong) NSMutableArray *searchResultSongs;

@property (nonatomic, strong) NSArray        *allSongNames;
@property (nonatomic, strong) NSArray        *allSingers;

@property (nonatomic, strong) UIImageView    *loadingImageView;

@property (nonatomic, strong) NSMutableArray *addedSongs;

@property (nonatomic, assign) BOOL isInSearch;

@end

@implementation AddSongViewController

static NSString * const reuseIdentifier = @"SearchSongsCell";

#pragma mark - lazy getter

- (NSMutableArray *)searchResultSongs
{
    if (!_searchResultSongs) _searchResultSongs = [NSMutableArray array];
    
    return _searchResultSongs;
}

- (NSMutableArray *)addedSongs
{
    if (!_addedSongs) _addedSongs = [[NSMutableArray alloc] init];
    
    return _addedSongs;
}

#pragma mark - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    searchBar.placeholder  = @"搜索";
    searchBar.translucent  = NO;
    searchBar.delegate     = self;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        
        searchBar.barTintColor = [UIColor colorWithRed:0xee/255.0 green:0xf0/255.0 blue:0xef/255.0 alpha:1.0];
        //searchBar.tintColor = [UIColor colorWithRed:0x61/255.0 green:0xc4/255.0 blue:0xb0/255.0 alpha:1.0];
        searchBar.tintColor = [UIColor colorWithRed:0xd6/255. green:0x20/255. blue:0x4b/255. alpha:1.0];
    }
    else
    {
        searchBar.tintColor = [UIColor colorWithRed:0xee/255.0 green:0xf0/255.0 blue:0xef/255.0 alpha:1.0];//字体颜色
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UISearchDisplayController *searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
#pragma clang diagnostic pop
    searchController.searchResultsDataSource = self;
    searchController.searchResultsDelegate   = self;
    
    _searchController = searchController;
    self.tableView.tableHeaderView = searchBar;
    
//    for (UIView *view in [self.navigationController.navigationBar subviews]) {
//        
//        if ([view isMemberOfClass:[UIImageView class]]) {
//            ((UIImageView *)view).image = nil;
//        }
//    }
    
    //[[self.navigationController.navigationBar subviews][0] subviews][0] = nil;
    
    [self.tableView registerClass:[SongCell class] forCellReuseIdentifier:reuseIdentifier];
    [_searchController.searchResultsTableView registerClass:[SongCell class] forCellReuseIdentifier:reuseIdentifier];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 56.f;
    self.tableView.backgroundColor = [UIColor colorWithRed:0xee/255.0 green:0xf0/255.0 blue:0xef/255.0 alpha:1.0];
    //self.tableView.backgroundColor = [UIColor whiteColor];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"status_bar"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"添加歌曲";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"已选" style:UIBarButtonItemStylePlain target:self action:@selector(enterMySongList)];
    
    _allSongs = [NSMutableArray array];
    
    _loadingImageView = [[CommonAlertView commonAlertViewObject] showLoadingImageViewAddedTo:self.tableView];
    
    [[DataService getInstance] getSongListWithBlock:^(NSArray *songArr, NSArray *songNameArr, NSArray *singerArr, NSError *error) {
        [_loadingImageView removeFromSuperview];
        _loadingImageView = nil;
        
        if (error)
        {
            [[CommonAlertView commonAlertViewObject] showNetworkErrorHUDAddedTo:self.view.window];
        } else
        {
            self.allSongs = songArr;
            self.allSongNames = songNameArr;
            self.allSingers = singerArr;
            
            [self.tableView reloadData];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)enterMySongList
{
    MySongListViewController *mslvc = [[MySongListViewController alloc] init];
    mslvc.mySongList = self.addedSongs;
    
    [self.navigationController pushViewController:mslvc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    if (tableView != self.tableView) {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.rowHeight = 56;
        tableView.backgroundColor = [UIColor colorWithRed:0xee/255.0 green:0xf0/255.0 blue:0xef/255.0 alpha:1.0];
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    NSInteger result = 0;
    
    if (tableView != self.tableView) {
        
        [self.searchResultSongs removeAllObjects];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@", self.searchController.searchBar.text];
        
        NSArray *searchResult_1 = [self.allSongNames filteredArrayUsingPredicate:predicate];
        NSArray *searchResult_2 = [self.allSingers filteredArrayUsingPredicate:predicate];
        
        if (searchResult_1.count > 0) {
            
            [self.allSongs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                SongInfo *temp = (SongInfo *)obj;
                
                if ([searchResult_1 containsObject:temp.songName]) {
                    
                    [self.searchResultSongs addObject:obj];
                }
            }];
        }
        
        if (searchResult_2.count > 0) {
            
            [self.allSongs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                SongInfo *temp = (SongInfo *)obj;
                
                if ([searchResult_2 containsObject:temp.singer] && ![self.searchResultSongs containsObject:temp]) {
                    
                    [self.searchResultSongs addObject:obj];
                }
            }];
        }
        
        result = self.searchResultSongs.count;
        
    } else
    {
        result = self.allSongs.count;
    }
    
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SongCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    SongInfo *temp = nil;
    
    if (tableView != self.tableView) {
        
        temp = self.searchResultSongs[indexPath.row];
        NSLog(@"222");
    } else
    {
        temp = self.allSongs[indexPath.row];
        NSLog(@"1111111");
    }
    
    cell.songNameLabel.text = temp.songName;
    cell.singerLabel.text   = temp.singer;
    //cell.scoreLabel.text    = [@(temp.score) stringValue];
//    cell.scoreLabel.text    = [NSString stringWithFormat:@"%.1f", temp.score];
    cell.sizeLabel.text     = [NSString stringWithFormat:@"%.2fM", temp.songSize / (1024.f * 1024)];
    cell.btn.tag = indexPath.row;
    [cell.btn setTitle:temp.isChosen ? @"已选" : @"添加" forState:UIControlStateNormal];
    cell.btn.userInteractionEnabled = temp.isChosen ? NO : YES;
    [cell.btn addTarget:self action:@selector(addSong:) forControlEvents:UIControlEventTouchDown];
    
    return cell;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    NSLog(@"searchBarTextDidBeginEditing");
    self.isInSearch = YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidEndEditing");
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    self.isInSearch = NO;
    [self.tableView reloadData];
}

#pragma mark - user action

- (void)addSong:(id)sender
{
    NSLog(@"%d\n", ((UIButton *)sender).tag);
    
    UIButton *btn = (UIButton *)sender;
    
    SongInfo *info = nil;
    
    if (self.isInSearch)
    {
        info = self.searchResultSongs[btn.tag];
        
        if (info.isChosen) NSLog(@"bug!!bug!!bug!!bug!!bug!!bug!!");
    } else
    {
        info = self.allSongs[btn.tag];
        
        if (info.isChosen) NSLog(@"bug!!bug!!bug!!bug!!bug!!bug!!");
    }
    
    [self.addedSongs addObject:info];
    info.isChosen = YES;
    
    [self.tableView reloadData];
    [self.searchController.searchResultsTableView reloadData];
}

@end
