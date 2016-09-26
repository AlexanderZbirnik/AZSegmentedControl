//
//  PopoverViewController.h
//  AZSegmentedControlExample
//
//  Created by Alex Zbirnik on 26.09.16.
//  Copyright © 2016 none. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopoverViewControllerDelegate;

@interface PopoverViewController : UIViewController

@property (weak, nonatomic) id < PopoverViewControllerDelegate > delegate;

@end

@protocol PopoverViewControllerDelegate

@required

- (void) popoverViewController: (PopoverViewController *) popoverViewController selectedTitle: (NSString *) title;


@end
