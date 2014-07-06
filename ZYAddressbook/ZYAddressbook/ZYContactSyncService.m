//
//  ZYContactSyncService.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-2.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYContactSyncService.h"

@implementation ZYContactSyncService

-(void)setSyncStep:(enum SyncSteps)syncStep {
    self->contactSyncStep = syncStep;
}

-(enum SyncSteps)syncStep {
    return self->contactSyncStep;
}

-(void)syncContact:(id<ZYContactSyncServiceDelegate>)delegate {
    self->responseDelegate = delegate;
    ZYContactSyncDao *dao = [[ZYContactSyncDao alloc]init];
    [dao syncContact:self];
}

-(void)syncContactSuccess:(id)delegate syncResult:(NSData *)data {
    //[self->responseDelegate syncContactSuccess:self->responseDelegate syncResult:data];
    switch (self->contactSyncStep) {
        case SubmitContactMappings:
            //解析返回结果 包含增删改的通讯录成员信息，并返回服务器需要的成员数据
            break;
        default:
            break;
    }
}

-(void)syncContactFaild:(id)delegate err:(NSString *)errMsg {

}

@end
