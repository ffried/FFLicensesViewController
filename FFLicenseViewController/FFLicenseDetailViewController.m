//
//  FFLicenseDetailViewController.m
//
//  Created by Florian Friedrich on 25.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFLicenseDetailViewController.h"
#import "NSLayoutConstraint+FullscreenConstraints.h"
#import "FFLicense.h"

@interface FFLicenseDetailViewController ()

@property (nonatomic, strong) UITextView *licenseTextView;

- (void)setContents;

@end


@implementation FFLicenseDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.licenseTextView = [[UITextView alloc] init];
    self.licenseTextView.editable = NO;
    self.licenseTextView.dataDetectorTypes = UIDataDetectorTypeNone;
    self.licenseTextView.alwaysBounceVertical = YES;
    self.licenseTextView.backgroundColor = [UIColor clearColor];
    
    [NSLayoutConstraint setupSubview:self.licenseTextView fullscreenInSuperview:self.view];
    
    if (self.license) {
        [self setContents];
    }
}

- (void)setContents
{
    self.title = self.license.title;
    self.licenseTextView.attributedText = self.license.licenseContent;
}

#pragma mark - Setters
- (void)setLicense:(FFLicense *)license
{
    if (![license isEqual:_license]) {
        _license = license;
        [self setContents];
    }
}

@end
