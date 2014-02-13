//
//  AppDelegate.m
//  tuvi
//
//  Created by DuongND on 1/21/14.
//  Copyright (c) 2014 DuongNguyen. All rights reserved.
//

#import "AppDelegate.h"
#import "IIViewDeckController.h"
// 124!
// 123 !!
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self createCopyOfDatabaseIfNeeded];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    
    UIViewController* menuController = [mainStoryboard instantiateViewControllerWithIdentifier:@"leftVC"];
    
    UINavigationController* navigationController = (UINavigationController *) self.window.rootViewController;
    
    IIViewDeckController* viewDeckController =  [[IIViewDeckController alloc] initWithCenterViewController:navigationController
                                                                                        leftViewController:menuController
                                                                                       rightViewController:nil];
    
    self.window.rootViewController = viewDeckController;
    return YES;
}

// Function to Create a writable copy of the bundled default database in the application Documents directory.
- (void)createCopyOfDatabaseIfNeeded {
    // First, test for existence.
    @try {
        
        BOOL success;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        // Database filename can have extension db/sqlite.
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *appDBPath = [documentsDirectory stringByAppendingPathComponent:@"tuvi2014-db-main.sqlite"];
        
        success = [fileManager fileExistsAtPath:appDBPath];
        if (success){
            return;
        }
        // The writable database does not exist, so copy the default to the appropriate location.
        
        
        
        //NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"tuvi2014-db-main.sqlite"];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"tuvi2014-db-main" ofType:@"sqlite"];
        
        if (![fileManager fileExistsAtPath:filePath])  {
            NSLog(@"file doesn't exist");
            // file doesn't exist
        } else {
            NSLog(@"file exist");
        }
        
        success = [fileManager copyItemAtPath:filePath toPath:appDBPath error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
        }
        if (![fileManager fileExistsAtPath:appDBPath])  {
            NSLog(@"file doesn't exist");
            // file doesn't exist
        } else {
            NSLog(@"file exist");
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    }
    @finally {
        
    }
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

@end
