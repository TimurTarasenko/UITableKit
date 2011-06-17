//
//  TKSection.m
//
//  Created by Sergey Nikitenko on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TKSection.h"
#import "TKCell.h"

@implementation TKSection
@synthesize headerHeight, headerTitle, headerView, footerHeight, footerTitle, footerView;

+(TKSection*) sectionWithCells: (TKCell*)cell, ...
{
	TKSection* section = [[[TKSection alloc] init] autorelease];
	
	if(cell)
	{
		[section addCell:cell];
        
		va_list args;
		va_start(args,cell);
        
		while( (cell = va_arg(args, TKCell*)) )
		{
			[section addCell:cell];
		}
        
		va_end(args);
	}
	return section;
}

-(id) init
{
    self = [super init];
    if(self)
	{
        cells = [[NSMutableArray alloc] init];
        headerHeight = 44;
        footerHeight = 44;
    }
    return self;
}

-(void) dealloc
{
    [cells release];
    [headerTitle release];
    [headerView release];
    [footerTitle release];
    [footerView release];
    [super dealloc];
}


-(void) addCell:(TKCell*)cellHolder
{
    [cells addObject:cellHolder];
}

-(void) removeCellAtIndex:(int)cellIndex
{
    [cells removeObjectAtIndex:cellIndex];
}

-(void) removeAllCells
{
	[cells removeAllObjects];
}

-(TKCell*) cellAtIndex:(int)cellIndex
{
    return [cells objectAtIndex:cellIndex];
}

-(void) insertCell:(TKCell*)cell atIndex:(int)cellIndex
{
    [cells insertObject:cell atIndex:cellIndex];
}

-(int) cellCount
{
    return [cells count];
}

-(UITableViewCell*) cellWithIndex:(int)cellIndex forTableView:(UITableView*)tableView
{
    TKCell* cellHolder = [cells objectAtIndex:cellIndex];
    return [cellHolder cellForTableView:tableView];
}

-(CGFloat) heightForCellIndex:(int)cellIndex
{
    TKCell* cellHolder = [cells objectAtIndex:cellIndex];
    return [cellHolder cellHeight];
}

-(void) tableView:(UITableView*)tableView didSelectCellWithIndex:(int)cellIndex
{
    TKCell* cellHolder = [cells objectAtIndex:cellIndex];
    [cellHolder tableViewDidSelectCell:tableView];
}


@end