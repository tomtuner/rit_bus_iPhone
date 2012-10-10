//
//  RITBusCommon.m
//  rit_bus
//
//  Created by Thomas DeMeo on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RITBusCommon.h"

@interface RITBusCommon()

+ (BOOL) pointInPolygonWithNumberOfCorners: (int) polySides fromLatitude: (float) x andLongitude: (float) y
                              usingXPoints: (float[]) polyX andYPoints: (float[]) polyY;
+ (BOOL) pointInTriangleWithOriginX: (float) xOrigin andYOrigin: (float) yOrigin withXPoints: (float[]) polyX andYPoints: (float[]) polyY
                     usingLatitude :(float) lat andLongitude: (float) lng;

+ (BOOL) withinProvinceBoxesWithLatitude:(float)latitude andLongitude:(float)longitude;

@end

static RITBusCommon *globalBusManager = nil;

@implementation RITBusCommon

@synthesize allStops;

+ (RITBusCommon *) sharedBusManager {
    if (!globalBusManager) {
        globalBusManager = [[RITBusCommon alloc] init];
    }
    return globalBusManager;
}

- (NSMutableDictionary *) returnAllStops {
    if ([self.allStops count] == 0) {
        NSDictionary *allBusStops = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"full_list_stops" ofType:@"plist"]] objectForKey:@"full_list"];
        if (!allBusStops) {
            NSLog(@"Resource not found for file: %@", @"full_list_stops.plist");
        }
        NSLog(@"Number of Stops: %i", [allBusStops count]);

        self.allStops = [NSMutableDictionary dictionary];
        
        
        NSEnumerator *enumerator = [allBusStops keyEnumerator];
        id key;
        BusStopLocation *point;
        
        // TODO: Put In Helper Method
        
        while ((key = [enumerator nextObject])) {
            NSDictionary *stop = [allBusStops objectForKey:key];
            float latitude;
            float longitude;
            latitude = [[stop objectForKey:@"latitude"] doubleValue];
            longitude = [[stop  objectForKey:@"longitude"] doubleValue];
            
            point = [[BusStopLocation alloc] initWithLatitude:latitude andLongitude:longitude];
            point.destinationLocations = [NSMutableArray array];
            
            NSString *title = [stop objectForKey:@"title"];
            
            NSArray *stops = [stop objectForKey:@"stops"];
            for (NSDictionary *stopInfo in stops) {
                BusStopLocation *tempStop;
                latitude = [[stopInfo objectForKey:@"latitude"] doubleValue];
                longitude = [[stopInfo objectForKey:@"longitude"] doubleValue];
                tempStop = [[BusStopLocation alloc] initWithLatitude:latitude andLongitude:longitude];
                tempStop.title = [stopInfo objectForKey:@"title"];
                [point.destinationLocations addObject:tempStop];
            }

            
            NSArray *times = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_times", key] ofType:@"plist"]];
            if (!times) {
                NSLog(@"Resource not found for file: %@_times", key);
            }
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
            [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
            
            [formatter setDateFormat:@"HH:mm:ss"];
            NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone localTimeZone] secondsFromGMT]];
            
            NSDate *formattedCurrentDate = [formatter dateFromString:[formatter stringFromDate:currentDate]];
            
            for (NSString *stopDate in times) {
                NSDate *stopTime = [formatter dateFromString:stopDate];
                NSLog(@"Stop Time: %@", stopTime);
                NSLog(@"Curent Time Date: %@", formattedCurrentDate);
                if ([stopTime compare:formattedCurrentDate] == NSOrderedDescending) {
                    NSLog(@"Descending");
                    NSLog(@"Next Stop Time: %@", stopTime);
                    point.nextArrivalTime = stopTime;
                    break;
                }
                
            }
            

            if (![title isEqualToString:@""]) {
                [point setTitle:title];
            }

            
            
            if (point.nextArrivalTime == nil) {
                point.nextArrivalTime = [formatter dateFromString:[times objectAtIndex:0]];
                point.pastLastStopTime = YES;
            }
            
            [self.allStops setObject:point forKey:key];
        }

    }
    return (self.allStops);
}

+ (NSInteger) timeFromCurrentTimeInMinutesToDate:(NSDate *) otherDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    [formatter setDateFormat:@"HH:mm:ss"];
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone localTimeZone] secondsFromGMT]];
    
    NSDate *formattedCurrentDate = [formatter dateFromString:[formatter stringFromDate:currentDate]];
    
    NSTimeInterval distanceBetweenDates = [otherDate timeIntervalSinceDate:formattedCurrentDate];
    double secondsInAnMinute = 60;
    NSInteger minutesBetweenDates = distanceBetweenDates / secondsInAnMinute;
    
    NSLog(@"Number of Minutes between dates: %d", minutesBetweenDates);
    return minutesBetweenDates;
}

+ (NSString *) hoursMinutesSecondsStringFromDate:(NSDate *) otherDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    [formatter setDateFormat:@"h:mm a"];
    return [formatter stringFromDate:otherDate];
}

+ (BOOL) withinProvinceBoxesWithLatitude:(float)latitude andLongitude:(float)longitude {
    
    NSDictionary *provinceGeoBoxes = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"province_geo_boxes" ofType:@"plist"]] objectForKey:@"province_geo_boxes"];    
    if (!provinceGeoBoxes) {
        NSLog(@"Resource not found for file: %@", @"province_geo_boxes.plist");
    }
    
    NSEnumerator *enumerator = [provinceGeoBoxes keyEnumerator];
    id key;
    
    while ((key = [enumerator nextObject])) {
        NSDictionary *geoBox = [provinceGeoBoxes objectForKey:key];
        float minLat = [[geoBox objectForKey:@"minLat"] floatValue];
        float maxLat = [[geoBox objectForKey:@"maxLat"] floatValue];
        float minLong = [[geoBox objectForKey:@"minLong"] floatValue];
        float maxLong = [[geoBox objectForKey:@"maxLong"] floatValue];
        
        

        if ((latitude < maxLat) && (latitude > minLat) && (longitude > minLong) && (longitude < maxLong)) {
            return YES;
        }
    }
    return NO;
}


+ (BusStopLocation *) closestStopFromLatitude:(float)latitude andLongitude:(float)longitude {

    NSMutableDictionary *stops = [[RITBusCommon sharedBusManager] returnAllStops];
;
    
    NSDate *today = [[NSDate alloc] init];
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit
                                                       fromDate:today];
    
    // Should create helper methods for all of these calculations
    
//    if ((latitude > 43.078018 && latitude < 43.088009) && (longitude > -77.687959 && longitude < -77.670707)) {
//        BusStopLocation *lo = (BusStopLocation *)[stops objectForKey:@"gleason_circle"];
//        NSLog(@"Loc Title: %@", [lo title]);
//        return lo;
//    }else
    if ((latitude > 43.078825 && latitude < 43.084869) && (longitude > -77.67119 && longitude < -77.665461)) {
        BusStopLocation *lo = (BusStopLocation *)[stops objectForKey:@"residence_halls"];
        NSLog(@"Loc Title: %@", [lo title]);
        return lo;
    }else if ((latitude > 43.084869 && latitude < 43.090249) && (longitude > -77.67119 && longitude < -77.664002)) {
        BusStopLocation *lo = (BusStopLocation *)[stops objectForKey:@"lot_k"];
        NSLog(@"Loc Title: %@", [lo title]);
        return lo;
    }else if ((latitude > 43.084331 && latitude < 43.086567) && (longitude > -77.66412 && longitude < -77.657478)) {
        BusStopLocation *lo = (BusStopLocation *)[stops objectForKey:@"perkins_green"];
        NSLog(@"Loc Title: %@", [lo title]);
        return lo;
    }else if (((latitude > 43.081693 && latitude < 43.084331) && (longitude > -77.66412 && longitude < -77.657478))
              || ((latitude > 43.081779 && latitude < 43.083702) && (longitude > -77.657478 && longitude < -77.655386))) {
        BusStopLocation *lo = (BusStopLocation *)[stops objectForKey:@"colony_manor"];
        NSLog(@"Loc Title: %@", [lo title]);
        return lo;
    }else if (([self withinProvinceBoxesWithLatitude:latitude andLongitude:longitude])) {
        BusStopLocation *lo = (BusStopLocation *)[stops objectForKey:@"province"];
        NSLog(@"Loc Title: %@", [lo title]);
        return lo;
    }else if ((latitude > 43.086668 && latitude < 43.089466) && (longitude > -77.660037 && longitude < -77.655756)) {
        BusStopLocation *lo = (BusStopLocation *)[stops objectForKey:@"park_point_south"];
        NSLog(@"Loc Title: %@", [lo title]);
        return lo;
    }
    else if ((latitude > 43.089467 && latitude < 43.093681) && (longitude > -77.656389 && longitude < -77.652913)) {
        BusStopLocation *lo = (BusStopLocation *)[stops objectForKey:@"barnes_nobles"];
        NSLog(@"Loc Title: %@", [lo title]);
        return lo;
    }else if ((latitude > 43.089497 && latitude < 43.093643) && (longitude > -77.664189 && longitude < -77.653689)) {
        BusStopLocation *lo = (BusStopLocation *)[stops objectForKey:@"park_point_north"];
        NSLog(@"Loc Title: %@", [lo title]);
        return lo;
    }else if ([weekdayComponents weekday] == 7) {
        // Today is saturday, include the TE3 locations in check
        
    }
    else
    {
        NSLog(@"No Stop Located");
        NSLog(@"Defaulting to Gleason Circle");
        BusStopLocation *lo = (BusStopLocation *)[stops objectForKey:@"gleason_circle"];
        NSLog(@"Loc Title: %@", [lo title]);
        return lo;
    }
    
    // TODO: Don't have intermediate stops for TE3 and Raquet club busses yet
    
    return nil;
    
}



@end
