//
//  BeerTableViewController.h
//  The Beer Recorder
//
//  Created by Jeffrey McNally-Dawes on 2013-09-29.
//  Copyright (c) 2013 Jeffrey McNally-Dawes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Beer.h"
#import "BeerCell.h"
#import "BeerPageViewController.h"
#import "FMDBDataAccess.h"

@interface BeerTableViewController : UITableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) NSArray * beers;
@property (strong, nonatomic) NSArray * beerNames;
@property (strong, nonatomic) NSArray * beerPictures;
@property (strong, nonatomic) Beer * selectedBeer;
@property (nonatomic) int selectedRow;

-(IBAction)addTap:(id)sender;

@end
