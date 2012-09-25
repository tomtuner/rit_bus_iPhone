//
//  AppDelegate.h
//  TigerBus
//
//  Created by Thomas DeMeo on 9/23/12.
//  Copyright (c) 2012 Thomas DeMeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import "NextBusController.h"
#import "Theme.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSMutableDictionary *allStops;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) NSMutableDictionary *allStops;

- (void) parseAllStops;

@end
