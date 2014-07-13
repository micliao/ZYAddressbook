//
//  ZYNameListAddMemberViewController.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-13.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYContactPeopleService.h"
#import "ZYNameListViewController.h"

@interface ZYNameListAddMemberViewController : UITableViewController

@property NSMutableArray *exsitsPeople;
@property(weak) id delegate;

@end
