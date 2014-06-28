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
    self->allContacts = [[NSArray alloc] initWithObjects:@"Adeb",@"Adam",@"Acc",@"Arm",@"Apu",@"Barana",@"Bob",@"Bom",@"Bobo",@"Boy",@"Code",@"Ca",@"Coca",@"Can",@"Cab",@"Deb",@"Derek",@"Dam",@"Dud",@"Dom", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    [cell.textLabel setText:self->allContacts[indexPath.section*5 + indexPath.row]];
    [cell.detailTextLabel setText:[@"i'm " stringByAppendingString:cell.textLabel.text]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *headerTitle;
    switch (section) {
        case 0:
            headerTitle = @"A";
            break;
        case 1:
            headerTitle = @"B";
            break;
        case 2:
            headerTitle = @"C";
            break;
        case 3:
            headerTitle = @"D";
            break;
        default:
            headerTitle = @"";
            break;
    }
    return headerTitle;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"D", nil];
}

//tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedCell.selected = NO;
}

//searchdisplay delegate

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {

}

@end
