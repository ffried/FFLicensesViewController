//
//  FFLicense.m
//
//  Created by Florian Friedrich on 25.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFLicense.h"

extern FFLicense *FFLicenseInAppBundle(NSString *title, NSString *extension) {
    return [FFLicense licenseWithTitle:title
                              filePath:[[NSBundle mainBundle] URLForResource:title
                                                               withExtension:extension]];
}

@implementation FFLicense
@synthesize licenseContent = _licenseContent;

#pragma mark - Initializer
+ (instancetype)licenseWithTitle:(NSString *)title filePath:(NSURL *)filePath
{
    return [[[self class] alloc] initWithTitle:title filePath:filePath];
}

- (instancetype)initWithTitle:(NSString *)title filePath:(NSURL *)filePath
{
    self = [super init];
    if (self) {
        self.title = title;
        self.licenseFilePath = filePath;
    }
    return self;
}

- (instancetype)init { return [self initWithTitle:nil filePath:nil]; }

#pragma mark - Properties
- (NSAttributedString *)licenseContent
{
    if (!_licenseContent) {
        __autoreleasing NSError *error = nil;
        NSAttributedString *content;
        if ([NSAttributedString instancesRespondToSelector:@selector(initWithFileURL:options:documentAttributes:error:)]) {
            content = [[NSAttributedString alloc] initWithFileURL:self.licenseFilePath
                                                          options:nil
                                               documentAttributes:nil
                                                            error:&error];
        } else {
            content = [[NSAttributedString alloc] initWithString:[NSString stringWithContentsOfURL:self.licenseFilePath
                                                                                          encoding:NSUTF8StringEncoding
                                                                                             error:&error]];
        }
        if (error) {
            NSLog(@"FFLicense: An error occured while loading license contents from file: %@", error);
        }
        _licenseContent = content;
    }
    return _licenseContent;
}

- (void)setLicenseFilePath:(NSURL *)licenseFilePath
{
    if (![licenseFilePath isEqual:_licenseFilePath]) {
        _licenseContent = nil;
        _licenseFilePath = licenseFilePath;
    }
}

#pragma mark - Equality
- (NSUInteger)hash
{
    return [self.title hash] ^ [self.licenseFilePath hash];
}

- (BOOL)isEqual:(id)object
{
    if (!object) return NO;
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    FFLicense *lObject = (FFLicense *)object;
    return [lObject.title isEqualToString:self.title] && [lObject.licenseFilePath isEqual:self.licenseFilePath];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    NSString *title = [self.title copyWithZone:zone];
    NSURL *licenseFilePath = [self.licenseFilePath copyWithZone:zone];
    return [[self class] licenseWithTitle:title filePath:licenseFilePath];
}

#pragma mark - NSSecureCoding
+ (BOOL)supportsSecureCoding { return YES; }

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.licenseFilePath forKey:@"licenseFilePath"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSString *title = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"title"];
    NSURL *licenseFilePath = [aDecoder decodeObjectOfClass:[NSURL class] forKey:@"licenseFilePath"];
    return [self initWithTitle:title filePath:licenseFilePath];
}

@end
