//
//  PlayingCard.h
//  Matchismo
//
//  Created by Sam Yang on 4/16/13.
//  Copyright (c) 2013 Sam Yang. All rights reserved.
//


#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end
