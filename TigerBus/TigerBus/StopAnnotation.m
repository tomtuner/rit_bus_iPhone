//
//  StopAnnotation.m
//  rit_bus
//
//  Created by Thomas DeMeo on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StopAnnotation.h"

@implementation StopAnnotation

@synthesize subtitle;
@synthesize title;
@synthesize coordinate;

- (id) initWithCoordinate:(CLLocationCoordinate2D)location placeName:(NSString *)placeName description:(NSString *)description {
    self = [super init];
    if (self) {
        coordinate = location;
        title = placeName;
        subtitle = description;
    }
    return self;
}

- (NSString *)reuseIdentifier
{
    return @"StopAnnotation";
}

@end
