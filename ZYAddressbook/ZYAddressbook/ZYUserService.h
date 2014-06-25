//
//  ZYUserService.h
//  ZYAddressbook
//
//  Created by elemeNT on 14-6-24.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYServiceDelegate.h"
#import "ZYUser.h"
#import "ZYHttpResponseDelegate.h"
#import "ZYUserDao.h"

@interface ZYUserService : NSObject<ZYServiceDelegate>

-(void)verifyUserBy:(NSString*)account password:(NSString*)password httpResponseDelagete:(id<ZYHttpResponseDelegate>)delegate;

@end
