//
//  QuiltViewController.h
//  iPhoneQuilter
//
//  Created by Justin Beck on 10/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AssetsLibrary/AssetsLibrary.h"

@interface QuiltViewController : UITableViewController
{
    NSMutableArray *images;
    ALAssetsLibrary *library;
}

@end
