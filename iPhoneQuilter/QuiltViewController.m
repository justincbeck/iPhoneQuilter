//
//  QuiltViewController.m
//  iPhoneQuilter
//
//  Created by Justin Beck on 10/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QuiltViewController.h"
#import "GridableTableViewCell.h"
#import "TabBarController.h"

@implementation QuiltViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 13;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    struct CGRect bounds = [tableView bounds];
    float height = bounds.size.height;
    
    return (height / 13.0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    
    GridableTableViewCell *cell = [[GridableTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    struct CGRect bounds = [tableView bounds];
    float width = bounds.size.width;
    
    float leftEdge = 0;
    float colWidth = width / 9.0;
    
    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:(9.0 * 13.0)];
    NSMutableArray *groups = [[NSMutableArray alloc] init];

    void (^populateImages)
    (ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            [groups addObject:group];
            NSLog(@"Number of assets in group: %d", [group numberOfAssets]);
        }
    };
                                         
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:populateImages failureBlock:^(NSError *error) {
        NSLog(@"Failure");
    }];
    
    for (int i = 0; i < 9; i++) {
        UIImage *image = [UIImage imageNamed:@"peanut-butter-jelly-time.gif"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftEdge, 0, colWidth, height)];
        imageView.image = image;
        
        [[cell contentView] addSubview:imageView];
        leftEdge += colWidth;
        [cell addColumn:leftEdge];
    }
    
    return cell;
}
                                            
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UITableView *quilt = [[UITableView alloc] initWithFrame:CGRectZero];
    [quilt setBackgroundColor:[UIColor whiteColor]];
    
    [self setTableView:quilt];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [(TabBarController *) [self parentViewController] hideTabBar:((TabBarController *) [self parentViewController])];
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
