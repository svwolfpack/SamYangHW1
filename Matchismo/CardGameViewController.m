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
#import "GameResult.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
//@property (strong, nonatomic) Deck *deck; //unnecessary to use Deck anymore b/c we're going to use the model
@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@property (strong, nonatomic) CardMatchingGame * game; //create property that points to model
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsOfLastFlipLabel;
@property (strong, nonatomic) GameResult *gameResult;
@end

@implementation CardGameViewController
@synthesize game = _game;   //not automatic if you have your own setter
@synthesize gameResult = _gameResult;

- (void)viewDidLoad
//in view controllers, treat this like init for other things
{
    [super viewDidLoad];
    
    self.gameResult = [[GameResult alloc]init];
    self.game = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc]init]];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (IBAction)dealPressed:(UIButton *)sender {
    [self setGame:nil];
    self.gameResult = nil;
    self.flipCount = 0;
    [self updateUI];
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
    self.gameResult.score = self.game.score;
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
    self.resultsOfLastFlipLabel.text = self.game.resultOfLastFlip;
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
