//
//  TKController.m
//  TableKitSample
//
//  Created by Sergey Nikitenko on 4/29/12.
//  Copyright (c) 2012 Sergey Nikitenko. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "TKController.h"
#import "TKCellProtocol.h"
#import "TKCellView.h"
#import "TKSection.h"

@implementation TKController
@synthesize sections;

- (void)dealloc
{
    [sections release];
    [super dealloc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [sections count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return [[sections objectAtIndex:section] headerHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return [[sections objectAtIndex:section] footerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[sections objectAtIndex:section] headerView];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[sections objectAtIndex:section] footerView];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[sections objectAtIndex:section] headerTitle];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [[sections objectAtIndex:section] footerTitle];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[sections objectAtIndex:section] cellCount];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[[sections objectAtIndex:indexPath.section] cellAtIndex:indexPath.row] cellHeightForTableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[sections objectAtIndex:indexPath.section] tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    [[sections objectAtIndex:newIndexPath.section] tableView:tableView didSelectCellWithIndex:newIndexPath.row];
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [[sections objectAtIndex:indexPath.section] tableView:tableView accessoryButtonTappedForCellWithIndex:indexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [[sections objectAtIndex:indexPath.section] allowsReorderingDuringEditing];
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
	if(![[sections objectAtIndex:proposedDestinationIndexPath.section] allowsReorderingDuringEditing])
	{
		int dir = sourceIndexPath.section < proposedDestinationIndexPath.section ? -1 : 1; 
		int i = proposedDestinationIndexPath.section + dir;
		while ( i!=sourceIndexPath.section && [[sections objectAtIndex:i] allowsReorderingDuringEditing] )
		{
			i+=dir;
		}
		int row = dir > 0 ? 0 : [[sections objectAtIndex:i] cellCount]-1;
		return [NSIndexPath indexPathForRow:row inSection:i];
	}
	
    return proposedDestinationIndexPath;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
	TKSection* sourceSection = [sections objectAtIndex:sourceIndexPath.section];
	id<TKCellProtocol> cell = [[sourceSection cellAtIndex:sourceIndexPath.row] retain];
	[sourceSection removeCellAtIndex:sourceIndexPath.row];
	TKSection* destinationSection = [sections objectAtIndex:destinationIndexPath.section];
	[destinationSection insertCell:cell atIndex:destinationIndexPath.row];
	[cell release];
}


- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	return ![[sections objectAtIndex:indexPath.section] preventIndentationDuringEditing];
}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	TKSection* section = [sections objectAtIndex:indexPath.section];
	if(![(TKMutableSection*)section disableEditing])
	{
		TKCellView* cellView = (TKCellView*)[tableView cellForRowAtIndexPath:indexPath];
		return !cellView.preventEditing;
	}
	return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle==UITableViewCellEditingStyleDelete)
	{
        [[sections objectAtIndex:indexPath.section] removeCellAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
