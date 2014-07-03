//
//  ZYContactSyncService.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-2.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYContactSyncDao.h"
#import "ZYContactSyncServiceDelegate.h"

@interface ZYContactSyncService : NSObject<ZYContactSyncDaoDelegate>
{
    id<ZYContactSyncServiceDelegate> responseDelegate;
}

-(void)syncContact:(id<ZYContactSyncServiceDelegate>)delegate;


@end
