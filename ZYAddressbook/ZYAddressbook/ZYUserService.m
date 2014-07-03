//
//  ZYUserService.m
//  ZYAddressbook
//
//  Created by elemeNT on 14-6-24.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYUserService.h"

@implementation ZYUserService

-(BOOL)add:(ZYUser*)user{
    return YES;
}

-(BOOL)drop:(ZYUser*)user{
    return YES;
}

-(BOOL)modify:(ZYUser*)user{
    return YES;
}

-(ZYUser*)get:(int)ID{
    return  nil;
}

/*!
    @method verifyUserBy:password:httpResponseDelagete:
    @abstract 验证用户登录信息
    @param account 账号或email
    @param password 密码
    @param delegate http请求回调
 */
-(void)verifyUserBy:(NSString*)account password:(NSString*)password httpResponseDelagete:(id<ZYHttpResponseDelegate>)delegate {
    if (account.length == 0 || password.length == 0) {
        if ([delegate respondsToSelector:@selector(httpRequestFaild:err:)]) {
            [delegate httpRequestFaild:nil err:@"账号密码不能为空"];
        }
    }
    else {
        ZYUserDao* userDao = [[ZYUserDao alloc] init];
        [userDao verifyUserBy:account password:password httpResponseDelagete:delegate];
    }
}

@end
