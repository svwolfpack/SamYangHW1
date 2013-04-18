//
//  Deck.m
//  Matchismo
//
//  Created by Sam Yang on 4/16/13.
//  Copyright (c) 2013 Sam Yang. All rights reserved.
//

#import "Deck.h"
@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck
//init functions go at top
- (id)init  //over ride default init function
{
    self = [super init];    //calling init on NSObject; done by default but we have
                            //to do it
    if (self)
    {
        self.cards = [[NSMutableArray alloc] init];
    }
    return self;
}

//- (NSMutableArray *)cards
//{
//    if (!_cards) _cards = [[NSMutableArray alloc] init];
//    return _cards;
//}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
    
}

- (Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    if (self.cards.count) {
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}
@end
