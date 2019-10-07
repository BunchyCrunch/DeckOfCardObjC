//
//  JSCardController.m
//  DeckOfCardObjC
//
//  Created by Josh Sparks on 10/7/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

#import "JSCardController.h"

@implementation JSCardController

// + defines this as a class method, similar to a static func
// return with our card controller
// * pointer in memory for our card controller
// sharedController is our internal parameter name
+ (JSCardController *)sharedController
{
    // making sure that our shared controller doesn't exist.
    static JSCardController * sharedController = nil;
    // create a once token to keep track of how many times this function has been run
    // this is done on our dispatch-once thread
    static dispatch_once_t onceToken;
    // method that takes in our once token from above and runs a completion to allocate and initialize a JSCardController
    dispatch_once(&onceToken, ^{
        sharedController = [JSCardController new];
    });
    return sharedController;
}

// defines a constant for our baseURL with a string literal
static NSString * const baseURLString =
@"https://deckofcardsapi.com/api/deck/new";

- (void)drawNewCard:(NSInteger)numberOfCards completion:(void (^)(NSArray<JSCard *> *))completion
{
    // defines a variable for our url (uses bracket syntax vs dot syntax like in swift)
    NSURL * url = [NSURL URLWithString:baseURLString];
    NSString * cardCount = [@(numberOfCards) stringValue];
    NSURL * drawURL = [url URLByAppendingPathComponent:@"draw/"];
    NSURLComponents * urlComponents = [NSURLComponents componentsWithURL:drawURL resolvingAgainstBaseURL:true];
    
    NSURLQueryItem * queryItem = [NSURLQueryItem queryItemWithName:@"count" value:cardCount];
    
    urlComponents.queryItems = @[queryItem];
    NSURL * finalURL = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (data)
        {
            // defining a variable and pointing in memory for our top level dictionary, calling our jsonSerialization method with get an object with data, 2 represents "allow fragments" for our reading options. "&error" refers to same spot in memory as error from data task.
            NSDictionary * topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
            if (!topLevelDictionary)
            {
                NSLog(@"Error parsing the JSON %@", error);
                completion(nil);
                return;
            }
            // define a variable for our cards array at the key "cards" from our top level dictionary
            NSArray * cardsArray = topLevelDictionary[@"cards"];
            // defining a placeholder variable that is declared as mutable so that we can later append to it
            NSMutableArray * cardPlaceholder = [NSMutableArray new];
            
            for(NSDictionary * dictionary in cardsArray)
            {
                JSCard * card = [[JSCard alloc] initWithDictionary:dictionary];
                [cardPlaceholder addObject:card];
            }
            completion(cardPlaceholder);
        }
    }]resume];
}

-(void)fetchImageFromCard:(JSCard *)card completion:(void (^)(UIImage *))completion
{
    NSURL * imageURL = [NSURL URLWithString:card.image];
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error: %@, %@", error, [error localizedDescription]);
            completion(nil);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (data)
        {
            UIImage * image = [UIImage imageWithData:data];
            completion(image);
        }
    }] resume];
}
@end
