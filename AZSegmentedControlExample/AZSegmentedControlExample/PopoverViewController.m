//
//  PopoverViewController.m
//  AZSegmentedControlExample
//
//  Created by Alex Zbirnik on 26.09.16.
//  Copyright © 2016 none. All rights reserved.
//

#import "PopoverViewController.h"

@interface PopoverViewController () < UIPickerViewDataSource, UIPickerViewDelegate >

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *titles;

@end

@implementation PopoverViewController

- (instancetype) initWithCoder: (NSCoder *) coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        self.titles = @[@"FifthTitle", @"SixthTitle", @"SeventhTitle"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UIPickerViewDataSource

- (NSInteger) numberOfComponentsInPickerView: (UIPickerView *) pickerView {
    
    return 1;
}

- (NSInteger) pickerView: (UIPickerView *) pickerView numberOfRowsInComponent: (NSInteger) component {
    
    return self.titles.count;
}

#pragma mark - UIPickerViewDelegate

- (nullable NSString *) pickerView: (UIPickerView *) pickerView titleForRow: (NSInteger) row forComponent: (NSInteger) component {
    
    return [self.titles objectAtIndex:row];
}

- (void)pickerView: (UIPickerView *) pickerView didSelectRow: (NSInteger) row inComponent: (NSInteger) component {
    
    NSString *title = [self.titles objectAtIndex:row];
    
    [self.delegate popoverViewController:self selectedTitle: title];
}



@end
