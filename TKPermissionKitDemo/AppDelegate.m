//
//  AppDelegate.m
//  TKPermissionDemo
//
//  Created by mac on 2019/8/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "TKPermissionKit.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self testLang];
    

    
//    TKPermissionPublic.shared.blockCustomMsg = ^(NSString * _Nullable title, NSString * _Nullable msg, NSString * _Nullable left, NSString * _Nullable right) {
//        NSLog(@"title:%@    msg:%@    left:%@     right:%@",title,msg,left,right);
//    };
//    TKPermissionPublic.shared.blockCustomMsg = nil;
    
    return YES;
}


- (void)testLang
{
//    NSLog(@"NSLocale: %@",[NSLocale preferredLanguages]);
//
//    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
//        return [evaluatedObject hasSuffix:@".lproj"];
//    }];
//    NSString *path = TKPermissionPublic.shared.bundlePath;
//    NSArray *subPaths = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil] filteredArrayUsingPredicate:predicate];
//    NSLog(@"ary:%@",subPaths);
//
//    NSString *systemLanguage = [NSLocale preferredLanguages].firstObject.lowercaseString;
//    NSString *selectedLanguage = @"zh-Hans";
//    for (NSString *dirName in subPaths) {
//        NSString *name = [dirName stringByReplacingOccurrencesOfString:@".lproj" withString:@""];
//        NSString *lowerName = [name lowercaseString];
//        if ([lowerName isEqualToString:systemLanguage]) {
//            NSLog(@"name:%@      current:%@",lowerName,systemLanguage);
//            selectedLanguage = name;
//            break;
//        }
//        if ([lowerName containsString:systemLanguage] || [systemLanguage containsString:lowerName]) {
//            NSLog(@"name:%@      current:%@",lowerName,systemLanguage);
//            selectedLanguage = name;
//            break;
//        }
//    }
//
//    NSLog(@"selectedLanguage:%@",selectedLanguage);
    
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
