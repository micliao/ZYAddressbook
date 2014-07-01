//
//  ZYContactPeopleDao.h
//  ZYAddressbook
//
//  Created by micliao on 14-6-30.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYDaoDelegate.h"
#import "ZYContactPeople.h"
#import <AddressBook/AddressBook.h>
#import "ZYArchiveCache.h"

@interface ZYContactPeopleDao : NSObject<ZYDaoDelegate>

-(ZYNSMutableDictionary*)getAllContactPeoples;
-(NSMutableArray*)getAllCachedContactPeoples;
-(void)setContactPeoplesCache:(NSMutableArray*)contactPeoples;
@end
