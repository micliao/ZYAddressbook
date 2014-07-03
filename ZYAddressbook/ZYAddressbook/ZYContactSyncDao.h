//
//  ZYContactSyncDao.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-2.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYContactPeopleDao.h"
#import "ZYHttpRequest.h"
#import "ZYContactMapping.h"
#import "ZYContactSyncDaoDelegate.h"
#import "NSDate+NSDateExtension.h"

/*
    @interface ZYContactSyncDao
    同步通讯录方法
 */
@interface ZYContactSyncDao : NSObject<ZYHttpResponseDelegate>
{
    id<ZYContactSyncDaoDelegate> responseDelegate;
}

-(void)syncContact:(id<ZYContactSyncDaoDelegate>)delegate;

@end
