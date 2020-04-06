//
//  AppDelegate.m
//  MusicApp
//
//  Created by wangky on 2019/12/2.
//  Copyright © 2019年 wangky. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DiscoverViewController.h"
#import "MyMusicViewController.h"
#import "LocalViewController.h"

char * host = "http://192.168.1.103:3000";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setWindow:[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds]];
    [self.window makeKeyAndVisible];
    
    UITabBarController *tab = [[UITabBarController alloc] init];
    [self.window setRootViewController:tab];
    
    DiscoverViewController *dicover = [[DiscoverViewController alloc] init];
    [dicover setTitle:@"发现"];
    dicover.tabBarItem.image=[UIImage imageNamed:@"discovery"];
    MyMusicViewController *my = [[MyMusicViewController alloc] init];
    [my setTitle:@"我的音乐"];
    my.tabBarItem.image=[UIImage imageNamed:@"music"];
    LocalViewController *local = [[LocalViewController alloc] init];
    [local setTitle:@"本地音乐"];
    local.tabBarItem.image=[UIImage imageNamed:@"my"];

    tab.viewControllers = @[dicover,my,local];
    
    [self createCacheImageDir];
    
    return YES;
}

/**
 *创建图片缓存目录
 */
-(void)createCacheImageDir{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSLog(@"img cache path %@",path);
    NSString *diskCachePath = [[path objectAtIndex:0 ] stringByAppendingPathComponent:@"imageCache"];
    NSLog(@"diskCachePath:%@",diskCachePath);
   
    if(![[NSFileManager defaultManager]fileExistsAtPath:diskCachePath] ){
       BOOL boo = [[NSFileManager defaultManager] createDirectoryAtPath:diskCachePath withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSLog(@"boo----,%@",boo);
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
