//
//  GameResult.h
//  Matchismo
//
//  Created by Sam Yang on 6/4/13.
//  Copyright (c) 2013 Sam Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject
@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;

+ (NSArray *)allGameResults;
@end
