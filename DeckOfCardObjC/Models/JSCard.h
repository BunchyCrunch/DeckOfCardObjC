//
//  JSCard.h
//  DeckOfCardObjC
//
//  Created by Josh Sparks on 10/7/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSCard : NSObject

@property (nonatomic, copy, readonly) NSString * suit;
@property (nonatomic, copy, readonly) NSString * image;

- (instancetype)initWithCardSuit: (NSString *) suit
                           image: (NSString *) image;
@end

@interface JSCard (JSONConvertable)

- (instancetype)initWithDictionary: (NSDictionary<NSString *, id> *) dictionary;

@end

NS_ASSUME_NONNULL_END
