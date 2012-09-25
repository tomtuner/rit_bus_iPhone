//
//  DetailViewController.h
//  TigerBus
//
//  Created by Thomas DeMeo on 9/23/12.
//  Copyright (c) 2012 Thomas DeMeo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
