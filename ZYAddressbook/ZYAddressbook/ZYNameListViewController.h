//
//  ZYNameListViewController.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-13.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYNameListAddMemberViewController.h"

@interface ZYNameListViewController : UITableViewController

@property BOOL isWhiteNameList;
@property NSMutableArray* nameList;

-(void)reloadData:(NSArray*)addContacts;

@end
