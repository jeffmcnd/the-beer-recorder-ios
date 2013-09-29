//
//  MyManager.h
//  The Beer Recorder
//
//  Created by Jeffrey McNally-Dawes on 2013-09-29.
//  Copyright (c) 2013 Jeffrey McNally-Dawes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Beer.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "Constants.h"

@interface MyManager : NSObject

@property (strong, nonatomic) FMDatabase * db;

+(id)sharedManager;

@end
