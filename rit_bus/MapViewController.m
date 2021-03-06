//
//  MapViewController.m
//  rit_bus
//
//  Created by Thomas DeMeo on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@property (strong, nonatomic) NSMutableArray *polylines;
@property (strong, nonatomic) NSMutableArray *busPoints;
@property (strong, nonatomic) NSMutableArray *parkPointAnnotations;

@end

@implementation MapViewController

@synthesize ritBusMapView;
@synthesize busMapView;
@synthesize polylines;
@synthesize busPoints;
@synthesize hideAnnotionsButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    polylines = [[NSMutableArray alloc] init];
    
    busMapView.delegate = self;
    
    NSDictionary *parkPointStops = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"park_point_stops" ofType:@"plist"]] objectForKey:@"park_point"];    
    if (!parkPointStops) {
        NSLog(@"Resource not found for file: %@", @"park_point_stops.plist");
    }
    
    MKMapPoint points[parkPointStops.count];
    busPoints = [[NSMutableArray alloc] init];
    
    CLLocationCoordinate2D coordinate;
    MKCoordinateRegion region;
    int count = 0;    
    NSEnumerator *enumerator = [parkPointStops keyEnumerator];
    id key;
    BusPoint *point;
    
    StopAnnotation *stopAnnotation;
    
    while ((key = [enumerator nextObject])) {
        NSDictionary *stop = [parkPointStops objectForKey:key];
    
        
        NSString *title = [stop objectForKey:@"title"];
        
        coordinate.latitude = [[stop objectForKey:@"latitude"] doubleValue];
        coordinate.longitude = [[stop  objectForKey:@"longitude"] doubleValue];
        
        point = [[BusPoint alloc] initWithCoordinate:coordinate];
        stopAnnotation = [[StopAnnotation alloc] initWithCoordinate:coordinate placeName:nil description:nil];
        
        if (![title isEqualToString:@""]) {
            [point setTitle:title];
            [stopAnnotation setTitle:title];
        }
        if (count == 0) {
            region.center = coordinate;
        }
        
        points[count] = MKMapPointForCoordinate(coordinate);
        [busPoints addObject:point];
        count++;
        
        [self.busMapView addAnnotation:stopAnnotation];
        
    }
//    [polylines addObject:[MKPolyline polylineWithPoints:points count:count]];

    [self.busMapView addOverlays:polylines];
    
    MKCoordinateSpan span;
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;
    
    region.span = span;
    
    [self.busMapView setRegion:region];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    ritBusMapView = nil;
}

- (IBAction)hideAllAnnotation:(id)sender {
    NSArray *annotations = [self.busMapView annotations];
    StopAnnotation *annotation = nil; 
    if ([annotations count] > 0) {
        for (int i=0; i<[annotations count]; i++) {
            annotation = (StopAnnotation*)[annotations objectAtIndex:i];
            [[busMapView viewForAnnotation:annotation] setHidden:YES];
        }
    }
}

#pragma mark - MKMapViewDelegate Methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[StopAnnotation class]]) {
        StopAnnotation *mapAnnotation = (StopAnnotation *)annotation;
        
        StopAnnotationView *annotationView = [[StopAnnotationView alloc] initWithMapAnnotation:mapAnnotation];
        
        annotationView.enabled = YES;
        return annotationView;
    }
    
    return nil;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{

    if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolyline *polyline = (MKPolyline *)overlay;
        
        
        UIColor* color = [RITBusConstants ritBrown];
        if ([busPoints count] > 1 && [polylines count] > 1) {

            int index = (float)[polylines indexOfObjectIdenticalTo:polyline] / ([polylines count] - 1) * ([busPoints count] - 1);
            
            NSLog(@"Bus Points: %i", [busPoints count]);
            int num = [polylines indexOfObjectIdenticalTo:polyline];
            NSLog(@"Num: %i", num);

            NSLog(@"Polylines: %i", [polylines count]);
            NSLog(@"Index: %i", index);
            BusPoint *point = [busPoints objectAtIndex:index];
            NSLog(@"Title: %@", point.title);
            if ([point title]) {
                color =  [RITBusConstants ritOrange];
            }
        }
        
        MKPolylineView *overlayView = [[MKPolylineView alloc] initWithPolyline:polyline];
        overlayView.fillColor = color;
        overlayView.strokeColor = color;
        overlayView.lineWidth = 7;

        return overlayView;
    }

    return nil;
}

@end
