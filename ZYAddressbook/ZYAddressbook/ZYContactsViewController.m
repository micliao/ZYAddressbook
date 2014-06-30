//
//  ZYContactsViewController.m
//  ZYAddressbook
//
//  Created by micliao on 14-6-28.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYContactsViewController.h"

@implementation ZYContactsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //NSArray* contactPeople = [ZYContactPeople getAllContacts];
    self->allContacts = [[ZYNSMutableDictionary alloc]initWithIndexedObjects:[[NSArray alloc] initWithObjects:[[NSArray alloc]initWithObjects:@"Adeb",@"Adam",@"Acc",@"Arm",@"Apu",nil],[[NSArray alloc]initWithObjects:@"Barana",@"Bob",@"Bom",@"Bobo",@"Boy",nil],[[NSArray alloc]initWithObjects:@"Code",@"Ca",@"Coca",@"Can",@"Cab",nil],[[NSArray alloc]initWithObjects:@"Derek",@"Dam",@"Dud",@"Dom",@"Deb",nil], nil ]  forKeys:[[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"D", nil]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self->searchedContacts == nil ? 0 : [self->searchedContacts count];
    }
    return [self->allContacts[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    NSString *name;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        name = self->searchedContacts[indexPath.row];
    }
    else {
        name = self->allContacts[indexPath.section][indexPath.row];
    }
    [cell.textLabel setText:name];
    [cell.detailTextLabel setText:[@"i'm " stringByAppendingString:name]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self->searchedContacts == nil ? 0 : 1;
    }
    return [[self->allContacts realDictionary] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return @"";
    }
    return [self->allContacts keyForIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    }
    for (int i=0;i<[[self->allContacts realDictionary]count];i++) {
        [titleArray addObject:[self->allContacts keyForIndex:i]];
    }
    return titleArray;
}

//tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedCell.selected = NO;
}

//searchdisplay delegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    if(self->searchedContacts == nil) {
        self->searchedContacts = [[NSMutableArray alloc]init];
    }
    
    [self->searchedContacts removeAllObjects];
    for (NSObject *obj in [self->allContacts realDictionary]) {
        for (NSString *name in [[self->allContacts realDictionary] objectForKey:obj]) {
            if ([name containsString:searchString]) {
                [self->searchedContacts addObject:name];
            }
        }
    }
    return YES;
}

@end
