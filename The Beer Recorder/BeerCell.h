//
//  BeerCell.h
//  The Beer Recorder
//
//  Created by Jeffrey McNally-Dawes on 2013-09-29.
//  Copyright (c) 2013 Jeffrey McNally-Dawes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeerCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView * picture;
@property (strong, nonatomic) IBOutlet UILabel * beerName;

@end
