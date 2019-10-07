//
//  JSCard.m
//  DeckOfCardObjC
//
//  Created by Josh Sparks on 10/7/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

#import "JSCard.h"

@implementation JSCard

//Creating an instance type function, we start by defining what we want returned, external parameter name/function name, followed by the type declaration and pointer in memory, this is followed by our internal name for each parameter and then we open the scope.
- (instancetype)initWithCardSuit: (NSString *)suit image: (NSString *)image
{
    // Almost everything in ObjC is a class
    // When creating your own class, it is a subclass of NSObject, so we need to initialize the super class first.
    self = [super init];
    
    // if self exists, then initialize with our properties
    if (self)
    {
        // _ is the same as self. in swift
        //-suit = self.suit
        _suit = suit;
        _image = image;
    }
    return self;
}

@end

// extensin on our JSCard
@implementation JSCard (JSONConvertable)


// 1: "-" = instance method.
// 2: "()" = What we are returning with
// 3: "initWithDictionary:" = External name for our first parameter
// 4: "(NSDictionary<id, id> *)" = type declaration
// 5: "NSDictionary<NSString *, id>" = defines the types for the key "NSString" and value "id (aka Any)" of our dictionary
// 6: "*" = our pointer in memory
// 7: "dictionary" = Internal name for our parameter
- (JSCard *)initWithDictionary: (NSDictionary<NSString *, id> *) dictionary
{
    NSString * suit = dictionary[@"suit"];
    NSString * image = dictionary[@"image"];
    
    return [self initWithCardSuit:suit image:image];
}

@end
