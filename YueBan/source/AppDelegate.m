//
//  AppDelegate.m
//  YueBan
//
//  Created by etund on 16/8/10.
//  Copyright © 2016年 etund. All rights reserved.
//

#import "AppDelegate.h"
#import "YBTabBarController.h"
#import "YBLoginController.h"
#import "YBNavController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.rootViewController = [YBTabBarController tabBarControllerWithTitleArray:@[@"我要当DJ"] andNormalImages:@[@"tabBar_essence_icon"] andSelectedImages:@[@"tabBar_essence_click_icon"] andClassName:@[[YBLoginController class]] withNavigation:[YBNavController class]];
    self.window.rootViewController = [[YBLoginController alloc] init];
    [self.window makeKeyAndVisible];
    [self configreAppearance];
    // Override point for customization after application launch.
    return YES;
}

#pragma mark - 统一设置属性
- (void)configreAppearance{
    UINavigationBar *bar = [UINavigationBar appearance];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14 weight:100];
    [bar setTitleTextAttributes:dict];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    
    NSMutableDictionary *nomalDict = [NSMutableDictionary dictionary];
    nomalDict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    nomalDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectDict = [NSMutableDictionary dictionary];
    selectDict[NSFontAttributeName] = nomalDict[NSFontAttributeName];
    selectDict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:nomalDict forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectDict forState:UIControlStateHighlighted];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
