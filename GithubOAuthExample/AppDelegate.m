//
//  AppDelegate.m
//  GithubOAuthExample
//
//  Created by yaakaito on 12/09/01.
//  Copyright (c) 2012年 yaakaito. All rights reserved.
//

#import "AppDelegate.h"
#import "OAuth.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if(!((OAuth*)[OAuth sharedObject]).enable) {
        abort();
    }
    
    ((OAuth*)[OAuth sharedObject]).enable = NO;
    NSLog(@"%@", [url absoluteString]);
    NSArray *queryComponents = [[url query] componentsSeparatedByString:@"&"];
    NSMutableDictionary *queries = [NSMutableDictionary dictionary];
    for (NSString *component in queryComponents) {
        NSArray *kv = [component componentsSeparatedByString:@"="];
        [queries setObject:[kv objectAtIndex:1] forKey:[kv objectAtIndex:0]];
    }
    [((OAuth*)[OAuth sharedObject]) oauthWithCode:[queries objectForKey:@"code"] state:[queries objectForKey:@"state"]];
    return YES;
}

@end
