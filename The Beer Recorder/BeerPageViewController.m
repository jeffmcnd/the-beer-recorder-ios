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
    
    CGRect screen = [[UIScreen mainScreen] applicationFrame];
    
    _beerSV.frame = CGRectMake(0, 0, screen.size.width, screen.size.height + 20);
    _beerSV.contentSize = _container.frame.size;
    
    UITapGestureRecognizer * viewTap = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(dismissKeyboard)];
    [_container addGestureRecognizer:viewTap];
    
    UIImage * img = [UIImage imageWithContentsOfFile:[DOC_DIR stringByAppendingPathComponent:[NSString stringWithFormat:@"beer%d", _beer.beerId]]];
    
    if(img == nil) {
        img = [UIImage imageNamed:@"no_beer.png"];
    }
    
    [_picture setImage:img];
    
    [_navItem setTitle:_beer.beerName];
    [_brewerName setText:_beer.brewerName];
    [_appearanceSlider setValue:_beer.appearance];
    [_aromaSlider setValue:_beer.aroma];
    [_mouthFeelSlider setValue:_beer.mouthFeel];
    [_maltHopSlider setValue:_beer.maltHop];
    [_flavourSlider setValue:_beer.flavour];
    [_overallSlider setValue:_beer.overall];
    [_comment setText:_beer.comment];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardSize:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)keyboardSize:(NSNotification*)notification {
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    keyboardHeight = [keyboardFrameBegin CGRectValue].size.height;
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
    NSLog(@"image size: %f, %f", _picture.frame.size.width, _picture.frame.size.height);
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Choose a Photo", @"Take a Photo", nil];
    actionSheet.actionSheetStyle = UIBarStyleBlackTranslucent;
    [actionSheet showFromToolbar:self.navigationController.toolbar];
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
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    switch(buttonIndex) {
        case 0: {
            _picker = [[GKImagePicker alloc] init];
            [_picker setCropSize:CGSizeMake(_picture.frame.size.width, _picture.frame.size.height)];
            [_picker setDelegate:self];
            [self.navigationController presentViewController:_picker.imagePickerController animated:NO completion:nil];
            break;
        }
        case 1: {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    
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

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    CGRect rect = _beerSV.frame;
    rect.origin.y = -keyboardHeight;
    _beerSV.frame = rect;
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
    CGRect rect = _beerSV.frame;
    rect.origin.y = 0;
    _beerSV.frame = rect;
}

@end
