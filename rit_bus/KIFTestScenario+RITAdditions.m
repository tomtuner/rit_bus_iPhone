//
//  KIFTestScenario+RITAdditions.m
//  rit_bus
//
//  Created by Thomas DeMeo on 8/10/12.
//
//

#import "KIFTestScenario+RITAdditions.h"

@implementation KIFTestScenario (RITAdditions)


+ (id)scenarioToGoToMap
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a user can get to the map of bus routes."];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Map"]];
    
    // Verify that the login succeeded
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:@"Hide"]];
    
    return scenario;
}


@end
