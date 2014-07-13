//
//  ZYNameListViewController.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-13.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYNameListViewController.h"

@interface ZYNameListViewController ()

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPeople)];
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

-(void)addPeople {
    ZYNameListAddMemberViewController *target = [self.storyboard instantiateViewControllerWithIdentifier:@"AddNameListView"];
    target.exsitsPeople = self.nameList;
    target.delegate = self;
    [self.navigationItem.backBarButtonItem setTitle:self.isWhiteNameList?@"白名单":@"黑名单"];
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
        [self.navigationItem setTitle:[NSString stringWithFormat:@"%@(%d)", (self.isWhiteNameList?@"白名单":@"黑名单"),(self.nameList == nil? 0 : [self.nameList count])]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"People" forIndexPath:indexPath];
    [cell.textLabel setText:((ZYContactPeople*)self.nameList[indexPath.row]).viewName];
    
    return cell;
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
