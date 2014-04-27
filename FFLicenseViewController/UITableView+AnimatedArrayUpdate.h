//
//  UITableView+AnimatedArrayUpdate.h
//
//  Created by Florian Friedrich on 31.10.13.
//  Copyright (c) 2013 Florian Friedrich. All rights reserved.
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
#import <UIKit/UIKit.h>

@protocol UITableViewSectionObject <NSObject>
@property (nonatomic, strong) NSArray *rows;
@end

@interface UITableView (AnimatedArrayUpdate)

/**
 *  Updates the tableview's sections and their rows from an oldSectionsArray to a newSectionsArray animated or not.
 *  The array arguments must each contain an object which conforms to the UITableViewSectionObject protocol.
 *  The data source array has to be set to the new array before calling this method.
 *  @param oldSections The currently shown sections.
 *  @param newSections The new sections.
 *  @param animated    Whether or not the update should be animated.
 */
- (void)updateFromSectionsArray:(NSArray *)oldSections
                toSectionsArray:(NSArray *)newSections
                       animated:(BOOL)animated;

/**
 *  Updates the tableview from an oldArray to a newArray in a given section animated or not.
 *  The data source array has to be set to the new array before calling this method.
 *  @param oldArray The currently displayed data source array.
 *  @param newArray The new data source array.
 *  @param section  The section to update.
 *  @param animated Whether or not the update should be animated.
 */
- (void)updateFromArray:(NSArray *)oldArray
                toArray:(NSArray *)newArray
              inSection:(NSUInteger)section
               animated:(BOOL)animated;

@end