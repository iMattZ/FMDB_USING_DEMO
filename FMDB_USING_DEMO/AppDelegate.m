//
//  AppDelegate.m
//  FMDB_USING_DEMO
//
//  Created by matt on 2019/9/4.
//  Copyright © 2019 com.hime. All rights reserved.
//

#import "AppDelegate.h"
#import "PersonViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    PersonViewController *FMVc = [[PersonViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:FMVc];
    
    self.window.rootViewController = navController;
    
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}



@end
