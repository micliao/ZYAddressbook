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
    
    ZYContactSyncService *syncService = [[ZYContactSyncService alloc]init];
    [syncService syncContact:self];
    
    ZYContactPeopleService *service = [[ZYContactPeopleService alloc]init];
    ZYNSMutableDictionary *contactPeople = [service getAllCachedContactPeoplesGroupByFirstLetter];
    if (contactPeople == nil || contactPeople.realDictionary == nil || contactPeople.realDictionary.count == 0) {
        contactPeople = [service getAllContactPeoplesGroupByFirstLetter];
        if ([contactPeople keyForIndex:0]) {
            self->allContacts = contactPeople[0];
            [service setContactPeoplesCache:contactPeople[0]];
        }
    }
    else {
        self->allContacts = contactPeople;
    }
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
    ZYContactPeople *people;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        people = self->searchedContacts[indexPath.row];
    }
    else {
        people = self->allContacts[indexPath.section][indexPath.row];
    }
    [cell.textLabel setText:people.viewName];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"my key: %i",people.phoneKey]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self->searchedContacts == nil ? 0 : 1;
    }
    return self->allContacts == nil ? 0 : [[self->allContacts realDictionary] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return @"";
    }
    return [self->allContacts keyForIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    }
    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
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
    else {
        [self->searchedContacts removeAllObjects];
    }
    for (NSObject *obj in [self->allContacts realDictionary]) {
        for (ZYContactPeople *people in [[self->allContacts realDictionary] objectForKey:obj]) {
            if ([people isContains:searchString]) {
                [self->searchedContacts addObject:people];
            }
        }
    }
    return YES;
}

@end
