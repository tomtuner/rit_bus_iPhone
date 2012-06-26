//
//  RITBusCommon.h
//  rit_bus
//
//  Created by Thomas DeMeo on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusStopLocation.h"
#import "BusPoint.h"
#import "AppDelegate.h"

@class BusStopLocation;

@interface RITBusCommon : NSObject {
    NSMutableDictionary *allStops;
}

@property (nonatomic, strong) NSMutableDictionary *allStops;

- (NSMutableDictionary *) returnAllStops;
+ (BusStopLocation *) closestStopFromLatitude: (float) latitude andLongitude: (float) longitude;

@end
