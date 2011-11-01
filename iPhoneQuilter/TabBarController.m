//
//  TabViewController.m
//  iPhoneQuilter
//
//  Created by Justin Beck on 10/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TabBarController.h"
#import "DataEntryViewController.h"
#import "QuiltViewController.h"

@implementation TabBarController

- (id)init
{
    self = [super init];
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

- (void)hideTabBar:(UITabBarController *) tabBarController
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    for(UIView *view in tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake([view frame].origin.x, 480, [view frame].size.width, [view frame].size.height)];
        }
        else
        {
            [view setFrame:CGRectMake([view frame].origin.x, [view frame].origin.y, [view frame].size.width, 480)];
        }
    }
    
    [UIView commitAnimations];
}

- (void)showTabBar:(UITabBarController *) tabBarController
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    for(UIView *view in tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake([view frame].origin.x, 431, [view frame].size.width, [view frame].size.height)];
        }
        else
        {
            [view setFrame:CGRectMake([view frame].origin.x, [view frame].origin.y, [view frame].size.width, 431)];
        }
    }
    
    [UIView commitAnimations]; 
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    DataEntryViewController *dataEntryViewController = [[DataEntryViewController alloc] init];
    QuiltViewController *quiltViewController = [[QuiltViewController alloc] init];
    
    self.viewControllers = [[NSArray alloc] initWithObjects:dataEntryViewController, quiltViewController, nil];
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
