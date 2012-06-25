//
//  NextBusController.h
//  rit_bus
//
//  Created by Thomas DeMeo on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationManager.h"
#import "BusStopLocation.h"

@interface NextBusController : UIViewController {
    UILabel *stopTitle;
    UILabel *timeUntilArrival;
    UILabel *arrivalTime;
    BusStopLocation *closestLocation;
}

@property (nonatomic, strong) IBOutlet UILabel *stopTitle;
@property (nonatomic, strong) IBOutlet UILabel *timeUntilArrival;
@property (nonatomic, strong) IBOutlet UILabel *arrivalTime;
@property (nonatomic, strong) BusStopLocation *closestLocation;

@end
