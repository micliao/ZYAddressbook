//
//  ZYGroupsViewController.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-16.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYGroupsViewController.h"

@interface ZYGroupsViewController ()
{
    UIBarButtonItem *addBtn;
    UIBarButtonItem *delBtn;
    NSMutableArray *addGroupBtns;
    
    NSMutableArray *groups;
    
    UIView *addView;
}
@end

@implementation ZYGroupsViewController

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
    
    groups = [[NSMutableArray alloc]init];
    
    addBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroup)];
    self.navigationItem.rightBarButtonItem = addBtn;
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
    return groups == nil ? 0 : [groups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell" forIndexPath:indexPath];
    [cell.textLabel setText:((ZYGroup*)groups[indexPath.row]).name];
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
    if (self.navigationItem.rightBarButtonItem == addBtn) {
        if (delBtn == nil) {
            delBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteGroup)];
        }
        self.navigationItem.rightBarButtonItem = delBtn;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
    if ([self.tableView indexPathsForSelectedRows] == nil || [[self.tableView indexPathsForSelectedRows] count] == 0) {
        self.navigationItem.rightBarButtonItem = self->addBtn;
    }
}

#pragma mark- group manage
-(void)addGroup {
    if (addGroupBtns == nil) {
        UIBarButtonItem *addDoneBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(addGroupDone)];
        UIBarButtonItem *addCancelBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(addGroupCancel)];
        addGroupBtns = [[NSMutableArray alloc]initWithObjects:addDoneBtn,addCancelBtn, nil];
    }
    if (addView == nil) {
        addView = [[UIView alloc]initWithFrame:CGRectMake(0, -44, 320, 44)];
        [addView setBackgroundColor:[UIColor yellowColor]];
        [self.view addSubview:addView];
    }
    [addView setHidden:NO];
    [self.navigationItem setTitle:@"新增分组"];
    self.navigationItem.rightBarButtonItems = addGroupBtns;
    [UIView animateWithDuration:0.2 animations:^{
        [addView setFrame:CGRectMake(0, 0, 320, 44)];
    }];
}

-(void)deleteGroup {

}

-(void)addGroupDone {
     [self hideAddView];
}

-(void)addGroupCancel {
    [self hideAddView];
}

-(void)hideAddView {
    [self.navigationItem setTitle:@"分组"];
    self.navigationItem.rightBarButtonItems = [[NSArray alloc]initWithObjects:addBtn, nil];
    [UIView animateWithDuration:0.2 animations:^{
        [addView setFrame:CGRectMake(0, -44, 320, 44)];
    } completion:^(BOOL finished) {
        [addView setHidden:YES];
    }];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
