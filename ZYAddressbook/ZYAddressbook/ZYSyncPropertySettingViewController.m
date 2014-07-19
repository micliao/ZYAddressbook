//
//  ZYSyncPropertySettingViewController.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-19.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYSyncPropertySettingViewController.h"
#import "ZYContactInfo.h"

@interface ZYSyncPropertySettingViewController ()
{
    NSMutableArray *properties;
}
@end

@implementation ZYSyncPropertySettingViewController

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
    
    ZYContactInfo *c1 = [[ZYContactInfo alloc]init];
    c1.propertyName = @"头像";
    ZYContactInfo *c2 = [[ZYContactInfo alloc]init];
    c2.propertyName = @"电话-移动";
    c2.propertyValue = @"13400000000";
    ZYContactInfo *c3 = [[ZYContactInfo alloc]init];
    c3.propertyName = @"电话-家庭";
    c3.propertyValue = @"08162345678";
    ZYContactInfo *c4 = [[ZYContactInfo alloc]init];
    c4.propertyName = @"QQ";
    c4.propertyValue = @"12345678";
    properties = [[NSMutableArray alloc]initWithObjects:c1,c2,c3,c4, nil];
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
    return properties.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SyncProperty" forIndexPath:indexPath];
    ZYContactInfo *property = (ZYContactInfo*)properties[indexPath.row];
    [cell.textLabel setText:property.propertyName];
    if (property.propertyValue != nil) {
        [cell.detailTextLabel setText:(NSString*)property.propertyValue];
    }
    cell.selected = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    [selectedCell setAccessoryType:selectedCell.accessoryType == UITableViewCellAccessoryCheckmark ? UITableViewCellAccessoryNone : UITableViewCellAccessoryCheckmark];
    [selectedCell setSelected:NO];
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
