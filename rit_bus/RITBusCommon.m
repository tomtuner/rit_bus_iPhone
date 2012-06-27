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

@end

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

+ (BOOL) pointInPolygonWithNumberOfCorners: (int) polySides fromLatitude: (float) x andLongitude: (float) y
                              usingXPoints: (float[]) polyX andYPoints: (float[]) polyY {        
    int   i, j=polySides-1;
    BOOL  oddNodes=NO;
    
    for (i=0; i<polySides; i++) {
        if (((polyY[i]< y && polyY[j]>=y)
             ||   (polyY[j]< y && polyY[i]>=y))
            &&  (polyX[i]<=x || polyX[j]<=x)) {
            if (polyX[i]+(y-polyY[i])/(polyY[j]-polyY[i])*(polyX[j]-polyX[i])<x) {
                oddNodes=!oddNodes;
            }
        }
        j=i; 
    }
    
    return oddNodes;
}

+ (BOOL) pointInTriangleWithOriginX: (float) xOrigin andYOrigin: (float) yOrigin withXPoints: (float[]) polyX andYPoints: (float[]) polyY
                    usingLatitude :(float) lat andLongitude: (float) lng {
    float longPA = lng - xOrigin;
    float latPA = lat - yOrigin;
    
    float longBA = polyX[0] - xOrigin;
    float latBA = polyY[0] - yOrigin;
    
    float longCA = polyX[1] - xOrigin;
    float latCA = polyY[1] - yOrigin;
    
    NSLog(@"LatPA : %f", latPA);
    NSLog(@"LatBA : %f", latBA);
    NSLog(@"LatCA : %f", latCA);
    NSLog(@"LongPA : %f", longPA);
    NSLog(@"LongBA : %f", longBA);
    NSLog(@"LongCA : %f", longCA);

    
//    if ((latPA < 0) || (longPA < 0) || (latCA < latPA) || (longCA < longPA) || (latBA < latPA) || (longBA < longPA)) {
//        return NO;
//    }
    
//    if ((latPA < 0) || (longPA < 0)) {
//        return NO;
//    }else if (latPA > latCA) {
//        if (longPA > longCA) {
//            return NO;
//        }
//    }else if (latPA > latBA) {
//        if (longPA > longBA) {
//            return NO;
//        }
//    }else {
//        return YES;
//    }
    
    if ((latPA < 0) || (longPA < 0)) {
        return NO;
    }
    
    if ((latPA < latBA) || (latPA < latCA)) {
        if ((longPA < longBA) || (longPA < longCA)) {
            return YES;
        }
    }
    return NO;
}

+ (BusStopLocation *) closestStopFromLatitude:(float)latitude andLongitude:(float)longitude {

    NSMutableDictionary *stops = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allStops];
;
    
    // Should create helper methods for all of these calculations
    
    if ((latitude > 43.078018 && latitude < 43.088009) && (longitude > -77.687959 && longitude < -77.670707)) {
        BusStopLocation *lo = (BusStopLocation *)[stops objectForKey:@"gleason_circle"];
        NSLog(@"Loc Title: %@", [lo title]);
        return lo;
    }else if ((latitude > 43.078825 && latitude < 43.084869) && (longitude > -77.67119 && longitude < -77.665461)) {
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
    }
    
    // For province triangle
    
    float polyX[] = {-77.654142, -77.654056};
//    float polyX[] = {-77.657489 + 180, -77.654142 + 180, -77.654056 + 180};
//    float polyX[] = {0, 4, 6};

    float polyY[] = {43.086669, 43.090343};
//    float polyY[] = {1, 5, 1};
    
    if ([self pointInTriangleWithOriginX:-77.657489 andYOrigin:43.086583 withXPoints:polyX andYPoints:polyY usingLatitude:latitude andLongitude:longitude]) {
        NSLog(@"Point in Triangle!");
    }
    
    // Need to calculate point in triangle for park point and province stops
    
    
    NSLog(@"No Stop Located");
    return nil;
    
}



@end
