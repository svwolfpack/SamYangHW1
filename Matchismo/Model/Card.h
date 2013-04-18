//
//  Card.h
//  Matchismo
//
//  Created by Sam Yang on 4/16/13.
//  Copyright (c) 2013 Sam Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;
@end
