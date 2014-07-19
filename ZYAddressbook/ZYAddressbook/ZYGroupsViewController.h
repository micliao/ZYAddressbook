//
//  ZYGroupsViewController.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-16.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYGroup.h"

@interface ZYGroupsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *groupTable;

@end
