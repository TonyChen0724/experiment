/**
 Cosc345 Asn 2, AppDelegate.mm
 purpose: specify the database we use and solve the app sandbox problem.
 
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

#import "AppDelegate.h"
#import "stdio.h"
#import "stdlib.h"
#import "sqlite_operations.hpp"
#import "string"

#import <UserNotifications/UNUserNotificationCenter.h>
#import <UserNotifications/UNNotificationCategory.h>
#import <UserNotifications/UNNotificationAction.h>

using namespace std;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSString *dbFilePathInDocDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"finaldb.db"];
    NSLog(@"%@", dbFilePathInDocDir);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbFilePathInDocDir]) {
        NSData *dbData = [[[NSDataAsset alloc] initWithName:@"recentData"] data];
        BOOL res = [dbData writeToFile:dbFilePathInDocDir atomically:YES];
        if (res) {
            NSLog(@"First time initiation. Database file extraction confirmed");
        } else {
            NSLog(@"First time initiation. Failure during database file extraction. Exiting.");
            exit(1);
        }
    }
     
    sqlite3_open([dbFilePathInDocDir cStringUsingEncoding:NSASCIIStringEncoding], &db);
    
    /*UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
        NSLog(@"Granted: %d", granted);
    }];
    UNNotificationAction* checkAction = [UNNotificationAction actionWithIdentifier:@"CHECK_ACTION" title:@"Check" options:UNNotificationActionOptionForeground];
    UNNotificationCategory* deadCat = [UNNotificationCategory categoryWithIdentifier:@"DEADLINE_APPROACHING" actions:@[] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    [center setNotificationCategories:[NSSet setWithObjects:deadCat, nil]];
    */
    return YES;
}

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:( UIUserNotificationSettings *)notificationSettings {
    
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
