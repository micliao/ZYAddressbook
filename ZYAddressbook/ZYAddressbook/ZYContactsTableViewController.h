//
//  ZYContactsTableViewController.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-13.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYNSMutableDictionary.h"
#import "NSString+NSStringExtension.h"
#import "ZYContactPeopleService.h"
#import "ZYContactSyncService.h"
#import "ZYContactSyncServiceDelegate.h"
#import "ZYContactTableViewCell.h"
#import "ZYNoticeViewController.h"
#import <AddressBookUI/AddressBookUI.h>

@interface ZYContactsTableViewController : UITableViewController<UISearchDisplayDelegate,ZYContactSyncServiceDelegate,ABNewPersonViewControllerDelegate>

@end
