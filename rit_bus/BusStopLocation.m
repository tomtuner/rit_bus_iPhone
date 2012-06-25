//
//  BusStopLocation.m
//  rit_bus
//
//  Created by Thomas DeMeo on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BusStopLocation.h"

@interface BusStopLocation() {
    
}

@end

@implementation BusStopLocation

@synthesize title;
@synthesize description;

- (id) initWithLatitude:(float)lat andLongitude:(float)lng {
    self = [super init];
    if (self) {
        latitude = lat;
        lng = longitude;
    }
    return self;
}

- (float) latitude {
    return self.latitude;
}

- (float) longitude {
    return self.longitude;
}

- (void) setLatitude:(float) lat {
    self.latitude = lat;
}

- (void) setLongitude:(float) lng {
    self.longitude = lng;
}

@end
