//
//  RITBusCommon.h
//  rit_bus
//
//  Created by Thomas DeMeo on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusStopLocation.h"

@interface RITBusCommon : NSObject {
    
}

+ (BusStopLocation *) stopFromLatitude: (float) latitude andLongitude: (float) longitude;

@end
