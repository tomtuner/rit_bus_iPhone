//
//  LocationManager.h
//  rit_bus
//
//  Created by Thomas DeMeo on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

static float SIMULATE_LATITUDE  = 43.085;
static float SIMULATE_LONGITUDE = -77.662439;

@interface LocationManager : NSObject <CLLocationManagerDelegate> {
    CLLocationManager * locationManager;
    BOOL locationDefined;
    float latitude;
    float longitude;
    
    BOOL locationDenied;
}

+ (LocationManager *) sharedLocationManager;

- (void) startUpdates;
- (void) stopUpdates;
- (BOOL) locationDefined;
- (BOOL) locationDenied;
- (float) latitude;
- (float) longitude;

- (BOOL) locationServicesEnabled;

@end
