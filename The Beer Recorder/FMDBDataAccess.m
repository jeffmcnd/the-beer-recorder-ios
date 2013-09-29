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
    
    FMResultSet * results = [db executeQuery:@"SELECT * FROM Beers"];
    
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
    
}

-(BOOL)updateBeer:(Beer *)beer {
    
}

@end
