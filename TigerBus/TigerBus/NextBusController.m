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

-(void) showLiveBusMap:(id)sender {
    MapViewController *mapController = [[MapViewController alloc] init];
    [self.navigationController pushViewController:mapController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [ThemeManager customizeView:self.view];
    [self setTitle:@"RIT"];
    
    timeUntilArrival.alpha = 0.0;
    
    closestLocation = [RITBusCommon closestStopFromLatitude:[[LocationManager sharedLocationManager] latitude] andLongitude:[[LocationManager sharedLocationManager] longitude]];
    
    [stopTitle setTitle:closestLocation.title forState:UIControlStateNormal];
    
    NSInteger nextTime = [RITBusCommon timeFromCurrentTimeInMinutesToDate:closestLocation.nextArrivalTime];
    if (closestLocation.pastLastStopTime) {
        nextTime = 1440 + nextTime;
    }
    
    if (nextTime != 1) {
        timeUntilArrival.text = [NSString stringWithFormat:@"%d minutes", nextTime];

    }else {
        timeUntilArrival.text = [NSString stringWithFormat:@"%d minute", nextTime];
    }
    
    self.arrivalTime.text = [RITBusCommon hoursMinutesSecondsStringFromDate:closestLocation.nextArrivalTime];
    
     [UIView animateWithDuration:0.5
                           delay: 0.0
                         options:UIViewAnimationOptionCurveEaseOut
                      animations:^{
                          timeUntilArrival.alpha = 1.0;
                      }
                      completion:nil];
}

@end
