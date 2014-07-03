//
//  ZYContactSyncService.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-2.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYContactSyncService.h"

@implementation ZYContactSyncService

-(void)syncContact:(id<ZYContactSyncServiceDelegate>)delegate {
    self->responseDelegate = delegate;
    ZYContactSyncDao *dao = [[ZYContactSyncDao alloc]init];
    [dao syncContact:self];
}

-(void)syncContactSuccess:(id)delegate syncResult:(NSData *)data {
    [self->responseDelegate syncContactSuccess:self->responseDelegate syncResult:data];
}

-(void)syncContactFaild:(id)delegate err:(NSString *)errMsg {

}

@end
