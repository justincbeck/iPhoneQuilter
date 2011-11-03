//
//  TestView.h
//  iPhoneQuilter
//
//  Created by Justin Beck on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@interface SettingsViewController: UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

-(BOOL) startCameraControllerFromViewController: UIViewController usingDelegate: UIViewController;
-(void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info;
@end
