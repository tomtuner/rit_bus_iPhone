//
//  RITTestController.m
//  rit_bus
//
//  Created by Thomas DeMeo on 8/10/12.
//
//

#import "RITTestController.h"

@implementation RITTestController

- (void)initializeScenarios;
{
    [self addScenario:[KIFTestScenario scenarioToGoToMap]];
    // Add additional scenarios you want to test here
}

@end
