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
        
    closestLocation = [RITBusCommon closestStopFromLatitude:[[LocationManager sharedLocationManager] latitude] andLongitude:[[LocationManager sharedLocationManager] longitude]];
    
    [stopTitle setTitle:closestLocation.title forState:UIControlStateNormal];
    
    [self setTitle:@"Tiger Bus"];
        
    [UIView animateWithDuration:2.0 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn 
     animations:^{
        timeUntilArrival.alpha = 0.0;
    }
                     completion:^(BOOL finished) {
     [UIView animateWithDuration:2.0
                           delay: 0.0
                         options:UIViewAnimationOptionCurveEaseOut
                      animations:^{
                          timeUntilArrival.text = @"37 minutes";
                          timeUntilArrival.alpha = 1.0;
                      }
                      completion:nil];
     }];

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
