//
//  PersonalCenterTableViewController.m
//  musicplayer
//
//  Created by nmhuang on 16/8/11.
//  Copyright © 2016年 com.tencent.test. All rights reserved.
//

#import "PersonalCenterTableViewController.h"
#import "PersonalCenterBubbleTableViewCell.h"

static NSString *g_reuseIndetifier = @"personalCenterTableViewCell";

@interface PersonalCenterTableViewController ()

@end

@implementation PersonalCenterTableViewController

@synthesize personalCenterHeadView;
@synthesize bubbleLists;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[PersonalCenterBubbleTableViewCell class] forCellReuseIdentifier:g_reuseIndetifier];
    self.tableView.separatorStyle = NO;
    
    personalCenterHeadView = [[PersonalCenterHeadView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height/3)];
    [self.tableView setTableHeaderView:personalCenterHeadView];
    [personalCenterHeadView setUserIcon:[UIImage imageNamed:@"贺敬轩 - 我决定不爱了 (《我的六次元男友》电影主题曲)"] userName:@"乐伴" fansNumber:2324234];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSString *path=[[NSBundle mainBundle]pathForResource:@"bubbleLists" ofType:@"plist"];
    bubbleLists = [NSArray arrayWithContentsOfFile:path];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    int rows = 0;
    if(section == 0){
        rows = 0;
    }
    else if(section == 1){
        rows = 1;
    }
    else{
        rows = 5;
    }
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonalCenterBubbleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:g_reuseIndetifier forIndexPath:indexPath];
    if(indexPath.section == 1){
        [cell setCellText:bubbleLists[0] tailImage:[UIImage imageNamed:@"play"]];
    }else{
         [cell setCellText:bubbleLists[indexPath.row + 1] tailImage:[UIImage imageNamed:@"play"]];
    }
   
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 1){
        return @"当前气泡";
    }
    else if(section == 2){
        return @"历史气泡";
    }
    return nil;
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
