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
@synthesize destinationLocations;

- (id) initWithLatitude:(float)lat andLongitude:(float)lng {
    self = [super init];
    if (self) {
        latitude = lat;
        longitude = lng;
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

- (void) calculateNextFiveStopTimes
{
    [self convertTitleToKey];
    
    self.nextFiveStopTimes = [NSMutableArray array];
    
    
    NSArray *times = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_times", self.key] ofType:@"plist"]];
    if (!times) {
        NSLog(@"Resource not found for file: %@_times", self.key);
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    [formatter setDateFormat:@"HH:mm:ss"];
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone localTimeZone] secondsFromGMT]];
    
    NSDate *formattedCurrentDate = [formatter dateFromString:[formatter stringFromDate:currentDate]];
    
    int count = 0;
    for (NSString *stopDate in times) {
        NSDate *stopTime = [formatter dateFromString:stopDate];
        NSLog(@"Stop Time: %@", stopTime);
        NSLog(@"Curent Time Date: %@", formattedCurrentDate);
        if ([stopTime compare:formattedCurrentDate] == NSOrderedDescending) {
            NSLog(@"Descending");
            NSLog(@"Next Stop Time: %@", stopTime);
            [self.nextFiveStopTimes addObject: stopTime];
            count++;
            if (count > 4) {
                break;
            }
        }
    }
    NSLog(@"Num in array: %d", [self.nextFiveStopTimes count]);
    
}

- (void) convertTitleToKey
{
    if ([self.title isEqualToString:@"Barnes and Nobles"]) {
        self.key = @"barnes_nobles";
    }else if ([self.title isEqualToString:@"Park Point South"]) {
        self.key = @"park_point_south";
    }else if([self.title isEqualToString:@"Park Point North"]) {
        self.key = @"park_point_north";
    }else if ([self.title isEqualToString:@"Lot K"]) {
        self.key = @"lot_k";
    }else if ([self.title isEqualToString:@"Residence Halls"]) {
        self.key = @"residence_halls";
    }else if ([self.title isEqualToString:@"Gleason Circle"]) {
        self.key = @"gleason_circle";
    }    
}

@end
