//
//  JSCardViewController.m
//  DeckOfCardObjC
//
//  Created by Josh Sparks on 10/7/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

#import "JSCardViewController.h"
#import "JSCardController.h"
#import "JSCard.h"

@interface JSCardViewController ()

@end

@implementation JSCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)drawNewButtonTapped:(UIButton *)sender {
    // calling our draw card function on our shared instance, we added an internal name for hte array that was completed with and used that array to fetch an image by passing in the first card in the array to our fetch image method
    [JSCardController.sharedController drawNewCard:1 completion:^(NSArray<JSCard *> * cardArray) {
        [JSCardController.sharedController fetchImageFromCard:cardArray[0] completion:^(UIImage * image) {
            // same as dispatchQueue.main.async
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cardImageView.image = image;
                JSCard * card = cardArray[0];
                self.suitLabel.text = card.suit;
            });
        }];
    }];
}
@end
