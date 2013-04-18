//
//  Deck.h
//  Matchismo
//
//  Created by Sam Yang on 4/16/13.
//  Copyright (c) 2013 Sam Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;

@end
