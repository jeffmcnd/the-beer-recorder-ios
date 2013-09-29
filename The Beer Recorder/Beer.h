//
//  Beer.h
//  The Beer Recorder
//
//  Created by Jeffrey McNally-Dawes on 2013-09-29.
//  Copyright (c) 2013 Jeffrey McNally-Dawes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Beer : NSObject

@property (nonatomic) float beerId;
@property (nonatomic, strong) NSString * brewerName;
@property (nonatomic, strong) NSString * beerName;
@property (nonatomic) float appearance;
@property (nonatomic) float aroma;
@property (nonatomic) float mouthFeel;
@property (nonatomic) float maltHop;
@property (nonatomic) float flavour;
@property (nonatomic) float overall;
@property (nonatomic, strong) NSString * comment;

@end
