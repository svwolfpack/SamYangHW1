//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Sam Yang on 4/22/13.
//  Copyright (c) 2013 Sam Yang. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()
@property(readwrite, nonatomic)int score;
@property(strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame
@synthesize cards;
- (id)cards
{
    if(!cards)
        cards = [[NSMutableArray alloc] init];
    return cards;
}
//- (NSMutableArray *)cards
//{
//    if (!_cards) _cards = [[NSMutableArray alloc] init];
//    return _cards;
//}

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;
{
    self = [super init];
    
    if (self) {
        for (int i=0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            
            //if able to draw random card, put it in
            //if asking for more than 52 cards, we'd have a malformed array so
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
            
            self.cards[i] = card; //if this is nil, nothing will happen, so we need lazy instantiation
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    //make sure we get card at that index and it's playable
    if (card && !card.isUnplayable) {
        //if we get a card that is playable, then we'll flip it
        //look at other cards in cards
        
        if(!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        //if matches, turn both cards face down and aware points
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}


@end
