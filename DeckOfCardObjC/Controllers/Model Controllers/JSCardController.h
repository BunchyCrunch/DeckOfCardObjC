//
//  JSCardController.h
//  DeckOfCardObjC
//
//  Created by Josh Sparks on 10/7/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSCard.h"
#import <UIKit/UIKit.h>

@interface JSCardController : NSObject

+ (JSCardController * )sharedController;

- (void)drawNewCard: (NSInteger)numberOfCards completion: (void (^) (NSArray <JSCard *> *))completion;

- (void)fetchImageFromCard: (JSCard *)card completion:(void(^)(UIImage *))completion; 

@end


