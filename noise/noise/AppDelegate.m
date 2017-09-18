//
//  AppDelegate.m
//  noise
//
//  Created by 朱育锋 on 17/8/5.
//  Copyright © 2017年 朱育锋. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "StandardViewController.h"
#import "WaveformTableViewController.h"
#import "MoreViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UITabBarController * con = [[UITabBarController alloc]init];
    
    ViewController * first = [[ViewController alloc]init];
    first.tabBarItem.title = @"测试";
    first.tabBarItem.image = [UIImage imageNamed:@"测试"];
    StandardViewController * second = [[StandardViewController alloc]init];
    second.tabBarItem.title = @"波形图";
    second.tabBarItem.image = [UIImage imageNamed:@"波形图"];
    WaveformTableViewController * third = [[WaveformTableViewController alloc]init];
    third.tabBarItem.title = @"标准";
    third.tabBarItem.image = [UIImage imageNamed:@"销售单"];
    MoreViewController * forth = [[MoreViewController alloc]init];
    forth.tabBarItem.title = @"关于";
    forth.tabBarItem.image = [UIImage imageNamed:@"关于作者"];
    
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:second];
    NSMutableArray * array = [NSMutableArray arrayWithObjects:first,nav,third,forth, nil];
    
    con.viewControllers = array;
    self.window.rootViewController = con;
    return YES;
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
