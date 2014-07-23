//
//  ZYPersonInfoViewController.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-23.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYPersonInfoViewController.h"
#import "ZYNoticeViewController.h"

@interface ZYPersonInfoViewController ()
{
    NSMutableArray *properties;
}
@end

@implementation ZYPersonInfoViewController

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
    properties = [[NSMutableArray alloc]initWithObjects:@"电话-移动",@"123456",@"电话-家庭",@"123456", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    switch (section) {
        case 0:
            number = 2;
            break;
        case 1:
            number = properties == nil ? 0 : ([properties count]/2);
            break;
        default:
            number = 1;
            break;
    }
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"HeadCell" forIndexPath:indexPath];
                [((UILabel*)cell.contentView.subviews[1]) setText:@"头像"];
                [((UIImageView*)cell.contentView.subviews[0]) setImage:[UIImage imageNamed:@"Avatat"]];
            }
            else {
                cell = [tableView dequeueReusableCellWithIdentifier:@"PropertyCell" forIndexPath:indexPath];
                [cell.textLabel setText:@"姓名"];
                [cell.detailTextLabel setText:@"micliao"];
            }
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"PropertyCell" forIndexPath:indexPath];
            [cell.textLabel setText:properties[indexPath.row*2]];
            [cell.detailTextLabel setText:properties[indexPath.row*2+1]];
            break;
        default:
            cell = [tableView dequeueReusableCellWithIdentifier:@"AddCell" forIndexPath:indexPath];
            break;
    }
    //[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 95;
    }
    return 44;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 1;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedCell.selected = NO;
    if (indexPath.section == 0 && indexPath.row == 0) {
        [ZYNoticeViewController showNotice:self.view showTime:3 showBottomOffset:90 noticeText:@"设置头像"];
        return;
    }
    else if (indexPath.section == 2) {
        [ZYNoticeViewController showNotice:self.view showTime:3 showBottomOffset:90 noticeText:@"添加信息"];
        return;
    }
    [ZYNoticeViewController showNotice:self.view showTime:3 showBottomOffset:90 noticeText:[NSString stringWithFormat:@"%@:%@",selectedCell.textLabel.text,selectedCell.detailTextLabel.text]];
}

@end
