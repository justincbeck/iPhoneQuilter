//
//  TestView.m
//  iPhoneQuilter
//
//  Created by Justin Beck on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "QuiltViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
/*
- (void)loadView
{
}
*/

- (void) showCameraUI
{
    [self startCameraControllerFromViewController: self usingDelegate: self];
}

- (BOOL)startCameraControllerFromViewController: (UIViewController *) controller usingDelegate: (id <UIImagePickerControllerDelegate, UINavigationControllerDelegate>) delegate
{
    if (([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera] == NO) || (delegate == nil) || (controller == nil))
        return NO;

    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [controller presentModalViewController: cameraUI animated: YES];
    return YES;
}

- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
    
    // Handle a still image capture
    if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo)
    {
        editedImage = (UIImage *) [info objectForKey: UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey: UIImagePickerControllerOriginalImage];
        
        if (editedImage)
        {
            imageToSave = editedImage;
        }
        else
        {
            imageToSave = originalImage;
        }
        
        // Save the new image (original or edited) to the Camera Roll
        UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
    }
    
    // Handle a movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo)
    {
        
        NSString *moviePath = [[info objectForKey: UIImagePickerControllerMediaURL] path];
        
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath))
        {
            UISaveVideoAtPathToSavedPhotosAlbum (moviePath, nil, nil, nil);
        }
    }
    
    [[picker parentViewController] dismissModalViewControllerAnimated: YES];
}

- (void)showQuilt
{
    [((UINavigationController *) [self parentViewController]) pushViewController:[[QuiltViewController alloc] init] animated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    UILabel *phooeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 30)];
    phooeyLabel.text = @"Phooey";
    phooeyLabel.shadowColor = [UIColor blackColor];
    phooeyLabel.shadowOffset = CGSizeMake (1, 1);
    phooeyLabel.textColor = [UIColor lightGrayColor];
    phooeyLabel.textAlignment= UITextAlignmentCenter;
    [self.view addSubview:phooeyLabel];
    
    UIButton *showQuilt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [showQuilt addTarget:self action:@selector(showQuilt) forControlEvents:UIControlEventTouchDown];
    [showQuilt setTitle:@"Phooey" forState:UIControlStateNormal];
    showQuilt.frame = CGRectMake(100, 10, 100, 30);
    [self.view addSubview:showQuilt];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 100, 30)];
    label.text = @"Camera";
    label.shadowColor = [UIColor blackColor];
    label.shadowOffset = CGSizeMake (1, 1);
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment= UITextAlignmentCenter;
    [self.view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(showCameraUI) forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"Camera" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 50, 100, 30);
    [self.view addSubview:button];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
