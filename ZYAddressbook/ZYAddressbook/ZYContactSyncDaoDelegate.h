//
//  ZYContactSyncDelegate.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-3.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYContactSyncDao.h"

@protocol ZYContactSyncDaoDelegate <NSObject>

@property enum SyncSteps  syncStep;

@optional
-(void)syncContactSuccess:(id)delegate syncResult:(NSData *)data;
-(void)syncContactFaild:(id)delegate err:(NSString *)errMsg;

@end
