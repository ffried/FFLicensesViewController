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

- (void)updateFromArray:(NSArray *)oldArray toArray:(NSArray *)newArray inSection:(NSUInteger)section animated:(BOOL)animated
{
    UITableViewRowAnimation animation = (animated) ? UITableViewRowAnimationAutomatic : UITableViewRowAnimationNone;
    
    NSMutableArray *insertAndRemoveResult = [[NSMutableArray alloc] init];
    [insertAndRemoveResult addObjectsFromArray:oldArray];
    
    [self beginUpdates];
    
    /* remove cells */
    NSMutableArray *toRemovePaths = [[NSMutableArray alloc] init];
    for (id obj in oldArray) {
        if (![newArray containsObject:obj]) {
            NSIndexPath *cellPath = [NSIndexPath indexPathForRow:[oldArray indexOfObject:obj] inSection:section];
            [insertAndRemoveResult removeObject:obj];
            [toRemovePaths addObject:cellPath];
        }
    }
    [self deleteRowsAtIndexPaths:toRemovePaths withRowAnimation:animation];
    
    
    /* add cells */
    NSMutableArray *toAddPaths = [[NSMutableArray alloc] init];
    for (id obj in newArray) {
        if (![oldArray containsObject:obj]) {
            NSUInteger newIndex = [newArray indexOfObject:obj];
            NSIndexPath *cellPath = [NSIndexPath indexPathForRow:newIndex inSection:section];
            [insertAndRemoveResult insertObject:obj atIndex:newIndex];
            [toAddPaths addObject:cellPath];
        }
    }
    [self insertRowsAtIndexPaths:toAddPaths withRowAnimation:animation];
    [self endUpdates];
    

    [self beginUpdates];
    /* move cells */
    for (id obj in newArray) {
        if ([oldArray containsObject:obj]) {
            NSIndexPath *newPath = [NSIndexPath indexPathForRow:[newArray indexOfObject:obj] inSection:section];
            NSIndexPath *oldPath = [NSIndexPath indexPathForRow:[insertAndRemoveResult indexOfObject:obj] inSection:section];
            if (newPath.row != oldPath.row) {
                [self moveRowAtIndexPath:oldPath toIndexPath:newPath];
            }
        }
    }
    [self endUpdates];
}

@end
