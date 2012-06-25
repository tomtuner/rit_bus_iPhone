//
//  AppDelegate.h
//  rit_bus
//
//  Created by Thomas DeMeo on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import "NextBusController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSMutableDictionary *allStops;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) NSMutableDictionary *allStops;

- (void) parseAllStops;

@end
