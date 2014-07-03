//
//  ZYContactSyncServiceDelegate.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-3.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZYContactSyncServiceDelegate <NSObject>

@optional
-(void)syncContactSuccess:(id)delegate syncResult:(id)data;
-(void)syncContactFaild:(id)delegate err:(NSString *)errMsg;

@end
