//
//  ZYContactSyncDelegate.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-3.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZYContactSyncDaoDelegate <NSObject>

@optional
-(void)syncContactSuccess:(id)delegate syncResult:(NSData *)data;
-(void)syncContactFaild:(id)delegate err:(NSString *)errMsg;

@end
