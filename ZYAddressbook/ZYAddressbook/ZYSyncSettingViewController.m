//
//  ZYSyncSettingViewController.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-13.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYSyncSettingViewController.h"
#import "ZYSyncPropertySettingViewController.h"

@implementation ZYSyncSettingViewController

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
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedCell.selected = NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isMemberOfClass:[UITableViewCell class]]) {
        UITableViewCell* cell = (UITableViewCell*)sender;
        switch(cell.tag){
            case 0:
            case 1:
                [((ZYNameListViewController*)segue.destinationViewController).navigationItem setTitle:cell.tag == 0 ? @"白名单":@"黑名单"];
                ((ZYNameListViewController*)segue.destinationViewController).groupName = cell.tag == 0 ? @"白名单":@"黑名单";
                 ((ZYNameListViewController*)segue.destinationViewController).groupId = cell.tag == 0 ? -1:-2;
                break;
            case 4:
            case 5:
                [((ZYSyncPropertySettingViewController*)segue.destinationViewController).navigationItem setTitle:cell.tag == 4?@"推送信息设置":@"同步信息设置"];
                [((ZYSyncPropertySettingViewController*)segue.destinationViewController) setSettingType:cell.tag == 4?0:1];
                break;
                default:
                break;
        }
    }
}

@end
