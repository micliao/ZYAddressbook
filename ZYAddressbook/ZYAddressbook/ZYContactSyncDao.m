//
//  ZYContactSyncDao.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-2.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYContactSyncDao.h"

@implementation ZYContactSyncDao

/*!
    @method syncContact
    @abstract 同步通讯录
    @result 同步成功 返回YES 否则NO
 */
-(BOOL)syncContact {
    BOOL result = YES;
    NSMutableArray *contactMapping = [[[ZYArchiveCache alloc]init] readCache:[ZYArchiveCache contactMappingCacheFileName]];
    //NSJSONSerialization
    ZYNSMutableDictionary* contacts = [[[ZYContactPeopleDao alloc]init] getAllContactPeoples];
    NSMutableArray *contactPeoples = nil;
    if ([contacts keyForIndex:0]) {
        contactPeoples = contacts[0];
    }
    return result;
}

@end
