//
//  UITableView+AnimatedArrayUpdate.m
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

#import "UITableView+AnimatedArrayUpdate.h"

@implementation UITableView (AnimatedArrayUpdate)

- (void)updateFromSectionsArray:(NSArray *)oldSections
                toSectionsArray:(NSArray *)newSections
                       animated:(BOOL)animated
{
    UITableViewRowAnimation animation = (animated) ? UITableViewRowAnimationAutomatic : UITableViewRowAnimationNone;
    
    /* If oldSections is empty or nil, we just insert the new sections */
    if (![oldSections count]) {
        NSMutableIndexSet *toAddSections = [NSMutableIndexSet indexSet];
        for (id<UITableViewSectionObject> obj in newSections) {
            NSUInteger idx = [newSections indexOfObject:obj];
            [toAddSections addIndex:idx];
        }
        [self beginUpdates];
        [self insertSections:[toAddSections copy] withRowAnimation:animation];
        [self endUpdates];
        return;
    }
    
    NSMutableArray *insertAndRemoveResult = [NSMutableArray arrayWithArray:oldSections];
    
    [self beginUpdates];
    
    /* remove sections */
    NSMutableIndexSet *toRemoveSections = [NSMutableIndexSet indexSet];
    for (id<UITableViewSectionObject> obj in oldSections) {
        if (![newSections containsObject:obj]) {
            NSUInteger idx = [oldSections indexOfObject:obj];
            [insertAndRemoveResult removeObject:obj];
            [toRemoveSections addIndex:idx];
        }
    }
    [self deleteSections:[toRemoveSections copy] withRowAnimation:animation];
    
    
    /* add sections */
    NSMutableIndexSet *toAddSections = [NSMutableIndexSet indexSet];
    for (id<UITableViewSectionObject> obj in newSections) {
        if (![oldSections containsObject:obj]) {
            NSUInteger idx = [newSections indexOfObject:obj];
            [insertAndRemoveResult insertObject:obj atIndex:idx];
            [toAddSections addIndex:idx];
        }
    }
    [self insertSections:[toAddSections copy] withRowAnimation:animation];
    [self endUpdates];
    
    
    [self beginUpdates];
    /* move and update sections */
    for (id<UITableViewSectionObject> obj in newSections) {
        if ([oldSections containsObject:obj]) {
            NSUInteger oldIndex = [insertAndRemoveResult indexOfObject:obj];
            NSUInteger newIndex = [newSections indexOfObject:obj];
            if (newIndex != oldIndex) {
                [self moveSection:oldIndex toSection:newIndex];
            }
        }
    }
    [self endUpdates];
    
    
    /* update existing sections */
    for (id<UITableViewSectionObject> obj in newSections) {
        if ([oldSections containsObject:obj]) {
            NSUInteger section = [newSections indexOfObject:obj];
            [self updateFromArray:[oldSections[section] rows] toArray:[obj rows] inSection:section animated:animated];
        }
    }
}

#pragma mark - Row updates
- (void)insertAndDeleteRowsFromArray:(NSArray *)oldArray
                             toArray:(NSArray *)newArray
                              result:(NSMutableArray *)insertAndRemoveResult
                           inSection:(NSUInteger)section
                       withAnimation:(UITableViewRowAnimation)animation
{
    /* remove cells */
    NSMutableArray *toRemovePaths = [NSMutableArray array];
    for (id obj in oldArray) {
        if (![newArray containsObject:obj]) {
            NSIndexPath *cellPath = [NSIndexPath indexPathForRow:[oldArray indexOfObject:obj]
                                                       inSection:section];
            [insertAndRemoveResult removeObject:obj];
            [toRemovePaths addObject:cellPath];
        }
    }
    [self deleteRowsAtIndexPaths:[toRemovePaths copy] withRowAnimation:animation];
    
    
    /* add cells */
    NSMutableArray *toAddPaths = [NSMutableArray array];
    for (id obj in newArray) {
        if (![oldArray containsObject:obj]) {
            NSUInteger newIndex = [newArray indexOfObject:obj];
            NSIndexPath *cellPath = [NSIndexPath indexPathForRow:newIndex inSection:section];
            [insertAndRemoveResult insertObject:obj atIndex:newIndex];
            [toAddPaths addObject:cellPath];
        }
    }
    [self insertRowsAtIndexPaths:[toAddPaths copy] withRowAnimation:animation];
}

- (void)updateFromArray:(NSArray *)oldArray
                toArray:(NSArray *)newArray
              inSection:(NSUInteger)section
               animated:(BOOL)animated
{
    UITableViewRowAnimation animation = (animated) ? UITableViewRowAnimationAutomatic : UITableViewRowAnimationNone;
    
    /* If oldArray is empty or nil, we just insert the new rows */
    if (![oldArray count]) {
        NSMutableArray *toAddPaths = [NSMutableArray array];
        for (id obj in newArray) {
            NSUInteger idx = [newArray indexOfObject:obj];
            NSIndexPath *cellPath = [NSIndexPath indexPathForRow:idx inSection:section];
            [toAddPaths addObject:cellPath];
        }
        [self beginUpdates];
        [self insertRowsAtIndexPaths:[toAddPaths copy] withRowAnimation:animation];
        [self endUpdates];
        return;
    }
    
    NSMutableArray *insertAndRemoveResult = [NSMutableArray arrayWithArray:oldArray];
    
    [self beginUpdates];
    
    /* remove cells */
    NSMutableArray *toRemovePaths = [NSMutableArray array];
    for (id obj in oldArray) {
        if (![newArray containsObject:obj]) {
            NSIndexPath *cellPath = [NSIndexPath indexPathForRow:[oldArray indexOfObject:obj]
                                                       inSection:section];
            [insertAndRemoveResult removeObject:obj];
            [toRemovePaths addObject:cellPath];
        }
    }
    [self deleteRowsAtIndexPaths:[toRemovePaths copy] withRowAnimation:animation];
    
    
    /* add cells */
    NSMutableArray *toAddPaths = [NSMutableArray array];
    for (id obj in newArray) {
        if (![oldArray containsObject:obj]) {
            NSUInteger newIndex = [newArray indexOfObject:obj];
            NSIndexPath *cellPath = [NSIndexPath indexPathForRow:newIndex inSection:section];
            [insertAndRemoveResult insertObject:obj atIndex:newIndex];
            [toAddPaths addObject:cellPath];
        }
    }
    [self insertRowsAtIndexPaths:[toAddPaths copy] withRowAnimation:animation];
    [self endUpdates];
    

    [self beginUpdates];
    /* move cells */
    for (id obj in newArray) {
        if ([oldArray containsObject:obj]) {
            NSIndexPath *newPath = [NSIndexPath indexPathForRow:[newArray indexOfObject:obj]
                                                      inSection:section];
            NSIndexPath *oldPath = [NSIndexPath indexPathForRow:[insertAndRemoveResult indexOfObject:obj]
                                                      inSection:section];
            if (newPath.row != oldPath.row) {
                [self moveRowAtIndexPath:oldPath toIndexPath:newPath];
            }
        }
    }
    [self endUpdates];
}

@end
