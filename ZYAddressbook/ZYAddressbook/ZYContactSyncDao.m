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
    @param delegate 回调对象
 */
-(void)syncContact:(id<ZYContactSyncDaoDelegate>)delegate {
    self->responseDelegate = delegate;
    //NSMutableArray *contactMappings = [[[ZYArchiveCache alloc]init] readCache:[ZYArchiveCache contactMappingCacheFileName]];
    NSMutableArray *contactMappings = [[NSMutableArray alloc]init];
    for (int i=0; i<10; i++) {
        ZYContactMapping *map = [[ZYContactMapping alloc]init];
        map.phoneKey = i;
        map.serverKey = i;
        map.version = [NSUUID UUID];
        map.versionDate = [NSDate date];
        map.versionType = Add;
        [contactMappings addObject:map];
    }
    NSString *json = [ZYJsonSerialization serialize:contactMappings error:nil];
    //NSLog(@"%@",json);
    NSMutableArray *returnjson = [ZYJsonSerialization deserialize:json targetType:[ZYContactMapping class] error:nil];
    ZYHttpRequest *request = [[ZYHttpRequest alloc]initWithRequestUrl:@"http://192.168.13.67/home/octest" method:@"POST" respenseDelegate:self];
    [request addParamaterFor:@"jsonParam" byValue:json];
    [request doHttpRequest];
    
//    ZYNSMutableDictionary* contacts = [[[ZYContactPeopleDao alloc]init] getAllContactPeoples];
//    NSMutableArray *contactPeoples = nil;
//    if ([contacts keyForIndex:0]) {
//        contactPeoples = contacts[0];
//    }
}

/*!
 @method httpRequestSuccess:responseData:
 @abstract 调用成功后执行方法
 @param responseData http访问返回结果
 @param userData 用户数据
 */
- (void)httpRequestSuccess:(id)delegate responseData:(NSData *)responseData {
    if (self->responseDelegate != nil ) {
        if ([self->responseDelegate respondsToSelector:@selector(syncContactSuccess:syncResult:)]) {
            [self->responseDelegate performSelector:@selector(syncContactSuccess:syncResult:) withObject:nil withObject:responseData];
        }
    }
}

/*!
 @method httpRequestFaild:err:
 @abstract 调用失败后执行方法
 @param err http访问错误信息
 @param userData 用户数据
 */
-(void)httpRequestFaild:(id)delegate err:(NSString *)errorMsg {
    if (self->responseDelegate != nil) {
        if ([self->responseDelegate respondsToSelector:@selector(syncContactFaild:err:)]) {
            [self->responseDelegate performSelector:@selector(syncContactFaild:err:) withObject:nil withObject:errorMsg];
        }
    }
}

@end
