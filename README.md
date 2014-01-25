# FFLicensesViewController


Easily display third-party licenses in your app.

## How it works

Create an instance of `FFLicensesViewController` as `rootViewController` of a `UINavigationController`:

	FFLicensesViewController *licensesViewController = [[FFLicensesViewController alloc] init];
	UINavigationController *licensesNavigationController = [[UINavigationController alloc] initWithRootViewController:licensesViewController];

Create your `FFLicense` instances:

	NSBundle *bundle = [NSBundle mainBundle];
	BOOL iOS7 = [UIDevice currentDevice].systemVersion.floatValue >= 7.0f;
	FFLicense *fullscreenConstraint = [FFLicense licenseWithTitle:@"NSLayoutConstraint+FullscreenConstraints" filePath:[bundle URLForResource:@"NSLayoutConstraint+FullscreenConstraints_License" withExtension:((iOS7) ? @"rtf" : @"txt")]];
	FFLicense *animatedTableUpdate = [FFLicense licenseWithTitle:@"UITableView+AnimatedArrayUpdate" filePath:[bundle URLForResource:@"UITableView+AnimatedArrayUpdate_License" withExtension:@"txt"]];

Set the `licenses` property of the `FFLicensesViewController` and present it (modally in this case):

	licensesViewController.licenses = @[fullscreenConstraint, animatedTableUpdate];
	[self presentViewController:licensesViewController animated:YES completion:nil];

If you already have a `UINavigationController` you can of course just create an instance of `FFLicensesViewController`, set the `licenses` property and push it onto the navigation stack:

	FFLicensesViewController *licensesViewController = [[FFLicensesViewController alloc] init];
	licensesViewController.licenses = @[fullscreenConstraint, animatedTableUpdate];
	[self.navigationController pushViewController:licensesViewController animated:YES];

Also have a look at the sample project.

# Some notes about the license files

As of iOS 7 you can use rtf files and it will turn them into `NSAttributedString`.
Although the `FFLicense` always returns `NSAttributedString` they only have attributes on iOS 7+. On iOS 6 it will just load a normal string and turn it into a `NSAttributedString` without any attributes.
As seen in the example above (as well as the sample project) you can just set different file extensions depending on which iOS version you run on. This, however, requires two versions of each license file.

# License

This library is released under MIT. For more details see the LICENSE file.
