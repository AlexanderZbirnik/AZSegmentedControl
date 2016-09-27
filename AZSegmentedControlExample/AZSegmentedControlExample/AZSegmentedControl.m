//
//  AZSegmentedControl.h
//  Version 1.0
//  Created by Alex Zbirnik on 25.08.16.
//  Updated by Alex Zbirnik on 27.09.16.
//  Copyright © 2016 Alex Zbirnik. All rights reserved.
//


#import "AZSegmentedControl.h"

static CGFloat const AZSegmentedControlDefaultFontSize = 12.f;
static CGFloat const AZSegmentedControlMinLabelHight = 21.f;

@interface AZSegmentedControl()

@property (assign, nonatomic) NSInteger previousSelectedSegmentIndex;

@end

@implementation AZSegmentedControl

- (instancetype) init
{
    self = [super init];
    if (self) {
        
        _secondTouch = NO;
        _font = [UIFont systemFontOfSize: AZSegmentedControlDefaultFontSize];
    }
    return self;
}

- (instancetype) initWithCoder: (NSCoder *) coder
{
    self = [super initWithCoder: coder];
    if (self) {

        _secondTouch = NO;
        _font = [UIFont systemFontOfSize:AZSegmentedControlDefaultFontSize];
    }
    return self;
}

- (instancetype) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    if (self) {
        
        _secondTouch = NO;
        _font = [UIFont systemFontOfSize: AZSegmentedControlDefaultFontSize];
    }
    return self;
}

- (void) didMoveToWindow {
    [super didMoveToWindow];
    
    self.previousSelectedSegmentIndex = self.selectedSegmentIndex;
}

- (void) setFont: (UIFont *) font {
    
    _font = font;
    
    [self setTitleTextAttributes: @{NSFontAttributeName: _font}
                        forState: UIControlStateNormal];

}

- (void)touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
    
    UITouch *anyTouch = [touches anyObject];
    
    _touchPoint = [anyTouch locationInView: self.superview];
    _secondTouch  = NO;
    
    [super touchesEnded: touches withEvent: event];
    
    if (self.previousSelectedSegmentIndex != self.selectedSegmentIndex) {
        
        _secondTouch = NO;
        
    } else {
        
        _secondTouch = YES;
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
    self.previousSelectedSegmentIndex = self.selectedSegmentIndex;
}

- (void) setImage: (UIImage *) image fromSide: (SegmentedImageSide) side horizontalOffSet: (CGFloat) hOffSet verticalOffSet: (CGFloat) vOffSet  andTitle: (NSString *) title forSegmentAtIndex: (NSUInteger) index {
    
    NSDictionary * attributes = @{NSFontAttributeName: _font};
    CGSize titleSize = [title sizeWithAttributes: attributes];
    
    if (titleSize.height < AZSegmentedControlMinLabelHight) {
        
        titleSize = CGSizeMake(titleSize.width, AZSegmentedControlMinLabelHight);
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    imageView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.attributedText = [[NSAttributedString alloc] initWithString: title attributes: attributes];
    label.backgroundColor = [UIColor clearColor];
    
    CGFloat viewWidth = image.size.width + titleSize.width + hOffSet;
    CGFloat viewHeight = titleSize.height;
    
    CGFloat labelAxisY = CGFLOAT_MIN;
    
    if (viewHeight < image.size.height + vOffSet) {
        
        viewHeight = image.size.height + vOffSet;
        labelAxisY = (viewHeight - titleSize.height) / 2.f;
    }
    
    UIView *view =
    [[UIView alloc] initWithFrame:CGRectMake(CGFLOAT_MIN, CGFLOAT_MIN,
                                             viewWidth, viewHeight)];
    
    view.backgroundColor = [UIColor clearColor];
    view.layer.masksToBounds = YES;
    
    if (side == SegmentedImageSideLeft) {
        
        imageView.frame = CGRectMake(CGFLOAT_MIN, vOffSet, image.size.width, image.size.height);
        label.frame = CGRectMake(image.size.width + hOffSet, labelAxisY, titleSize.width, titleSize.height);
        
    } else {
        
        label.frame = CGRectMake(CGFLOAT_MIN, labelAxisY, titleSize.width, titleSize.height);
        imageView.frame = CGRectMake(titleSize.width + hOffSet, vOffSet, image.size.width, image.size.height);
    }
    
    [label sizeThatFits: titleSize];
    
    [view addSubview: imageView];
    [view addSubview: label];
        
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.f);
    
    [view.layer renderInContext: UIGraphicsGetCurrentContext()];
    UIImage *segmentImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [self setImage: segmentImage forSegmentAtIndex: index];
}




@end
