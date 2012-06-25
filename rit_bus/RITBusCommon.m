//
//  RITBusCommon.m
//  rit_bus
//
//  Created by Thomas DeMeo on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RITBusCommon.h"

@implementation RITBusCommon

@synthesize allStops;

//- (NSMutableDictionary *) returnAllStops {
//    if ([self.allStops count] == 0) {
//        NSDictionary *allBusStops = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"full_list_stops" ofType:@"plist"]] objectForKey:@"full_list"];    
//        if (!allBusStops) {
//            NSLog(@"Resource not found for file: %@", @"full_list_stops.plist");
//        }
//        NSLog(@"Count: %i", [allBusStops count]);
//
//        float latitude;
//        float longitude;
//        NSEnumerator *enumerator = [allBusStops keyEnumerator];
//        id key;
//        BusStopLocation *point;
//        while ((key = [enumerator nextObject])) {
//            NSDictionary *stop = [allBusStops objectForKey:key];
//            NSLog(@"Key: %@", key);
//
//            NSString *title = [stop objectForKey:@"title"];
//            
//            latitude = [[stop objectForKey:@"latitude"] doubleValue];
//            longitude = [[stop  objectForKey:@"longitude"] doubleValue];
//            
//            point = [[BusStopLocation alloc] initWithLatitude:latitude andLongitude:longitude];
//            
//            if (![title isEqualToString:@""]) {
//                NSLog(@"Locaaaaa Title: %@", title);
//                [point setTitle:title];
//            }
//            [self.allStops setObject:point forKey:key];
//        }
//
//    }
//    return (self.allStops);
//}

+ (BusStopLocation *) stopFromLatitude:(float)latitude andLongitude:(float)longitude {

    NSMutableDictionary *stops = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allStops];
;
    
    if ((latitude > 43.078018 && latitude < 43.088009) && (longitude > -77.687959 && longitude < -77.670707)) {
        BusStopLocation *lo = (BusStopLocation *)[stops objectForKey:@"gleason_circle"];
        NSLog(@"Loc Title: %@", [lo title]);
        return lo;
    }
    NSLog(@"No Stop Located");
    return nil;
    
}



@end
