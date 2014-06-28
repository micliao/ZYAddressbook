//
//  ZYContactsViewController.h
//  ZYAddressbook
//
//  Created by micliao on 14-6-28.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYContactsViewController : UIViewController <UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray *allContacts;
    NSArray *searchedContacts;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *header;
@end
