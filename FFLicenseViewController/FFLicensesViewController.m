//
//  FFLicensesViewController.m
//
//  Created by Florian Friedrich on 25.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFLicensesViewController.h"
#import "UITableView+AnimatedArrayUpdate.h"
#import "FFLicenseDetailViewController.h"

static NSString *const FFLicenseCellIdentifier = @"FFLicenseCellIdentifier";

@implementation FFLicensesViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FFLicenseCellIdentifier];
    
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // iOS 7 interactive dismiss fix
    if (self.clearsSelectionOnViewWillAppear && [UIDevice currentDevice].systemVersion.floatValue >= 7.0f) {
        NSIndexPath *selectedIP = [self.tableView indexPathForSelectedRow];
        if (selectedIP) [self.tableView deselectRowAtIndexPath:selectedIP animated:animated];
    }
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.licenses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FFLicenseCellIdentifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    FFLicense *license = self.licenses[indexPath.row];
    cell.textLabel.text = license.title;
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FFLicense *license = self.licenses[indexPath.row];
    FFLicenseDetailViewController *detailVC = [[FFLicenseDetailViewController alloc] init];
    detailVC.license = license;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - Properties
- (void)setLicenses:(NSArray *)licenses
{
    if (![licenses isEqual:_licenses]) {
        NSArray *previousLicenses = _licenses;
        _licenses = licenses;
        if ([self isViewLoaded]) {
            [self.tableView updateFromArray:previousLicenses toArray:_licenses inSection:0 animated:YES];
        }
    }
}

@end
