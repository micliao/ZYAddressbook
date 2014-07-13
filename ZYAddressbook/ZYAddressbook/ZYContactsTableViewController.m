//
//  ZYContactsTableViewController.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-13.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYContactsTableViewController.h"

@interface ZYContactsTableViewController ()
{
    NSMutableArray *searchedContacts;
    ZYNSMutableDictionary *allContacts;
    UIBarButtonItem *syncNowButton;
    UIBarButtonItem *addButton;
}
@end

@implementation ZYContactsTableViewController

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
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self->syncNowButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(syncNow)];
    self->addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContact)];
    self.navigationItem.rightBarButtonItem = self->addButton;
    self.navigationItem.leftBarButtonItem = self->syncNowButton;
    
    ZYContactPeopleService *service = [[ZYContactPeopleService alloc]init];
    ZYNSMutableDictionary *contactPeople = [service getAllCachedContactPeoplesGroupByFirstLetter];
    if (contactPeople == nil || contactPeople.realDictionary == nil || contactPeople.realDictionary.count == 0) {
        contactPeople = [service getAllContactPeoplesGroupByFirstLetter];
        if ([contactPeople keyForIndex:0]) {
            self->allContacts = contactPeople[0];
            if (self->allContacts != nil && self->allContacts.realDictionary != nil && [self->allContacts.realDictionary count] > 0) {
                [service setContactPeoplesCache:contactPeople[0]];
            }
            else {
                [ZYNoticeViewController showNotice:self.view showTime:3 showBottomOffset:90 noticeText:@"通讯录是空的，请登录账号同步通讯录到本地"];
            }
        }
        else {
            [ZYNoticeViewController showNotice:self.view showTime:3 showBottomOffset:90 noticeText:@"未授权访问通讯录，请在系统设置里允许"];
        }
    }
    else {
        self->allContacts = contactPeople;
    }
    
//    ZYContactSyncService *syncService = [[ZYContactSyncService alloc]init];
//    [syncService syncContact:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self->searchedContacts == nil ? 0 : 1;
    }
    return self->allContacts == nil ? 0 : [[self->allContacts realDictionary] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self->searchedContacts == nil ? 0 : [self->searchedContacts count];
    }
    return [self->allContacts[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        ZYContactPeople *people = self->searchedContacts[indexPath.row];
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        [cell.textLabel setText:people.viewName];
        return cell;
    }
    else {
        ZYContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactTableCellIdentifier" forIndexPath:indexPath];
        ZYContactPeople *people = self->allContacts[indexPath.section][indexPath.row];
        [cell.lbName setText:people.viewName];
        [cell.lbDes setText:[NSString stringWithFormat:@"这是%@的心情哦❤(%i)",people.viewName,people.phoneKey]];
        return cell;
    }
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
    ABPersonViewController *personViewController = [[ABPersonViewController alloc]init];
    ABRecordRef person = ABAddressBookGetPersonWithRecordID(personViewController.addressBook, ((ZYContactPeople*)self->allContacts[indexPath.section][indexPath.row]).phoneKey);
    if (person != nil){
        personViewController.displayedPerson = person;
        [self.navigationItem.backBarButtonItem setTitle:@"返回"];
        [self.navigationController pushViewController:personViewController animated:YES];
    }
    else {
        //todo 通讯录成员不存在
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView != self.searchDisplayController.searchResultsTableView;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

//navigation bar
-(void)addContact {
    //UITableViewController *addControler = [self.storyboard instantiateViewControllerWithIdentifier:@"AddContact"];
    ABNewPersonViewController *addControler = [[ABNewPersonViewController alloc]init];
    addControler.newPersonViewDelegate = self;
    [self.navigationController pushViewController:addControler animated:YES];
}

- (void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person {
    [self.navigationItem.backBarButtonItem setTitle:@"取消"];
    [self.navigationController popToViewController:self animated:YES];
    if (person != nil) {
        
    }
}

-(void)syncNow {
    ZYContactSyncService *syncService = [[ZYContactSyncService alloc]init];
    [syncService syncContact:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
