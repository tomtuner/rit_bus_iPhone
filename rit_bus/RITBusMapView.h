//
//  RitBusMapView.h
//  rit_bus
//
//  Created by Thomas DeMeo on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RitBusMapView : UIView <MKMapViewDelegate>



@property (strong, nonatomic) IBOutlet UIView *busView;

@property (strong, nonatomic) IBOutlet MKMapView* mapView;
@end
