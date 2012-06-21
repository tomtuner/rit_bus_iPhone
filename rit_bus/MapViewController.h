//
//  MapViewController.h
//  rit_bus
//
//  Created by Thomas DeMeo on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RitBusMapView.h"
#import "BusPoint.h"
#import "RITBusConstants.h"
#import "StopAnnotation.h"
#import "StopAnnotationView.h"

@interface MapViewController : UIViewController <MKMapViewDelegate> {
    
}


@property (nonatomic, retain) IBOutlet RitBusMapView *ritBusMapView;
@property (nonatomic, retain) IBOutlet MKMapView *busMapView;
@property (nonatomic, retain) IBOutlet UIButton *hideAnnotionsButton;

@end
