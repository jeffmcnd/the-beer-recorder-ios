//
//  FMBDataAccess.m
//  The Beer Recorder
//
//  Created by Jeffrey McNally-Dawes on 2013-09-29.
//  Copyright (c) 2013 Jeffrey McNally-Dawes. All rights reserved.
//

#import "FMDBDataAccess.h"

@implementation FMDBDataAccess

-(NSMutableArray *)getBeers {
    NSMutableArray * beers = [[NSMutableArray alloc] init];
    
    FMDatabase * db = [FMDatabase databaseWithPath:[DOC_DIR stringByAppendingPathComponent:@"beer.db"]];
    
    [db open];
    
    FMResultSet * results = [db executeQuery:@"SELECT * FROM Beer"];
    
    @try {
        while([results next]) {
            Beer * beer = [[Beer alloc] init];
            
            beer.beerId = [results intForColumn:@"id"];
            beer.beerName = [results stringForColumn:@"beer_name"];
            beer.brewerName = [results stringForColumn:@"brewer_name"];
            beer.appearance = [results longForColumn:@"appearance"];
            beer.aroma = [results longForColumn:@"aroma"];
            beer.mouthFeel = [results longForColumn:@"mouth_feel"];
            beer.maltHop = [results longForColumn:@"malt_hop"];
            beer.flavour = [results longForColumn:@"flavour"];
            beer.overall = [results longForColumn:@"overall"];
            beer.comment = [results stringForColumn:@"comment"];
            
            [beers addObject:beer];
        }
    } @catch(NSException * e) {
        
    } @finally {
        [db close];
    }
    
    return beers;
}

-(BOOL)insertBeer:(Beer *)beer {
    FMDatabase * db = [FMDatabase databaseWithPath:[DOC_DIR stringByAppendingPathComponent:@"beer.db"]];
    
    [db open];
    
    BOOL success = NO;
    
    @try {
        success = [db executeUpdate:@"INSERT INTO Beer (appearance, aroma, mouth_feel, malt_hop, flavour, overall, comment, beer_name, brewer_name) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);", [NSNumber numberWithFloat:beer.appearance],[NSNumber numberWithFloat:beer.aroma], [NSNumber numberWithFloat:beer.mouthFeel], [NSNumber numberWithFloat:beer.maltHop], [NSNumber numberWithFloat:beer.flavour], [NSNumber numberWithFloat:beer.overall], beer.comment, beer.beerName, beer.brewerName, nil];
    } @catch (NSException * e) {
        
    } @finally {
        [db close];
    }
    
    return success;
}

-(BOOL)deleteBeer:(Beer *)beer {
    FMDatabase * db = [FMDatabase databaseWithPath:[DOC_DIR stringByAppendingPathComponent:@"beer.db"]];
    
    [db open];
    
    BOOL success = NO;
    
    @try {
        success = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM Beer WHERE id = %d", beer.beerId]];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [db close];
    }
    
    return success;
}

-(BOOL)updateBeer:(Beer *)beer {
    FMDatabase * db = [FMDatabase databaseWithPath:[DOC_DIR stringByAppendingPathComponent:@"beer.db"]];
    
    [db open];
    
    BOOL success = NO;
    
    @try {
        success = [db executeUpdate:[NSString stringWithFormat:@"UPDATE Beer SET appearance = %f, aroma = %f, mouth_feel = %f, malt_hop = %f, flavour = %f, overall = %f, comment = '%@', beer_name = '%@', brewer_name = '%@' WHERE id = %d", beer.appearance,beer.aroma, beer.mouthFeel, beer.maltHop, beer.flavour, beer.overall, beer.comment, beer.beerName, beer.brewerName, beer.beerId]];
    } @catch (NSException * e) {
        
    } @finally {
        [db close];
    }
    
    return success;
}

@end
