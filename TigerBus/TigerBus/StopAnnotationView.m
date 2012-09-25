//
//  StopAnnotationView.m
//  rit_bus
//
//  Created by Thomas DeMeo on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StopAnnotationView.h"

#define kWidth 40
#define kHeight 55

@interface StopAnnotationView()

@property (nonatomic, strong) UIImageView *backgroundImageView;

- (UIImageView *)imageViewForAnnotation;

@end

@implementation StopAnnotationView

@synthesize mapAnnotation;
@synthesize backgroundImageView;

- (id)initWithMapAnnotation:(StopAnnotation *)aMapAnnotation
{    
    if ((self = [super initWithAnnotation:aMapAnnotation reuseIdentifier:[aMapAnnotation reuseIdentifier]
]))
    {        
        mapAnnotation = aMapAnnotation;
        
        self.frame = CGRectMake(0, 0, kWidth, kHeight);
        
        UIImageView *imageView = [self imageViewForAnnotation];  
        if (imageView) {
            self.backgroundImageView = imageView;
            [self addSubview:imageView];
        }
        
        UILabel *label = [self labelForAnnotation];
        if (label) {
            [self addSubview:label];
        }
        
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (UIImage *)imageForAnnotation {
    
    return [UIImage imageNamed:@"stop_annotation_marker"];
}

- (UIImageView *)imageViewForAnnotation {
    UIImage *image = [self imageForAnnotation];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

    imageView.center = CGPointMake(23 + image.size.width / 2, 27 + image.size.height / 2);
    
    return imageView;
}

- (UILabel *)labelForAnnotation {      
        
    CGSize imgSize = self.backgroundImageView.image.size;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, -15.0f, imgSize.width, imgSize.height)];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:12];
    label.numberOfLines = 2;
    
    NSString *text = [NSString stringWithFormat:@"%@\n%@", mapAnnotation.title, mapAnnotation.subtitle];
    
    label.text = text;
    
    return label;
}



@end
