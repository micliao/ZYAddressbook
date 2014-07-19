//
//  ZYGroupsViewController.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-16.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYGroupsViewController.h"
#import "ZYNoticeViewController.h"
#import "ZYNameListAddMemberViewController.h"
#import "ZYNameListViewController.h"

@interface ZYGroupsViewController ()
{
    NSArray *manageGroupBtns;
    NSMutableArray *saveGroupBtns;
    
    NSMutableArray *groups;
    UIView *addView;
    
    int state;//0 正常 1新增 -1删除
}
@end

@implementation ZYGroupsViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    groups = [[NSMutableArray alloc]init];
    state = 0;
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroup)];
    UIBarButtonItem *delBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteGroup)];
    manageGroupBtns = [[NSArray alloc]initWithObjects:addBtn,delBtn, nil];
    self.navigationItem.rightBarButtonItems = manageGroupBtns;
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
    if (state == -1) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (state == -1) {
        [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else {
        ZYNameListViewController *memberView = [self.storyboard instantiateViewControllerWithIdentifier:@"NameListView"];
        [memberView.navigationItem setTitle:((ZYGroup*)groups[indexPath.row]).name];
        memberView.groupName = memberView.navigationItem.title;
        [self.navigationController pushViewController:memberView animated:YES];
        [selectedCell setSelected:NO animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (state == -1) {
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
    }
}

#pragma mark- group manage
-(NSMutableArray*)saveGroupBtns {
    if (saveGroupBtns == nil) {
        UIBarButtonItem *addDoneBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(manageGroupDone)];
        UIBarButtonItem *addCancelBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(manageGroupCancel)];
        saveGroupBtns = [[NSMutableArray alloc]initWithObjects:addDoneBtn,addCancelBtn, nil];
    }
    return saveGroupBtns;
}

-(void)addGroup {
    if (addView == nil) {
        addView = [[UIView alloc]initWithFrame:CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height, self.view.frame.size.width, 44)];
        addView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        UITextField *txtGroupName = [[UITextField alloc]initWithFrame:CGRectMake(10, 7, self.view.frame.size.width-20, 30)];
        [txtGroupName setBorderStyle:UITextBorderStyleRoundedRect];
        [txtGroupName setPlaceholder:@"分组名称"];
        txtGroupName.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [addView addSubview:txtGroupName];
        [addView setBackgroundColor:[UIColor grayColor]];
        [self.view addSubview:addView];
    }
    [addView setHidden:NO];
    [self.navigationItem setTitle:@"新增分组"];
    self.navigationItem.rightBarButtonItems = [self saveGroupBtns];
    state = 1;
    [UIView animateWithDuration:0.2 animations:^{
        [addView setFrame:CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height+self.navigationController.navigationBar.frame.size.height, addView.frame.size.width, 44)];
    } completion:^(BOOL finished) {
        [addView.subviews[0] becomeFirstResponder];
    }];
}

-(void)deleteGroup {
    [self.navigationItem setTitle:@"删除分组"];
    self.navigationItem.rightBarButtonItems = [self saveGroupBtns];
    state = -1;
    [self.groupTable reloadData];
}

-(void)manageGroupDone {
    if (state == 1) {
        [self saveAddGroup];
    }
    else {
        [self saveDeleteGroups];
    }
}

-(void)saveAddGroup {
    UITextField* txtName = (UITextField*)addView.subviews[0];
    [txtName resignFirstResponder];
    NSString *groupName = [txtName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (groupName == nil || [groupName length] == 0) {
        [ZYNoticeViewController showNotice:self.view showTime:3 showBottomOffset:40 noticeText:@"分组名称不能为空，请重设分组名称"];
        return;
    }
    if ([self checkGroupNameExist:groupName]) {
        [ZYNoticeViewController showNotice:self.view showTime:3 showBottomOffset:40 noticeText:@"分组已存在，请重设分组名称"];
        return;
    }
#warning 保存分组
    ZYGroup *newGroup = [[ZYGroup alloc]init];
    newGroup.name = groupName;
    if (groups == nil) {
        groups = [[NSMutableArray alloc]init];
    }
    [groups addObject:newGroup];
    [self.groupTable reloadData];
    [self cancelAdd];
}

-(BOOL)checkGroupNameExist:(NSString*)name {
    if (groups == nil || [groups count] == 0) {
        return NO;
    }
    for (ZYGroup *group in groups) {
        if ([group.name isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

-(void)saveDeleteGroups {
    if ([self.groupTable indexPathsForSelectedRows] != nil && [[self.groupTable indexPathsForSelectedRows] count] > 0) {
        for (NSIndexPath *indexPath in [[self.groupTable indexPathsForSelectedRows] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
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
        }]) {
            [groups removeObjectAtIndex:indexPath.row];
        }
        [self.groupTable deleteRowsAtIndexPaths:[self.groupTable indexPathsForSelectedRows] withRowAnimation:UITableViewRowAnimationFade];
    }
    [self cancelDelete];
}

-(void)manageGroupCancel {
    if (state == 1) {
        [self cancelAdd];
    }
    else {
        [self cancelDelete];
    }
}

-(void)cancelDelete {
    [self.navigationItem setTitle:@"分组"];
    self.navigationItem.rightBarButtonItems = manageGroupBtns;
    state = 0;
    if ([self.groupTable indexPathsForSelectedRows] != nil && [[self.groupTable indexPathsForSelectedRows] count] > 0) {
        for (NSIndexPath *indexPath in [self.groupTable indexPathsForSelectedRows]) {
            UITableViewCell *selectedCell = [self.groupTable cellForRowAtIndexPath:indexPath];
            [selectedCell setSelected:NO animated:YES];
            [selectedCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
    }
}

-(void)cancelAdd {
    [self.navigationItem setTitle:@"分组"];
    self.navigationItem.rightBarButtonItems = manageGroupBtns;
    [UIView animateWithDuration:0.2 animations:^{
        [addView setFrame:CGRectMake(0, -44, 320, 44)];
    } completion:^(BOOL finished) {
        [addView setHidden:YES];
        [((UITextField*)addView.subviews[0]) setText:@""];
        [((UITextField*)addView.subviews[0]) resignFirstResponder];
        state = 0;
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
