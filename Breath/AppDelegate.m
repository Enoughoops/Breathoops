//
//  AppDelegate.m
//  Breath
//
//  Created by LinMo on 2018/1/5.
//  Copyright © 2018年 LinMo. All rights reserved.
//

#import "AppDelegate.h"
#import "BNRWebViewController.h"
#import "ENHCollectionViewController.h"

#import "ENHPinsiteStore.h"

#import "BNRTransitionPush.h"

@interface AppDelegate () <UINavigationControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    ENHCollectionViewController *cvc = [[ENHCollectionViewController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:cvc];
    
    self.window.rootViewController = nav;
    
//    BNRWebViewController *wvc = [[BNRWebViewController alloc]init];
//
//    self.window.rootViewController = wvc;
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
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
    //获取共享的UserDefaults

    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.enoughoops.Breath"];
    [userDefaults synchronize];
//    if ([userDefaults boolForKey:@"has-new-share"]) {
//        NSLog(@"崭新的分享 : %@", [userDefaults valueForKey:@"share-url"]);
//    }
//    userDefaults = nil;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
//    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.enoughoops.Breath"];
//    BOOL newShare = [userDefaults boolForKey:@"has-new-share"];
//
//    NSLog(@"新的分享 : %@", [userDefaults valueForKey:@"share-url"]);
//
//
//    UINavigationController * nvc = (UINavigationController *)self.window.rootViewController;
//    if ([nvc.topViewController isKindOfClass:[BNRWebViewController class]]) {
//        BNRWebViewController *wvc = (BNRWebViewController *)nvc.topViewController;
//        wvc.URL = [NSURL URLWithString:[userDefaults valueForKey:@"share-url"]];
//    } else {
//        BNRWebViewController *webViewController = [[BNRWebViewController alloc]init];
//        webViewController.URL = [NSURL URLWithString:[userDefaults valueForKey:@"share-url"]];
//        [(UINavigationController *)self.window.rootViewController pushViewController:webViewController animated:YES];
//    }
//    [[ENHPinsiteStore sharedStore]addReadyPinsiteWithURL:[NSURL URLWithString:[userDefaults valueForKey:@"share-url"]]];
    
    
//       NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.enoughoops.Breath"];
//
//       BOOL newShare = [userDefaults boolForKey:@"has-new-share"];
//
//        if ([userDefaults boolForKey:@"has-new-share"]) {
//            NSLog(@"崭新的分享 : %@", [userDefaults valueForKey:@"share-url"]);
//        }
//        userDefaults = nil;
    
 }


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//safari通过extension的(openUrl:)进入app的handler
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL*)url
{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.enoughoops.Breath"];
    
    [userDefaults synchronize];

    BOOL newShare = [userDefaults boolForKey:@"has-new-share"];
    
    NSLog(@"新的分享 : %@", [userDefaults valueForKey:@"share-url"]);


    UINavigationController * nvc = (UINavigationController *)self.window.rootViewController;
    if ([nvc.topViewController isKindOfClass:[BNRWebViewController class]]) {
        BNRWebViewController *wvc = (BNRWebViewController *)nvc.topViewController;
        wvc.URL = [NSURL URLWithString:[userDefaults valueForKey:@"share-url"]];
    } else {
        BNRWebViewController *webViewController = [[BNRWebViewController alloc]init];
        webViewController.URL = [NSURL URLWithString:[userDefaults valueForKey:@"share-url"]];
        [(UINavigationController *)self.window.rootViewController pushViewController:webViewController animated:YES];
    }
    [[ENHPinsiteStore sharedStore]addReadyPinsiteWithURL:[NSURL URLWithString:[userDefaults valueForKey:@"share-url"]]];

//    userDefaults = nil;

    return YES;
}

#pragma mark <UINavigationControllerDelegate>

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (fromVC == self && [toVC isKindOfClass:[BNRWebViewController class]]) {
        return [[BNRTransitionPush alloc]init];
    }
    else {
        return nil;
    }
}

@end
