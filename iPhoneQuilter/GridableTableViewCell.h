//
//  GridableTableViewCell.h
//  iPhoneQuilter
//
//  Created by Justin Beck on 10/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridableTableViewCell : UITableViewCell {
    NSMutableArray *columns;
}

- (void)addColumn:(CGFloat)position;

@end
