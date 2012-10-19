//
//  BusStopLocation.h
//  rit_bus
//
//  Created by Thomas DeMeo on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RITBusCommon.h"

typedef enum {
    TBBusKeyGleasonCircle = 0,
    TBBusKeyParkPointNorth,
    TBBusKeyParkPointSouth,
    TBBusKeyBarnesAndNobles,
    TBBusKeyLotK,
    TBBusKeyResidenceHalls
} TBBusKey;

@interface BusStopLocation : NSObject {
    float latitude;
    float longitude;
    NSString *title;
    NSString *description;
    NSMutableArray *destinationLocations;
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *routeIdentifier;
@property (nonatomic, strong) NSMutableArray *destinationLocations;
@property (nonatomic, strong) NSDate *nextArrivalTime;
@property (nonatomic, strong) NSMutableArray *nextFiveStopTimes;
@property (nonatomic) BOOL pastLastStopTime;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;

- (id) initWithLatitude:(float) lat andLongitude: (float) lng;

- (void) setLatitude:(float) lat;
- (void) setLongitude:(float) lng;
- (void) calculateNextFiveStopTimes;

@end