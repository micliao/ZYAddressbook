//
//  ZYNameListViewController.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-13.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYNameListViewController.h"

@interface ZYNameListViewController ()
{
    UIBarButtonItem *addBtn;
    UIBarButtonItem *delBtn;
}
@end

@implementation ZYNameListViewController

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
    
    self->addBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPeople)];
    self.navigationItem.rightBarButtonItem = self->addBtn;
    self.nameList = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nameList == nil ? 0 : self.nameList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"People" forIndexPath:indexPath];
    [cell.textLabel setText:((ZYContactPeople*)self.nameList[indexPath.row]).viewName];
    cell.selected = NO;
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView != self.searchDisplayController.searchResultsTableView;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
    if (self.navigationItem.rightBarButtonItem == self->addBtn) {
        if (self->delBtn == nil) {
           self->delBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deletePelple)];
        }
        self.navigationItem.rightBarButtonItem = self->delBtn;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
    if ([self.tableView indexPathsForSelectedRows] == nil || [[self.tableView indexPathsForSelectedRows] count] == 0) {
        self.navigationItem.rightBarButtonItem = self->addBtn;
    }
}

#pragma mark - people manage
-(void)addPeople {
    ZYNameListAddMemberViewController *target = [self.storyboard instantiateViewControllerWithIdentifier:@"AddNameListView"];
    target.exsitsPeople = self.nameList;
    target.delegate = self;
    [self.navigationItem.backBarButtonItem setTitle:self.groupName];
    [self.navigationController pushViewController:target animated:YES];
}

-(void)reloadData:(NSArray*)addContacts {
    if (addContacts != nil && [addContacts count] > 0) {
        [self.nameList addObjectsFromArray:addContacts];
        self.nameList = [[NSMutableArray alloc] initWithArray:[self.nameList sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            ZYContactPeople *peo1 = (ZYContactPeople*)obj1;
            ZYContactPeople *peo2 = (ZYContactPeople*)obj2;
            return [[peo1 nameLetters] compare:[peo2 nameLetters]];
        }]];
        [self.tableView reloadData];
        [self.navigationItem setTitle:[NSString stringWithFormat:@"%@(%d)", self.groupName,(self.nameList == nil? 0 : [self.nameList count])]];
    }
}

-(void)deletePelple {
    if ([self.tableView indexPathsForSelectedRows] != nil && [[self.tableView indexPathsForSelectedRows] count] > 0) {
        NSArray *peoples = [[self.tableView indexPathsForSelectedRows] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSInteger o1 = ((NSIndexPath*)obj1).row;
            NSInteger o2 = ((NSIndexPath*)obj2).row;
            if (o1 == o2) {
                return NSOrderedSame;
            }
            else if (o1 > o2) {
                return NSOrderedAscending;
            }
            else {
                return NSOrderedDescending;
            }
        }];
        for (NSIndexPath *indexPath in peoples) {
            [self.nameList removeObjectAtIndex:indexPath.row];
        }
        [self.tableView deleteRowsAtIndexPaths:[self.tableView indexPathsForSelectedRows] withRowAnimation:UITableViewRowAnimationFade];
    }
    self.navigationItem.rightBarButtonItem = self->addBtn;
    [self.navigationItem setTitle:[NSString stringWithFormat:@"%@(%d)", self.groupName,(self.nameList == nil? 0 : [self.nameList count])]];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
@end
