//
//  NextBusController.m
//  rit_bus
//
//  Created by Thomas DeMeo on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NextBusController.h"

@interface NextBusController ()

@end

@implementation NextBusController

@synthesize stopTitle;
@synthesize timeUntilArrival;
@synthesize arrivalTime;
@synthesize closestLocation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[LocationManager sharedLocationManager] startUpdates];
    
    closestLocation = [RITBusCommon stopFromLatitude:[[LocationManager sharedLocationManager] latitude] andLongitude:[[LocationManager sharedLocationManager] longitude]];
    
    stopTitle.titleLabel.text = closestLocation.title;
    
    
    NSLog(@"Latitude: %f", [[LocationManager sharedLocationManager] latitude]);
    NSLog(@"Longitude: %f", [[LocationManager sharedLocationManager] longitude]);

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    stopTitle = nil;
    timeUntilArrival = nil;
    arrivalTime= nil;
}

@end
