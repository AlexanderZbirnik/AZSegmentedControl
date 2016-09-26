//
//  ViewController.m
//  AZSegmentedControlExample
//
//  Created by Alex Zbirnik on 24.09.16.
//  Copyright © 2016 none. All rights reserved.
//

#import "ViewController.h"
#import "AZSegmentedControl.h"
#import "PopoverViewController.h"

@interface ViewController () < PopoverViewControllerDelegate, UIPopoverPresentationControllerDelegate >

@property (weak, nonatomic) IBOutlet AZSegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UILabel *selectedLabel;
@property (weak, nonatomic) IBOutlet UILabel *tappedOnPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondTapLabel;

@property (strong, nonatomic) UIPopoverPresentationController *popoverPresentation;

@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    UIFont *font = [UIFont systemFontOfSize:14];
    
    [self.segmentedControl setFont:font];
    
    UIImage *firstImage     = [UIImage imageNamed:@"search"];
    NSString *firstTitle    = @"FirstTitle";
    
    [self.segmentedControl setImage: firstImage
                           fromSide: SegmentedImageSideLeft
                   horizontalOffSet: 3.f
                     verticalOffSet: 0.f
                           andTitle: firstTitle
                  forSegmentAtIndex: 0];
    
    [self setFourthSegmentWithTitle: @"FourthTitle"];
}

#pragma mark - Controller methods

- (void) setFourthSegmentWithTitle: (NSString *) title {
    
    UIImage *fourthImage = [UIImage imageNamed: @"arrow"];
    
    [self.segmentedControl setImage: fourthImage
                           fromSide: SegmentedImageSideRight
                   horizontalOffSet: 2.f
                     verticalOffSet: 8.f
                           andTitle: title
                  forSegmentAtIndex: 3];
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController *) controller {
    
    return UIModalPresentationNone;
}

#pragma mark - PopoverViewControllerDelegate

- (void) popoverViewController: (PopoverViewController *) popoverViewController selectedTitle: (NSString *) title {
    
    self.selectedLabel.text = title;
    
    [self setFourthSegmentWithTitle: title];
}

#pragma mark - Actions

- (IBAction) segmentedControlAction: (AZSegmentedControl *) sender {
    
    if (sender.secondTouch != YES) {
        
        self.secondTapLabel.text = @"First";
        
    } else {
        
        self.secondTapLabel.text = @"Second";
    }
    
    self.tappedOnPointLabel.text =
    [NSString stringWithFormat:@"(%.2f, %.2f)", sender.touchPoint.x, sender.touchPoint.y];
    
    if (sender.selectedSegmentIndex == 3 && sender.secondTouch == YES) {
        
        PopoverViewController *popover =
        [self.storyboard instantiateViewControllerWithIdentifier:@"PopoverViewController"];
        
        popover.preferredContentSize = CGSizeMake(300, 300);
        popover.delegate = self;
        
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:popover];

        navigation.modalPresentationStyle = UIModalPresentationPopover;
        navigation.navigationBarHidden = YES;
        
        self.popoverPresentation = navigation.popoverPresentationController;
        self.popoverPresentation.delegate = self;
        self.popoverPresentation.sourceView = self.view;
        
        CGRect frame =
        CGRectMake(sender.touchPoint.x - 5, sender.touchPoint.y - 5, 10, 10);
        
        self.popoverPresentation.sourceRect = frame;
        
        [self presentViewController:navigation animated:YES completion:nil];
    }
}


@end















