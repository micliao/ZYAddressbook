//
//  ZYNameListAddMemberViewController.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-13.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYNameListAddMemberViewController.h"

@interface ZYNameListAddMemberViewController ()
{
    ZYNSMutableDictionary *allContacts;
    NSMutableArray *addContacts;
}
@end

@implementation ZYNameListAddMemberViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(addPeople)];
    
    ZYContactPeopleService *service = [[ZYContactPeopleService alloc]init];
    ZYNSMutableDictionary *c = [service getAllContactPeoplesGroupByFirstLetterExcept:self.exsitsPeople];
    if ([c keyForIndex:0]) {
        allContacts = c[0];
    }
    addContacts = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self->allContacts == nil ? 0 : [[self->allContacts realDictionary] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self->allContacts[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self->allContacts keyForIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    for (int i=0;i<[[self->allContacts realDictionary]count];i++) {
        [titleArray addObject:[self->allContacts keyForIndex:i]];
    }
    return titleArray;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"People" forIndexPath:indexPath];
    [cell.textLabel setText:((ZYContactPeople*)allContacts[indexPath.section][indexPath.row]).viewName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
    [addContacts addObject:allContacts[indexPath.section][indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
    [addContacts removeObject:allContacts[indexPath.section][indexPath.row]];
}

-(void)addPeople {
    ZYNameListViewController *target = (ZYNameListViewController*)self.delegate;
    [target reloadData:addContacts];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
