//
//  BeerPageViewController.h
//  The Beer Recorder
//
//  Created by Jeffrey McNally-Dawes on 2013-09-29.
//  Copyright (c) 2013 Jeffrey McNally-Dawes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Beer.h"
#import "FMDBDataAccess.h"
#import "GKImagePicker.h"

@interface BeerPageViewController : UIViewController <UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UIActionSheetDelegate,
GKImagePickerDelegate,
UITextFieldDelegate,
UITextViewDelegate> {
    
}

@property (strong, nonatomic) Beer * beer;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;
@property (strong, nonatomic) IBOutlet UIScrollView * beerSV;
@property (strong, nonatomic) IBOutlet UIView *container;
@property (strong, nonatomic) IBOutlet UIImageView * picture;
@property (strong, nonatomic) IBOutlet UITextField * brewerName;
@property (strong, nonatomic) IBOutlet UISlider * appearanceSlider;
@property (strong, nonatomic) IBOutlet UISlider * aromaSlider;
@property (strong, nonatomic) IBOutlet UISlider * mouthFeelSlider;
@property (strong, nonatomic) IBOutlet UISlider * maltHopSlider;
@property (strong, nonatomic) IBOutlet UISlider * flavourSlider;
@property (strong, nonatomic) IBOutlet UISlider * overallSlider;
@property (strong, nonatomic) IBOutlet UITextView * comment;

@property (strong, nonatomic) GKImagePicker * picker;

-(void)setupBeer:(Beer *)beer;
-(IBAction)appearanceDrag:(id)sender;
-(IBAction)aromaDrag:(id)sender;
-(IBAction)mouthFeelDrag:(id)sender;
-(IBAction)maltHopDrag:(id)sender;
-(IBAction)flavourDrag:(id)sender;
-(IBAction)overallDrag:(id)sender;
-(IBAction)chooseImage:(id)sender;

@end
