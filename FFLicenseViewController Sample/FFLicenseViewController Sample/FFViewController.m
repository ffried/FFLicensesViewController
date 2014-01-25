//
//  FFViewController.m
//  FFLicenseViewController Sample
//
//  Created by Florian Friedrich on 25.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFViewController.h"
#import "FFLicensesViewController.h"

@implementation FFViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    if ([segue.identifier isEqualToString:@"showLicenses"]) {
        NSBundle *bundle = [NSBundle mainBundle];
        BOOL iOS7 = [UIDevice currentDevice].systemVersion.floatValue >= 7.0f;
        FFLicense *fullscreenConstraint = [FFLicense licenseWithTitle:@"NSLayoutConstraint+FullscreenConstraints" filePath:[bundle URLForResource:@"NSLayoutConstraint+FullscreenConstraints_License" withExtension:((iOS7) ? @"rtf" : @"txt")]];
        FFLicense *animatedTableUpdate = [FFLicense licenseWithTitle:@"UITableView+AnimatedArrayUpdate" filePath:[bundle URLForResource:@"UITableView+AnimatedArrayUpdate_License" withExtension:@"txt"]];
        
        FFLicensesViewController *lvc = segue.destinationViewController;
        lvc.licenses = @[fullscreenConstraint, animatedTableUpdate];
    }
}

@end
