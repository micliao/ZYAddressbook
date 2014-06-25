//
//  ZYUserDao.h
//  ZYAddressbook
//
//  Created by elemeNT on 14-6-24.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYDaoDelegate.h"
#import "ZYUser.h"
#import "ZYHttpRequest.h"
#import "ZYHttpResponseDelegate.h"

@interface ZYUserDao : NSObject<ZYDaoDelegate>

-(void)verifyUserBy:(NSString*)account password:(NSString*)password httpResponseDelagete:(id<ZYHttpResponseDelegate>)delegate;

@end
