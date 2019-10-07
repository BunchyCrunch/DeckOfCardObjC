//
//  JSCardViewController.h
//  DeckOfCardObjC
//
//  Created by Josh Sparks on 10/7/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSCardViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *suitLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
- (IBAction)drawNewButtonTapped:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
