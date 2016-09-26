//
//  AZSegmentedControl.h
//
//  Created by Alex Zbirnik on 25.08.16.
//  Copyright © 2016 Alex Zbirnik. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    SegmentedImageSideLeft  = 0,
    SegmentedImageSideRight = 1
    
} SegmentedImageSide;

//IB_DESIGNABLE
@interface AZSegmentedControl : UISegmentedControl

@property (readonly, nonatomic) BOOL secondTouch;
@property (readonly, nonatomic) CGPoint touchPoint;
@property (readonly, nonatomic) UIFont *font;

- (void) setFont: (UIFont *) font;

- (void)setImage:(UIImage *) image fromSide: (SegmentedImageSide) side horizontalOffSet: (CGFloat) hOffSet verticalOffSet: (CGFloat) vOffSet  andTitle: (NSString *) title forSegmentAtIndex: (NSUInteger) index;

@end
