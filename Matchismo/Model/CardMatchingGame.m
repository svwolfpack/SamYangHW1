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
@property (readwrite, nonatomic, strong)NSString *resultOfLastFlip;
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
    PlayingCard *card = [self cardAtIndex:index];
    
    //make sure we get card at that index and it's playable
    if (card && !card.isUnplayable) {
        //if we get a card that is playable, then we'll flip it
        //look at other cards in cards
        
        if(!card.isFaceUp) {
            NSMutableArray *faceUpCards = [[NSMutableArray alloc] init];
            for (PlayingCard *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    [faceUpCards addObject:otherCard];
                }
            }
            
            
            if(faceUpCards.count == 1)  //2 for 3-card game
            {
                int matchScore = [card match:[faceUpCards copy]];   //we have a NSMutable but we need a NSArray
                if (matchScore > 0) {
                    card.unplayable = YES;
                    for(PlayingCard *faceUpCard in faceUpCards)
                    {
                        faceUpCard.unplayable = YES;
                        
                        self.resultOfLastFlip = [NSString stringWithFormat:@"Matched %@%d with %@%d for %d points", card.suit, card.rank, faceUpCard.suit, faceUpCard.rank, matchScore * MATCH_BONUS];
                    }
                    self.score += matchScore * MATCH_BONUS;
                }
                else {
                    for(PlayingCard *faceUpCard in faceUpCards)
                    {
                        faceUpCard.faceUp = NO;
                        self.resultOfLastFlip = [NSString stringWithFormat:@"%@%d and %@%d don't match! %d point penalty!", card.suit, card.rank, faceUpCard.suit, faceUpCard.rank, MISMATCH_PENALTY];
                    }
                    self.score -= MISMATCH_PENALTY;
                    
                    
                }
                
                self.score -= FLIP_COST;
            }
            else {
                self.resultOfLastFlip = [NSString stringWithFormat:@"Flipped up %@%d!", card.suit, card.rank];
            }
        }
        card.faceUp = !card.isFaceUp;
    }
}


@end
