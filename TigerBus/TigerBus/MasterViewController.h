//
//  MasterViewController.h
//  TigerBus
//
//  Created by Thomas DeMeo on 9/23/12.
//  Copyright (c) 2012 Thomas DeMeo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
