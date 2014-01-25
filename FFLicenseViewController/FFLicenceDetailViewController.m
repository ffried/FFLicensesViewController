//
//  FFLicenceDetailViewController.m
//
//  Created by Florian Friedrich on 25.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFLicenceDetailViewController.h"
#import "NSLayoutConstraint+FullscreenConstraints.h"

@interface FFLicenceDetailViewController ()

@property (nonatomic, strong) UITextView *licenseTextView;

- (void)setContents;

@end


@implementation FFLicenceDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.licenseTextView = [[UITextView alloc] init];
    self.licenseTextView.translatesAutoresizingMaskIntoConstraints = NO;
    self.licenseTextView.editable = NO;
    self.licenseTextView.dataDetectorTypes = UIDataDetectorTypeNone;
    
    [NSLayoutConstraint setupSubview:self.licenseTextView fullscreenInSuperview:self.view];
}

- (void)setContents
{
    self.title = self.license.title;
    self.licenseTextView.text = self.license.licenseContent;
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
