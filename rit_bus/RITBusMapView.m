//
//  RitBusMapView.m
//  rit_bus
//
//  Created by Thomas DeMeo on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RitBusMapView.h"

@interface RitBusMapView()

@property (strong, nonatomic) NSMutableArray* polylines;

- (void)initialize;

@end

@implementation RitBusMapView

@synthesize view;
@synthesize mapView;
@synthesize polylines;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self initialize];
        
        view.frame = self.frame;
    }
    return self;
}

- (void)dealloc
{
    mapView.delegate = nil;
}

- (void)initialize
{
    [[NSBundle mainBundle] loadNibNamed:@"RitBusMapView" owner:self options:nil];
    [self addSubview:view];
    
    view.frame = self.frame;
    polylines = [[NSMutableArray alloc] init];
    
    mapView.delegate = self;
    
    MKMapPoint points[5];
    
    CLLocationCoordinate2D coordinate0;
    coordinate0.latitude = 43.00;
    coordinate0.longitude = -77.00;
    points[0] = MKMapPointForCoordinate(coordinate0);
    
    CLLocationCoordinate2D coordinate1;
    coordinate1.latitude = 43.00;
    coordinate1.longitude = -77.50;
    points[1] = MKMapPointForCoordinate(coordinate1);
    
    [polylines addObject:[MKPolyline polylineWithPoints:points count:5]];
    
    [self.mapView addOverlays:polylines];
    
    MKCoordinateSpan span;
    span.latitudeDelta = 1;
    span.longitudeDelta = 1;
    
    MKCoordinateRegion region;
    region.center = coordinate0;
    region.span = span;
    
    [self.mapView setRegion:region];
    
}

@end

