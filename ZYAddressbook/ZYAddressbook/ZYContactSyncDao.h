//
//  ZYContactSyncDao.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-2.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYContactPeopleDao.h"

/*
    @interface ZYContactSyncDao
    同步通讯录方法
 */
@interface ZYContactSyncDao : NSObject

-(BOOL)syncContact;

@end
