//
//  BusStopLocation.h
//  rit_bus
//
//  Created by Thomas DeMeo on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RITBusCommon.h"

@interface BusStopLocation : NSObject {
    float latitude;
    float longitude;
    NSString *title;
    NSString *description;
    NSArray *destinationLocations;
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSArray *destinationLocations;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;

- (id) initWithLatitude:(float) lat andLongitude: (float) lng;

- (void) setLatitude:(float) lat;
- (void) setLongitude:(float) lng;

@end