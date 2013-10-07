//
//  BeerPageViewController.m
//  The Beer Recorder
//
//  Created by Jeffrey McNally-Dawes on 2013-09-29.
//  Copyright (c) 2013 Jeffrey McNally-Dawes. All rights reserved.
//

#import "BeerPageViewController.h"

@interface BeerPageViewController ()

@end

@implementation BeerPageViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [_comment setDelegate:self];
    [_brewerName setDelegate:self];
    
    CGRect screen = [[UIScreen mainScreen] applicationFrame];
    
//    rect.origin.y += self.navigationController.navigationBar.frame.size.height;
//    rect.size.height -= self.navigationController.navigationBar.frame.size.height;
    
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    
//    [self.view setFrame:rect];
    [_beerSV setFrame:CGRectMake(0, navHeight, screen.size.width, screen.size.height - navHeight)];
    [_beerSV setContentSize:_container.frame.size];
    
    UITapGestureRecognizer * viewTap = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(dismissKeyboard)];
    [_container addGestureRecognizer:viewTap];
    
    UIImage * img = [UIImage imageWithContentsOfFile:[DOC_DIR stringByAppendingPathComponent:[NSString stringWithFormat:@"beer%d", _beer.beerId]]];
    if(img == nil) [_picture setImage:[UIImage imageNamed:@"no_beer"]];
    else [_picture setImage:img];
    
    [_navItem setTitle:_beer.beerName];
    [_brewerName setText:_beer.brewerName];
    [_appearanceSlider setValue:_beer.appearance];
    [_aromaSlider setValue:_beer.aroma];
    [_mouthFeelSlider setValue:_beer.mouthFeel];
    [_maltHopSlider setValue:_beer.maltHop];
    [_flavourSlider setValue:_beer.flavour];
    [_overallSlider setValue:_beer.overall];
    [_comment setText:_beer.comment];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self saveBeer];
}

-(void)setupBeer:(Beer *)beer {
    _beer = beer;
}

-(void)dismissKeyboard {
    [_brewerName resignFirstResponder];
    [_comment resignFirstResponder];
}

-(IBAction)chooseImage:(id)sender {
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]
//                                  initWithTitle:nil
//                                  delegate:self
//                                  cancelButtonTitle:@"Cancel"
//                                  destructiveButtonTitle:nil
//                                  otherButtonTitles:@"Camera", nil];
//    actionSheet.actionSheetStyle = UIBarStyleBlackTranslucent;
//    [actionSheet showFromToolbar:self.navigationController.toolbar];
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [imagePicker setDelegate:self];
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
}

# pragma mark Slider Actions

- (IBAction)appearanceDrag:(id)sender {
    _beer.appearance = ((UISlider *)sender).value;
}

- (IBAction)aromaDrag:(id)sender {
    _beer.aroma = ((UISlider *)sender).value;
}

- (IBAction)mouthFeelDrag:(id)sender {
    _beer.mouthFeel = ((UISlider *)sender).value;
}

- (IBAction)maltHopDrag:(id)sender {
    _beer.maltHop = ((UISlider *)sender).value;
}

- (IBAction)flavourDrag:(id)sender {
    _beer.flavour = ((UISlider *)sender).value;
}

- (IBAction)overallDrag:(id)sender {
    _beer.overall = ((UISlider *)sender).value;
}

-(void)saveBeer {
    _beer.brewerName = _brewerName.text;
    _beer.comment = _comment.text;
    
    FMDBDataAccess * db = [[FMDBDataAccess alloc] init];
    
    [db updateBeer:_beer];
}

# pragma mark Delegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    switch(buttonIndex) {
//        case 0: {
//            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//            [self presentViewController:picker animated:YES completion:nil];
//            break;
//        }
//        default:
//            break;
//    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:^{
        _picker = [[GKImagePicker alloc] init];
        [_picker setCropSize:CGSizeMake(320, 150)];
        [_picker setDelegate:self];
        [self.navigationController presentViewController:_picker.imagePickerController animated:NO completion:nil];
    }];
    
    UIImage * img = [[UIImage alloc] init];
    
    img = [info objectForKey:UIImagePickerControllerEditedImage];
    if(img == nil) img = [info objectForKey:UIImagePickerControllerOriginalImage];
    if(img == nil) img = [info objectForKey:UIImagePickerControllerCropRect];
    
    if(img == nil) NSLog(@"Something is wrong with the camera.");
    
    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
}

- (void)imagePicker:(GKImagePicker *)imagePicker pickedImage:(UIImage *)image {
    [_picture setImage:image];
    
    NSData * imageData = UIImageJPEGRepresentation(_picture.image, 1.0);
    [imageData writeToFile:[DOC_DIR stringByAppendingPathComponent:[NSString stringWithFormat:@"beer%d", _beer.beerId]] atomically:NO];
    
    [imagePicker.imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [_beerSV setContentOffset:CGPointMake(_beerSV.frame.origin.x, _brewerName.frame.origin.y)];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [_beerSV setContentOffset:CGPointMake(_beerSV.frame.origin.x, _comment.frame.origin.y)];
}

@end
