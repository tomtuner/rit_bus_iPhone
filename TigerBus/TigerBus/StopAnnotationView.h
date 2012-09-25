//
//  StopAnnotationView.h
//  rit_bus
//
//  Created by Thomas DeMeo on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "StopAnnotation.h"

@interface StopAnnotationView : MKAnnotationView


-(id)initWithMapAnnotation:(StopAnnotation *)mapAnnotation;

@property (nonatomic, readonly) StopAnnotation *mapAnnotation;

@end
