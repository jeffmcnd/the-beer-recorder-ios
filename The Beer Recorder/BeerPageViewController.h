//
//  BeerPageViewController.h
//  The Beer Recorder
//
//  Created by Jeffrey McNally-Dawes on 2013-09-29.
//  Copyright (c) 2013 Jeffrey McNally-Dawes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeerPageViewController : UIViewController <UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView * picture;
@property (strong, nonatomic) IBOutlet UITextField * brewerName;
@property (strong, nonatomic) IBOutlet UISlider * appearanceSlider;
@property (strong, nonatomic) IBOutlet UISlider * aromaSlider;
@property (strong, nonatomic) IBOutlet UISlider * mouthFeelSlider;
@property (strong, nonatomic) IBOutlet UISlider * maltHopSlider;
@property (strong, nonatomic) IBOutlet UISlider * flavourSlider;
@property (strong, nonatomic) IBOutlet UISlider * overallSlider;
@property (strong, nonatomic) IBOutlet UITextView * commentTF;

- (IBAction)appearanceDrag:(id)sender;
- (IBAction)aromaDrag:(id)sender;
- (IBAction)mouthFeelDrag:(id)sender;
- (IBAction)maltHopDrag:(id)sender;
- (IBAction)flavourDrag:(id)sender;
- (IBAction)overallDrag:(id)sender;

@end
