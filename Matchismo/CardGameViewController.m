//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Sam Yang on 4/16/13.
//  Copyright (c) 2013 Sam Yang. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) Deck *deck;

@end

@implementation CardGameViewController
- (Deck *)deck
{
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    {
        return _deck;
    }
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    NSLog(@"Setting card buttons");
    _cardButtons = cardButtons;
    for (UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.deck drawRandomCard];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
    }
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        self.flipCount++;
    }
    //draw random cards on each flip (but lose the top card b/c this wasn't built for this application)
//    else {
//        Card *card = [self.deck drawRandomCard];
//        [self.deck addCard:card atTop:NO];
//        [sender setTitle:card.contents forState:UIControlStateSelected];
//    }
}



@end
