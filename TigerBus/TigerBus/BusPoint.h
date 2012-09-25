//
//  BusPoint.h
//  rit_bus
//
//  Created by Thomas DeMeo on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface BusPoint : NSObject {
    CLLocationCoordinate2D coordinate;
    NSString *title;
}

@property(nonatomic) CLLocationCoordinate2D coordinate;
@property(nonatomic, strong) NSString *title;

-(BusPoint*) initWithCoordinate:(CLLocationCoordinate2D) coordinate;

@end
