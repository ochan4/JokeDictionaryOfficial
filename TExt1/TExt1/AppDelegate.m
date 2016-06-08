//
//  AppDelegate.m
//  TExt1
//
//  Created by 路人甲 on 16/6/6.
//  Copyright © 2016年 路人甲. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ImageViewController.h"
#import "SettingsViewController.h"
#import "EATheme.h"
#import <BmobSDK/Bmob.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    //注册Bmob
    [Bmob registerWithAppKey:@"2c335ee118f48786edce637e8432bf9e"];
    
    ViewController *vc = [ViewController new];
    vc.title = @"段子";
    
    ImageViewController *ivc = [ImageViewController new];
    ivc.title = @"趣图";
    
    SettingsViewController *svc = [SettingsViewController new];
    svc.title = @"个人";
    
    UITabBarController *tabbar = [UITabBarController new];
    
    [tabbar addChildViewController:[[UINavigationController alloc]initWithRootViewController:vc]];
    [tabbar addChildViewController:[[UINavigationController alloc]initWithRootViewController:ivc]];
    [tabbar addChildViewController:[[UINavigationController alloc]initWithRootViewController:svc]];
    
    self.window.rootViewController = tabbar;
    
    if ([BmobUser getCurrentUser]==nil){
        NSLog(@"空对象");
    }else{
        NSLog(@"有对象");
        NSLog(@"%@",[BmobUser getCurrentUser]);
    }
    
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
