//
//  StopAnnotation.h
//  rit_bus
//
//  Created by Thomas DeMeo on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface StopAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
}

@property(nonatomic) CLLocationCoordinate2D coordinate;
@property(nonatomic, strong) NSString *title;   
@property(nonatomic, strong) NSString *subtitle;

- (NSString *)reuseIdentifier;
- (id)initWithCoordinate:(CLLocationCoordinate2D)location placeName:(NSString *)placeName description:(NSString *)description;

@end
