//
//  RootViewController.m
//  TableKitSample
//
//  Created by onegray on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "EditingSampleViewController.h"
#import "AttributesSampleViewController.h"
#import "ThemeSampleViewController.h"
#import "HugeTableSampleViewController.h"
#import "ReminderSampleViewController.h"
#import "DataSourceSampleViewController.h"
#import "ModelSampleViewController.h"
#import "NibSampleViewController.h"
#import "TKSection.h"
#import "TKActionCell.h"


@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	if(self.sections==nil)
	{
		TKActionCell* attributesSampleCell = [TKActionCell cellWithText:@"Attributes Sample" target:self action:@selector(onAttributesSampleCell)];
		attributesSampleCell.tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

		TKActionCell* editingSampleCell = [TKActionCell cellWithText:@"Editing Sample" target:self action:@selector(onEditingSampleCell)];
		editingSampleCell.tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

		TKActionCell* themeSampleCell = [TKActionCell cellWithText:@"Custom Theme Sample" target:self action:@selector(onCustomThemeSampleCell)];
		themeSampleCell.tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

		TKActionCell* reminderSampleCell = [TKActionCell cellWithText:@"Reminder Theme Sample" target:self action:@selector(onReminderThemeSampleCell)];
		reminderSampleCell.tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

		TKActionCell* hugeTableSampleCell = [TKActionCell cellWithText:@"Huge Table Sample" target:self action:@selector(onHugeTableSampleCell)];
		hugeTableSampleCell.tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

		TKActionCell* dataSourceSampleCell = [TKActionCell cellWithText:@"Custom DataSource Sample" target:self action:@selector(onDataSourceTableSampleCell)];
		dataSourceSampleCell.tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

		TKActionCell* modelSampleCell = [TKActionCell cellWithText:@"Model Cell Sample" target:self action:@selector(onModelSampleCell)];
		modelSampleCell.tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

		TKActionCell* nibSampleCell = [TKActionCell cellWithText:@"Nib Cell Sample" target:self action:@selector(onNibSampleCell)];
		nibSampleCell.tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

		TKSection* section = [TKSection sectionWithCells:attributesSampleCell, editingSampleCell, themeSampleCell,
							  reminderSampleCell, hugeTableSampleCell, dataSourceSampleCell, modelSampleCell, nibSampleCell, nil];
		self.sections = [NSArray arrayWithObjects:section, nil];
	}
}

-(void) onAttributesSampleCell 
{
	AttributesSampleViewController* vc = [[AttributesSampleViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[self.navigationController pushViewController:vc animated:YES];
}

-(void) onEditingSampleCell 
{
	EditingSampleViewController* vc = [[EditingSampleViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[self.navigationController pushViewController:vc animated:YES];
}

-(void) onCustomThemeSampleCell 
{
	ThemeSampleViewController* vc = [[ThemeSampleViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[self.navigationController pushViewController:vc animated:YES];
}

-(void) onReminderThemeSampleCell 
{
	ReminderSampleViewController* vc = [[ReminderSampleViewController alloc] initWithNibName:nil bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
}

-(void) onHugeTableSampleCell 
{
	HugeTableSampleViewController* vc = [[HugeTableSampleViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[self.navigationController pushViewController:vc animated:YES];
}

-(void) onDataSourceTableSampleCell 
{
	DataSourceSampleViewController* vc = [[DataSourceSampleViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[self.navigationController pushViewController:vc animated:YES];
}

-(void) onModelSampleCell
{
	ModelSampleViewController* vc = [[ModelSampleViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[self.navigationController pushViewController:vc animated:YES];
}

-(void) onNibSampleCell
{
	NibSampleViewController* vc = [[NibSampleViewController alloc] initWithNibName:@"NibSampleViewController" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
