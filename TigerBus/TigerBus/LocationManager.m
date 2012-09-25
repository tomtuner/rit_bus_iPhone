//
//  LocationManager.m
//  rit_bus
//
//  Created by Thomas DeMeo on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationManager.h"

static LocationManager *globalLocationManager = nil;
static BOOL initialized = NO;

@implementation LocationManager

+ (LocationManager *) sharedLocationManager {
    if (!globalLocationManager) {
        globalLocationManager = [[LocationManager allocWithZone:nil] init];
    }
    
    return globalLocationManager;
}

+ (id) allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (globalLocationManager == nil) {
            globalLocationManager = [super allocWithZone:zone];
        }
    }
    return globalLocationManager;
}

- (id) copyWithZone:(NSZone *)zone {
    return self;
}

- (void) reset {
    locationDefined = NO;
    latitude = 0.f;
    longitude = 0.f;
}

- (id)init
{
    if (initialized) {
        return globalLocationManager;
    }
    self = [super init];
    if (!self) {
        return nil;
    }
    
    locationManager = nil;
    initialized = YES;
    locationDenied = NO;
    [self reset];
    
    return self;
}

- (void) stopUpdates {
    if (locationManager) {
        [locationManager stopUpdatingLocation];
    }
    //    [self reset];
}

- (void) startUpdates {
    
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"UseLocations"]) {
//        [self stopUpdates];
//        return;
//    }
    
    if (locationManager) {
        [locationManager stopUpdatingLocation];
    }else {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = 100;
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    }
    [self reset];
    
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"Running in simulator, simulate Latitude: %f Longitude: %f", SIMULATE_LATITUDE, SIMULATE_LONGITUDE);
    latitude = SIMULATE_LATITUDE;
    longitude = SIMULATE_LONGITUDE;
#else
    [locationManager startUpdatingLocation];
#endif
}

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    locationDenied = NO;
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"UseLocations"]) {
        [self stopUpdates];
        return;
    }
    
    latitude = newLocation.coordinate.latitude;
    longitude = newLocation.coordinate.longitude;
    locationDefined = YES;
    
//    if (!([[NSUserDefaults standardUserDefaults] boolForKey:@"Development"])) {
//        [FlurryAnalytics setLatitude:latitude longitude:longitude horizontalAccuracy:newLocation.horizontalAccuracy verticalAccuracy:newLocation.verticalAccuracy];
//    }
    
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:GMLocationManagerDidUpdateLocationNotification object: nil];
    [self stopUpdates];
}

- (BOOL) locationDenied {
    return locationDenied;
}

- (BOOL) locationServicesEnabled {
    return [CLLocationManager locationServicesEnabled];
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self reset];
    
    if ([error domain] == kCLErrorDomain) {
        switch ([error code]) {
            case kCLErrorDenied:
                locationDenied = YES;
                [self stopUpdates];
                break;
            case kCLErrorLocationUnknown:
                break;
            default:
                break;
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName: @"UpdateLocationNotification" object: nil];
}

- (BOOL) locationDefined {
    return locationDefined;
}

- (float) latitude {
    return latitude;
}

- (float) longitude {
    return longitude;
}
@end
