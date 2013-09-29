//
//  FMBDataAccess.h
//  The Beer Recorder
//
//  Created by Jeffrey McNally-Dawes on 2013-09-29.
//  Copyright (c) 2013 Jeffrey McNally-Dawes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Beer.h"
#import "Constants.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

@interface FMDBDataAccess : NSObject

-(NSMutableArray *)getBeers;
-(BOOL)insertBeer:(Beer *)beer;
-(BOOL)updateBeer:(Beer *)beer;

@end
