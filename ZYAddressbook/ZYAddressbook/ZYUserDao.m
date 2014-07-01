//
//  ZYUserDao.m
//  ZYAddressbook
//
//  Created by elemeNT on 14-6-24.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYUserDao.h"

@implementation ZYUserDao

-(int)insert:(ZYUser*)user{
    return 0;
}

-(void)delete:(ZYUser*)user{
    
}

-(int)update:(ZYUser*)user{
    return 0;
}

-(ZYUser*)select:(int)ID{
    return nil;
}

/*!
 @method verifyUserBy:password:httpResponseDelagete:
 @abstract 验证用户登录信息
 @param account 账号或email
 @param password 密码
 @param delegate http请求回调
 */
-(void)verifyUserBy:(NSString*)account password:(NSString*)password httpResponseDelagete:(id<ZYHttpResponseDelegate>)delegate {
    ZYHttpRequest* request = [[ZYHttpRequest alloc] initWithRequestUrl:@"http://192.168.13.12/time.php" method:@"POST" respenseDelegate:delegate];
    //[request addParamaterFor:@"account" byValue:account];
    //[request addParamaterFor:@"password" byValue:password];
    [request addParamaterFor:@"t" byValue:password];
    [request doHttpRequest];
}

@end
