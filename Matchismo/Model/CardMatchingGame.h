//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Sam Yang on 4/22/13.
//  Copyright (c) 2013 Sam Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "PlayingCard.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (PlayingCard *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic)int score;
@property (readonly, nonatomic, strong)NSString *resultOfLastFlip;

@end
