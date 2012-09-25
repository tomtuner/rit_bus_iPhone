//
//  AppDelegate.m
//  TigerBus
//
//  Created by Thomas DeMeo on 9/23/12.
//  Copyright (c) 2012 Thomas DeMeo. All rights reserved.
//

#import "AppDelegate.h"

#import "MasterViewController.h"

@implementation AppDelegate

@synthesize allStops;

@synthesize window = _window;
@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NextBusController *nextBusController = [[NextBusController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:nextBusController];
    
    // Set all of the appearance customizations for the app
    [ThemeManager customizeAppAppearance];
    
    [[LocationManager sharedLocationManager] startUpdates];
    
//    [self parseAllStops];
    
    self.window.rootViewController = self.navigationController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

//- (void) parseAllStops {
//    NSDictionary *allBusStops = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"full_list_stops" ofType:@"plist"]] objectForKey:@"full_list"];
//    if (!allBusStops) {
//        NSLog(@"Resource not found for file: %@", @"full_list_stops.plist");
//    }
//    NSLog(@"Count: %i", [allBusStops count]);
//    
//    allStops = [NSMutableDictionary dictionary];
//    
//    float latitude;
//    float longitude;
//    NSEnumerator *enumerator = [allBusStops keyEnumerator];
//    id key;
//    BusStopLocation *point;
//    while ((key = [enumerator nextObject])) {
//        NSDictionary *stop = [allBusStops objectForKey:key];
//        NSLog(@"Key: %@", key);
//        
//        NSString *title = [stop objectForKey:@"title"];
//        
//        latitude = [[stop objectForKey:@"latitude"] doubleValue];
//        longitude = [[stop  objectForKey:@"longitude"] doubleValue];
//        
//        point = [[BusStopLocation alloc] initWithLatitude:latitude andLongitude:longitude];
//        
//        if (![title isEqualToString:@""]) {
//            NSLog(@"Locaaaaa Title: %@", title);
//            [point setTitle:title];
//        }
//        [allStops setObject:point forKey:key];
//    }
//    
//}


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
