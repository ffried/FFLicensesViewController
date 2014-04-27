//
//  FFLicense.h
//
//  Created by Florian Friedrich on 25.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>

@class FFLicense;
/**
 *  Creates an FFLicense with a license file within the apps bundle ([NSBundle mainBundle]).
 *  @param title     The title of the license as well as the license file.
 *  @param extension The extension of the license file.
 *  @return A FFLicense instance with the licenseFilePath set to the path of the file (title.extension) in the main bundle.
 */
extern FFLicense *FFLicenseInAppBundle(NSString *title, NSString *extension);

/**
 *  Represents a license.
 */
@interface FFLicense : NSObject <NSCopying, NSSecureCoding>

/**
 *  The title of the licensed object.
 */
@property (nonatomic, strong) NSString *title;
/**
 *  The path of the license file.
 *  Should be a local URL. Either in the app's bundle or documents folder.
 */
@property (nonatomic, strong) NSURL *licenseFilePath;
/**
 *  The string content.
 *  If the licenseFilePath points to a Rich Text Format file this will be an attributed string on iOS 7+.
 *  On iOS 6 and below this is always a normal NSString.
 */
@property (nonatomic, strong, readonly) NSAttributedString *licenseContent;

/**
 *  Convenience class method for creating new license instances.
 *  @param title    The title of the license.
 *  @param filePath The path to the license file.
 *  @return A new instance of FFLicense with the title and licenseFilePath properties set.
 */
+ (instancetype)licenseWithTitle:(NSString *)title filePath:(NSURL *)filePath;
/**
 *  Creates a new FFLicense instance with a title and filePath given.
 *  @param title    The title of the license.
 *  @param filePath The path to the license file.
 *  @return A new instance of FFLicense with the title and licenseFilePath properties set.
 */
- (instancetype)initWithTitle:(NSString *)title filePath:(NSURL *)filePath;

@end
