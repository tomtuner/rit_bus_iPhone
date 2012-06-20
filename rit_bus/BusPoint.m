//
//  BusPoint.m
//  rit_bus
//
//  Created by Thomas DeMeo on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BusPoint.h"

@interface BusPoint()


@end

@implementation BusPoint

@synthesize coordinate;
@synthesize title;

- (BusPoint*) initWithCoordinate:(CLLocationCoordinate2D) coordinate {
    self.coordinate = coordinate;
    return [self init];
}

@end
