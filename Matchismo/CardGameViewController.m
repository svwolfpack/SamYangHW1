//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Sam Yang on 4/16/13.
//  Copyright (c) 2013 Sam Yang. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
//@property (strong, nonatomic) Deck *deck; //unnecessary to use Deck anymore b/c we're going to use the model
@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@property (strong, nonatomic) CardMatchingGame * game; //create property that points to model
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation CardGameViewController
- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[[PlayingCardDeck alloc] init]];
    
    return _game;
}

//- (Deck *)deck
//{
//  if (!_deck) _deck = [[PlayingCardDeck alloc] init];
//    {
//        return _deck;
//    }
//}

- (void)setDealButton:(UIButton *)dealButton
{
    _dealButton = dealButton;
    //call method to deal new game
    //[self updateUI];
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    //for (UIButton *cardButton in self.cardButtons)
    //{
    //    Card *card = [self.deck drawRandomCard];
    //    [cardButton setTitle:card.contents forState:UIControlStateSelected];
    //}
    //i need to update UI to reflect the model here
    [self updateUI]; // common paradigm to have method that makes sure model and control are aligned
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]]; //model mapping to UI
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    //sender.selected = !sender.selected;
    //if (sender.selected)
    //{
    //    self.flipCount++;
    //}
    //tell our model please flip card at index n
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    
    //draw random cards on each flip (but lose the top card b/c this wasn't built for this application)
//    else {
//        Card *card = [self.deck drawRandomCard];
//        [self.deck addCard:card atTop:NO];
//        [sender setTitle:card.contents forState:UIControlStateSelected];
//    }
}



@end
